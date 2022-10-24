// import 'package:dribble_ui/models/todo.dart';
// import 'package:dribble_ui/models/todo_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dribble_ui/gen_models/todo.dart';
import 'package:dribble_ui/state/todo_bloc.dart';
import 'package:dribble_ui/utils/contants.dart';
import 'package:dribble_ui/widgets/todo_item_widget.dart';
import 'package:dribble_ui/widgets/todo_text_field.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// const _maxTriesUponAdLoadingFailed = 3;

class HomePageBloc extends StatefulWidget {
  const HomePageBloc({super.key});

  @override
  State<HomePageBloc> createState() => _HomePageBlocState();
}

class _HomePageBlocState extends State<HomePageBloc> {
  final controller = TextEditingController();

  late TodoBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = TodoBloc();
    bloc.fetchAllTodosFromFirebase();
    // createBottomBannerAd();
    // createInlineBannerAd();
    // createInterstitialAd();
  }

  @override
  void dispose() {
    controller.dispose();
    // _bottomBannerAd.dispose();
    // _inlineBannerAd.dispose();
    // _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // persistentFooterButtons: [
      //   if (_isBottomAdLoaded)
      //     Center(
      //       child: SizedBox(
      //         height: _bottomBannerAd.size.height.toDouble(),
      //         width: _bottomBannerAd.size.width.toDouble(),
      //         child: AdWidget(ad: _bottomBannerAd),
      //       ),
      //     )
      // ],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'TODAY',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'January 28',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
              size: 16,
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: StreamBuilder<List<Todo>>(
              initialData: bloc.listOfTodos,
              stream: bloc.streamOfTodos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active &&
                    snapshot.hasData) {
                  final todos = snapshot.data;
                  return ListView.builder(
                    itemCount: (todos?.length ?? 0) + 1,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemBuilder: ((context, index) {
                      if (index == todos!.length) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TodoTextField(
                            controller: controller,
                            addTodo: addTodo,
                            hintText: 'Add a new Todo',
                          ),
                        );
                      }
                      final color = randomColors[index % randomColors.length];
                      return TodoItemWidget(
                        bloc: bloc,
                        barColor: color,
                        todo: todos[index],
                      );
                    }),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addTodo() async {
    if (mounted) {
      if (controller.text.isNotEmpty) {
        final todo = Todo(
          id: const Uuid().v4(),
          name: controller.text,
        );
        bloc.addTodo(todo);
        // context.read<TodoProvider>().addTodo(todo);
        controller.text = '';
        FocusScope.of(context).unfocus();
      }
    }
  }
}
