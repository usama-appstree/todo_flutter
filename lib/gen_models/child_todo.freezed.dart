// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'child_todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChildTodo _$ChildTodoFromJson(Map<String, dynamic> json) {
  return _ChildTodo.fromJson(json);
}

/// @nodoc
mixin _$ChildTodo {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isDone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChildTodoCopyWith<ChildTodo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChildTodoCopyWith<$Res> {
  factory $ChildTodoCopyWith(ChildTodo value, $Res Function(ChildTodo) then) =
      _$ChildTodoCopyWithImpl<$Res, ChildTodo>;
  @useResult
  $Res call({String id, String name, bool isDone});
}

/// @nodoc
class _$ChildTodoCopyWithImpl<$Res, $Val extends ChildTodo>
    implements $ChildTodoCopyWith<$Res> {
  _$ChildTodoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isDone = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChildTodoCopyWith<$Res> implements $ChildTodoCopyWith<$Res> {
  factory _$$_ChildTodoCopyWith(
          _$_ChildTodo value, $Res Function(_$_ChildTodo) then) =
      __$$_ChildTodoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, bool isDone});
}

/// @nodoc
class __$$_ChildTodoCopyWithImpl<$Res>
    extends _$ChildTodoCopyWithImpl<$Res, _$_ChildTodo>
    implements _$$_ChildTodoCopyWith<$Res> {
  __$$_ChildTodoCopyWithImpl(
      _$_ChildTodo _value, $Res Function(_$_ChildTodo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isDone = null,
  }) {
    return _then(_$_ChildTodo(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChildTodo implements _ChildTodo {
  _$_ChildTodo({required this.id, required this.name, this.isDone = false});

  factory _$_ChildTodo.fromJson(Map<String, dynamic> json) =>
      _$$_ChildTodoFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final bool isDone;

  @override
  String toString() {
    return 'ChildTodo(id: $id, name: $name, isDone: $isDone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChildTodo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDone, isDone) || other.isDone == isDone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, isDone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChildTodoCopyWith<_$_ChildTodo> get copyWith =>
      __$$_ChildTodoCopyWithImpl<_$_ChildTodo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChildTodoToJson(
      this,
    );
  }
}

abstract class _ChildTodo implements ChildTodo {
  factory _ChildTodo(
      {required final String id,
      required final String name,
      final bool isDone}) = _$_ChildTodo;

  factory _ChildTodo.fromJson(Map<String, dynamic> json) =
      _$_ChildTodo.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  bool get isDone;
  @override
  @JsonKey(ignore: true)
  _$$_ChildTodoCopyWith<_$_ChildTodo> get copyWith =>
      throw _privateConstructorUsedError;
}
