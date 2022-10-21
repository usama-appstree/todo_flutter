// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todo _$$_TodoFromJson(Map<String, dynamic> json) => _$_Todo(
      id: json['id'] as String,
      name: json['name'] as String,
      isDone: json['isDone'] as bool? ?? false,
      isFavourite: json['isFavourite'] as bool? ?? false,
      description: json['description'] as String? ?? '',
      childTodos: (json['childTodos'] as List<dynamic>?)
              ?.map((e) => ChildTodo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isDone': instance.isDone,
      'isFavourite': instance.isFavourite,
      'description': instance.description,
      'childTodos': instance.childTodos,
    };
