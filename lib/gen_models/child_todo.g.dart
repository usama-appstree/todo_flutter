// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChildTodo _$$_ChildTodoFromJson(Map<String, dynamic> json) => _$_ChildTodo(
      id: json['id'] as String,
      name: json['name'] as String,
      isDone: json['isDone'] as bool? ?? false,
    );

Map<String, dynamic> _$$_ChildTodoToJson(_$_ChildTodo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isDone': instance.isDone,
    };
