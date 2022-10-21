import 'package:dribble_ui/gen_models/child_todo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String name,
    @Default(false) bool isDone,
    @Default(false) bool isFavourite,
    @Default('') String description,
    @Default([]) List<ChildTodo> childTodos,
  }) = _Todo;

  factory Todo.fromJson(String id, Map<String, dynamic> json) =>
      _$TodoFromJson(json).copyWith(id: id);
}
