// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dribble_ui/gen_models/todo.dart';
import 'package:flutter/material.dart';

class TodoDetailPage extends StatelessWidget {
  const TodoDetailPage({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.15,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  margin: EdgeInsets.all(
                    constraints.maxWidth * .05,
                  ),
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 255, 236, 201),
                  ),
                  child: Text(todo.name),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.height * .001,
              horizontal: size.width * .05,
            ),
            child: const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ac arcu non neque venenatis bibendum eu vel tellus. Donec scelerisque arcu ac ante finibus egestas. Suspendisse sit amet sodales augue. Vivamus nisi eros, consequat in blandit a, ultricies vitae est. Pellentesque quis augue at magna vestibulum blandit. Nulla id lacus imperdiet, scelerisque leo ac, pulvinar nisl. Fusce tellus purus, fringilla et ante quis, fringilla sodales est. Integer pellentesque sapien non blandit pellentesque. Cras mattis lorem at accumsan tempor. Vestibulum rutrum semper imperdiet. Nunc odio massa, ullamcorper id rutrum non, porttitor quis dolor. Aliquam arcu diam, tempus id porta nec, gravida tempus est. Nam consequat consequat odio, quis tempor nunc ullamcorper non. Donec fringilla dolor vitae ipsum commodo volutpat. Praesent aliquam et massa et pretium.',
              // style: TextStyle(color: Colors.amber),
            ),
          )
        ],
      ),
    );
  }
}
