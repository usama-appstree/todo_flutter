import 'package:dribble_ui/gen_models/todo.dart';
import 'package:dribble_ui/pages/todo_detail_page.dart';
import 'package:dribble_ui/state/todo_bloc.dart';
import 'package:dribble_ui/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';

class TodoItemWidget extends StatefulWidget {
  const TodoItemWidget({
    Key? key,
    required this.barColor,
    required this.bloc,
    // this.todoTitle,
    // this.todoDescription,
    required this.todo,
  }) : super(key: key);
  final Color barColor;
  // final String? todoTitle;
  // final String? todoDescription;
  final Todo todo;
  final TodoBloc bloc;

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setColorBarHeight();
  }

  final expansionTileKey = GlobalKey();
  double expansionTileHeight = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.all(2),
            // padding: const EdgeInsets.all(16),
            height: expansionTileHeight,
            width: 05,
            decoration: BoxDecoration(
              color: widget.barColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: GestureDetector(
            onLongPress: () async {
              await showModalBottomSheet(
                context: context,
                builder: (context) {
                  return BottomSheetWidget(
                    bloc: widget.bloc,
                    controller: controller,
                    todo: widget.todo,
                  );
                },
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                ),
              );
            },
            child: NotificationListener<SizeChangedLayoutNotification>(
              onNotification: (notification) {
                setColorBarHeight();
                return true;
              },
              child: SizeChangedLayoutNotifier(
                child: ExpansionTile(
                  // onExpansionChanged: (value) => setState(() {}),
                  collapsedTextColor: Colors.black,
                  textColor: Colors.black,
                  initiallyExpanded: true,
                  key: expansionTileKey,
                  title: Text(
                    widget.todo.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    widget.todo.description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      // provider.changeStatus(widget.todo.id);
                      widget.bloc.changeStatusOfTodo(widget.todo);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        shape: BoxShape.circle,
                        color: (widget.todo.isDone)
                            ? const Color.fromARGB(255, 91, 199, 248)
                            : Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            // Color.fromARGB(255, 91, 199, 248)
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: (widget.todo.isDone)
                          ? const Icon(
                              Icons.done,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      (widget.todo.isFavourite)
                          ? Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromARGB(255, 255, 236, 201),
                              ),
                              child: const Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 255, 180, 58),
                              ),
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                TodoDetailPage(todo: widget.todo),
                          ));
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(255, 255, 236, 201),
                          ),
                          child: const Icon(
                            Icons.open_in_new,
                            color: Color.fromARGB(255, 255, 180, 58),
                          ),
                        ),
                      ),
                    ],
                  ),
                  childrenPadding: EdgeInsets.only(left: size.width * 0.1),
                  children: widget.todo.childTodos.map((e) {
                    return ListTile(
                      leading: Checkbox(
                          value: e.isDone,
                          onChanged: (value) async {
                            await widget.bloc.changeChildTodoStatus(
                              widget.todo,
                              e,
                            );
                          }),
                      title: Text(e.name),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void setColorBarHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box =
          expansionTileKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        expansionTileHeight = box.size.height;

        setState(() {});
      }
    });
  }
}
