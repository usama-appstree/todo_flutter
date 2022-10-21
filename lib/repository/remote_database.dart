import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  List<Todo> getAllTodosFromFirebase() {
    var todoList = <Todo>[];
    StreamSubscription<QuerySnapshot<Todo>>? todoSubscription;
    todoSubscription = _todosCollection().snapshots().listen((event) {
      todoList = event.docs.map((e) => e.data()).toList();
    })
      ..onError((_) {
        todoSubscription?.cancel();
      });
    return todoList;
  }

  Future<void> addTodoToFirebase(Todo todo) async {
    // Sir. Adil said the document should be same as id of Todo
    _todosCollection().doc(todo.id).set(todo);
  }

  Future<void> addChildTodoToFirebase(Todo todo) async {
    _todosCollection().doc(todo.id).update(todo.toJson());
  }

  Future<void> changeStatusOfTodo(Todo todo) async {
    _todosCollection().doc(todo.id).update({'isDone': !todo.isDone});
  }
}
