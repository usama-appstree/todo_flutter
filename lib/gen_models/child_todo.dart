import 'package:freezed_annotation/freezed_annotation.dart';

part 'child_todo.freezed.dart';
part 'child_todo.g.dart';

@freezed
class ChildTodo with _$ChildTodo {
  factory ChildTodo({
    required String id,
    required String name,
    @Default(false) bool isDone,
  }) = _ChildTodo;

  factory ChildTodo.fromJson(Map<String, dynamic> json) =>
      _$ChildTodoFromJson(json);
}
