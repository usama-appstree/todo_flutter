import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dribble_ui/gen_models/child_todo.dart';
import 'package:dribble_ui/gen_models/todo.dart';
// import 'package:dribble_ui/models/todo_item.dart';
import 'package:dribble_ui/repository/remote_database.dart';
// import 'package:dribble_ui/state/todo_provider.dart';

// final todoBloc = TodoBloc();

abstract class BlocBase {
  Future<void> dispose();
}

class TodoBloc extends BlocBase {
  TodoBloc({RemoteDatabase? database})
      : _database = database ?? RemoteDatabase(FirebaseFirestore.instance);

  final RemoteDatabase _database;

  List<Todo> _listOfTodos = [];
  List<Todo> get listOfTodos => _listOfTodos;

  final StreamController<List<Todo>> _todoController =
      StreamController<List<Todo>>.broadcast();
  final StreamController<List<Todo>> _childTodoController =
      StreamController<List<Todo>>.broadcast();
  // final StreamController<Todo> _controllerTodo =
  //     StreamController<Todo>.broadcast();
  Stream<List<Todo>> get streamOfTodos {
    initializeTodos();
    return _todoController.stream;
  }

  void initializeTodos() {
    _listOfTodos = _database.getAllTodosFromFirebase();
    _todoController.add(_listOfTodos);
  }

  Sink<List<Todo>> get _sinkTodos => _todoController.sink;

  // Sink<Todo> get _sinkTodo => _controller.sink;
  Future<void> addTodo(Todo todo) async {
    _sinkTodos.add(_listOfTodos..add(todo));
    try {
      await _database.addTodoToFirebase(todo);
    } on FirebaseException {
      rethrow;
    }
  }

  // Stream<QuerySnapshot<Todo>> get getAllTodos {
  //   return _database.todos().snapshots();
  // }

  // StreamSubscription<QuerySnapshot<Todo>> get getAllTodoss {
  //   return todosSubscription =
  //       _database._todosCollection().snapshots().listen((event) {
  //     _listOfTodosSnapshots = event.docs;
  //   });
  // }

  Future<void> addChildTodo(String id, ChildTodo childItem) async {
    final todos =
        _listOfTodos[_listOfTodos.indexWhere((todo) => todo.id == id)];
    _listOfTodos = [
      todos.copyWith(childTodos: [
        ...todos.childTodos,
        childItem,
      ])
    ];
    // .todoItemList
    // .add(todoItem);
    _todoController.add(_listOfTodos);

    try {
      // _database.todos().doc(id).set()
    } catch (e) {}
  }
  // void addNestedTodo(String id, TodoItem nestedTodo) {
  //   _listOfTodos = [
  //     for (final todo in listOfTodos)
  //       if (todo.todoItem.id == id)
  //         todo.copyWith(
  //           todoItemList: [
  //             ...todo.todoItemList,
  //             nestedTodo,
  //           ],
  //         )
  //       // Todo(
  //       //   todoItem: TodoItem(
  //       //     id: todo.todoItem.id,
  //       //     name: todo.todoItem.name,
  //       //     isDone: todo.todoItem.isDone,
  //       //     description: todo.todoItem.description,
  //       //     isFavourite: todo.todoItem.isFavourite,
  //       //   ),
  //       //   todoItemList: todo.todoItemList..add(nestedTodo),
  //       // )
  //       else
  //         todo
  //   ];
  //   _todoController.add(_listOfTodos);
  //   // notifyListeners();
  // }

  void changeChildTodoStatus(String mainID, String itemID) {
    // var main = _listOfTodos[
    //     _listOfTodos.indexWhere((element) => element.todoItem.id == mainID)];

    // var nestedItem = main.todoItemList[
    //     main.todoItemList.indexWhere((element) => element.id == itemID)];

    // _listOfTodos.forEach((element) {
    //   element.todoItemList.forEach((element) {});
    // });

    _listOfTodos = [
      for (final todo in _listOfTodos)
        if (todo.id == mainID)
          todo.copyWith(
            childTodos: [
              for (final todoItem in todo.childTodos)
                if (todoItem.id == itemID)
                  todoItem.copyWith(
                    isDone: !todoItem.isDone,
                  )
                else
                  todoItem
            ],
          )
        else
          todo
    ];
    _todoController.add(_listOfTodos);
  }

  void changeStatus(String id) {
    _listOfTodos = [
      for (final todo in _listOfTodos)
        if (todo.id == id)
          todo.copyWith(
            isDone: !todo.isDone,
          )
        else
          todo
    ];
    _todoController.add(_listOfTodos);
  }

  @override
  Future<void> dispose() async {
    await _todoController.close();
    await _childTodoController.close();
  }
}
