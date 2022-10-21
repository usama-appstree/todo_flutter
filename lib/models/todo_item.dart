// import 'package:flutter/material.dart';

// @immutable
// class TodoItem {
//   const TodoItem({
//     required this.id,
//     required this.name,
//     this.isDone = false,
//     this.isFavourite = false,
//     this.description = '',
//   });

//   final String id;
//   final String name;
//   final bool isDone;
//   final bool isFavourite;
//   final String description;

//   @override
//   String toString() {
//     return 'TodoItem(id: $id, name: $name, isDone: $isDone, isFavourite: $isFavourite, description: $description)';
//   }

//   TodoItem copyWith({
//     String? id,
//     String? name,
//     bool? isDone,
//     bool? isFavourite,
//     String? description,
//   }) {
//     return TodoItem(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       isDone: isDone ?? this.isDone,
//       isFavourite: isFavourite ?? this.isFavourite,
//       description: description ?? this.description,
//     );
//   }
// }
