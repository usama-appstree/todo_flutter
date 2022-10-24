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
    // initializeTodos();
    return _todoController.stream;
  }

  Future<void> fetchAllTodosFromFirebase() async {
    _listOfTodos = await _database.getAllTodosFromFirebase();
    _sinkTodos.add(_listOfTodos);
  }

  void initializeTodos() {
    // _listOfTodos = _database.getAllTodosFromFirebase();
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
      await _database.addChildTodoToFirebase(id, childItem);
    } on FirebaseException {
      rethrow;
    }
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

  Future<void> changeChildTodoStatus(Todo todo, ChildTodo childTodo) async {
    // var main = _listOfTodos[
    //     _listOfTodos.indexWhere((element) => element.todoItem.id == mainID)];

    // var nestedItem = main.todoItemList[
    //     main.todoItemList.indexWhere((element) => element.id == itemID)];

    // _listOfTodos.forEach((element) {
    //   element.todoItemList.forEach((element) {});
    // });

    _listOfTodos = [
      for (final element in _listOfTodos)
        if (element.id == todo.id)
          element.copyWith(
            childTodos: [
              for (final todoItem in element.childTodos)
                if (todoItem.id == childTodo.id)
                  todoItem.copyWith(
                    isDone: !todoItem.isDone,
                  )
                else
                  todoItem
            ],
          )
        else
          element
    ];
    _todoController.add(_listOfTodos);
    try {
      await _database.changeChildTodoStatusOnFirebase(todo);
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> changeStatusOfTodo(Todo todo) async {
    _listOfTodos = [
      for (final data in _listOfTodos)
        if (data.id == todo.id)
          data.copyWith(
            isDone: !data.isDone,
          )
        else
          data
    ];
    _todoController.add(_listOfTodos);
    try {
      await _database.changeStatusOfTodoOnFirebase(todo);
    } on FirebaseException {
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    await _todoController.close();
    await _childTodoController.close();
  }
}
