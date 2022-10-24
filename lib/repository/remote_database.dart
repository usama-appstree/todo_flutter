import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dribble_ui/gen_models/child_todo.dart';
import 'package:dribble_ui/gen_models/todo.dart';

class RemoteDatabase {
  const RemoteDatabase(this._firestore);
  final FirebaseFirestore _firestore;

  CollectionReference<Todo> _todosCollection() {
    return _firestore.collection('/todo').withConverter(
        fromFirestore: ((snapshot, options) =>
            Todo.fromJson(snapshot.id, snapshot.data() ?? {})),
        toFirestore: (todo, options) => todo.toJson());
  }

  Future<List<Todo>> getAllTodosFromFirebase() async {
    var todoList = <Todo>[];
    // StreamSubscription<QuerySnapshot<Todo>>? todoSubscription;
    // todoSubscription = _todosCollection().snapshots().listen((event) {
    //   todoList = event.docs.map((e) => e.data()).toList();
    // })
    //   ..onError((_) {
    //     todoSubscription?.cancel();
    //   });
    final data = await _todosCollection().get();
    todoList = data.docs.map((e) => e.data()).toList();
    return todoList;
  }

  Future<void> changeStatusOfTodoOnFirebase(Todo todo) async {
    _todosCollection().doc(todo.id).update({'isDone': !todo.isDone});
  }

  Future<void> addTodoToFirebase(Todo todo) {
    // Sir. Adil said the document ID should be same as ID of Todo
    return _todosCollection().doc(todo.id).set(todo);
  }

  Future<void> addChildTodoToFirebase(String id, ChildTodo todo) async {
    _todosCollection().doc(id).update({
      'childTodos': FieldValue.arrayUnion([todo.toJson()])
    });
  }

  Future<void> changeChildTodoStatusOnFirebase(Todo todo) async {
    _todosCollection().doc(todo.id).update({
      'childTodos': todo.childTodos
          .map((e) => e.copyWith(isDone: !e.isDone).toJson())
          .toList()
    });
  }
}
