// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

import 'package:chopper/chopper.dart';
import 'dart:convert';

import 'client_mapping.dart';
import 'package:chopper/chopper.dart' as chopper;

part 'api.swagger.chopper.dart';
part 'api.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Api extends ChopperService {
  static Api create(
      {ChopperClient? client,
      String? baseUrl,
      Iterable<dynamic>? interceptors}) {
    if (client != null) {
      return _$Api(client);
    }

    final newClient = ChopperClient(
        services: [_$Api()],
        converter: $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        baseUrl: baseUrl ?? 'http://');
    return _$Api(newClient);
  }

  ///
  Future<chopper.Response> healthGetGet() {
    return _healthGetGet();
  }

  ///
  @Get(path: '/Health/Get')
  Future<chopper.Response> _healthGetGet();

  ///
  Future<chopper.Response> healthIdentityGet() {
    return _healthIdentityGet();
  }

  ///
  @Get(path: '/Health/Identity')
  Future<chopper.Response> _healthIdentityGet();

  ///
  Future<chopper.Response> todoCreatePost({required CreateTodoInputDTO? body}) {
    return _todoCreatePost(body: body);
  }

  ///
  @Post(path: '/Todo/Create')
  Future<chopper.Response> _todoCreatePost(
      {@Body() required CreateTodoInputDTO? body});

  ///
  Future<chopper.Response<List<Todo>>> todoListGet(
      {required ListTodosInputDTO? body}) {
    generatedMapping.putIfAbsent(Todo, () => Todo.fromJsonFactory);

    return _todoListGet(body: body);
  }

  ///
  @Get(path: '/Todo/List')
  Future<chopper.Response<List<Todo>>> _todoListGet(
      {@Body() required ListTodosInputDTO? body});

  ///
  Future<chopper.Response<List<Todo>>> todoCompletePut(
      {required CompleteTodoInputDTO? body}) {
    generatedMapping.putIfAbsent(Todo, () => Todo.fromJsonFactory);

    return _todoCompletePut(body: body);
  }

  ///
  @Put(path: '/Todo/Complete')
  Future<chopper.Response<List<Todo>>> _todoCompletePut(
      {@Body() required CompleteTodoInputDTO? body});

  ///
  Future<chopper.Response<List<Todo>>> todoUncompletePut(
      {required UncompleteTodoInputDTO? body}) {
    generatedMapping.putIfAbsent(Todo, () => Todo.fromJsonFactory);

    return _todoUncompletePut(body: body);
  }

  ///
  @Put(path: '/Todo/Uncomplete')
  Future<chopper.Response<List<Todo>>> _todoUncompletePut(
      {@Body() required UncompleteTodoInputDTO? body});
}

@JsonSerializable(explicitToJson: true)
class CompleteTodoInputDTO {
  CompleteTodoInputDTO({
    this.id,
  });

  factory CompleteTodoInputDTO.fromJson(Map<String, dynamic> json) =>
      _$CompleteTodoInputDTOFromJson(json);

  @JsonKey(name: 'id')
  final String? id;
  static const fromJsonFactory = _$CompleteTodoInputDTOFromJson;
  static const toJsonFactory = _$CompleteTodoInputDTOToJson;
  Map<String, dynamic> toJson() => _$CompleteTodoInputDTOToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CompleteTodoInputDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^ runtimeType.hashCode;
}

extension $CompleteTodoInputDTOExtension on CompleteTodoInputDTO {
  CompleteTodoInputDTO copyWith({String? id}) {
    return CompleteTodoInputDTO(id: id ?? this.id);
  }
}

@JsonSerializable(explicitToJson: true)
class CreateTodoInputDTO {
  CreateTodoInputDTO({
    this.title,
  });

  factory CreateTodoInputDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateTodoInputDTOFromJson(json);

  @JsonKey(name: 'title')
  final String? title;
  static const fromJsonFactory = _$CreateTodoInputDTOFromJson;
  static const toJsonFactory = _$CreateTodoInputDTOToJson;
  Map<String, dynamic> toJson() => _$CreateTodoInputDTOToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateTodoInputDTO &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^ runtimeType.hashCode;
}

extension $CreateTodoInputDTOExtension on CreateTodoInputDTO {
  CreateTodoInputDTO copyWith({String? title}) {
    return CreateTodoInputDTO(title: title ?? this.title);
  }
}

@JsonSerializable(explicitToJson: true)
class ListTodosInputDTO {
  ListTodosInputDTO({
    this.isCompleted,
  });

  factory ListTodosInputDTO.fromJson(Map<String, dynamic> json) =>
      _$ListTodosInputDTOFromJson(json);

  @JsonKey(name: 'isCompleted')
  final bool? isCompleted;
  static const fromJsonFactory = _$ListTodosInputDTOFromJson;
  static const toJsonFactory = _$ListTodosInputDTOToJson;
  Map<String, dynamic> toJson() => _$ListTodosInputDTOToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ListTodosInputDTO &&
            (identical(other.isCompleted, isCompleted) ||
                const DeepCollectionEquality()
                    .equals(other.isCompleted, isCompleted)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(isCompleted) ^ runtimeType.hashCode;
}

extension $ListTodosInputDTOExtension on ListTodosInputDTO {
  ListTodosInputDTO copyWith({bool? isCompleted}) {
    return ListTodosInputDTO(isCompleted: isCompleted ?? this.isCompleted);
  }
}

@JsonSerializable(explicitToJson: true)
class Todo {
  Todo({
    this.id,
    this.title,
    this.isCompleted,
    this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'isCompleted')
  final bool? isCompleted;
  @JsonKey(name: 'completed')
  final DateTime? completed;
  static const fromJsonFactory = _$TodoFromJson;
  static const toJsonFactory = _$TodoToJson;
  Map<String, dynamic> toJson() => _$TodoToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Todo &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.isCompleted, isCompleted) ||
                const DeepCollectionEquality()
                    .equals(other.isCompleted, isCompleted)) &&
            (identical(other.completed, completed) ||
                const DeepCollectionEquality()
                    .equals(other.completed, completed)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(isCompleted) ^
      const DeepCollectionEquality().hash(completed) ^
      runtimeType.hashCode;
}

extension $TodoExtension on Todo {
  Todo copyWith(
      {String? id, String? title, bool? isCompleted, DateTime? completed}) {
    return Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        isCompleted: isCompleted ?? this.isCompleted,
        completed: completed ?? this.completed);
  }
}

@JsonSerializable(explicitToJson: true)
class UncompleteTodoInputDTO {
  UncompleteTodoInputDTO({
    this.id,
  });

  factory UncompleteTodoInputDTO.fromJson(Map<String, dynamic> json) =>
      _$UncompleteTodoInputDTOFromJson(json);

  @JsonKey(name: 'id')
  final String? id;
  static const fromJsonFactory = _$UncompleteTodoInputDTOFromJson;
  static const toJsonFactory = _$UncompleteTodoInputDTOToJson;
  Map<String, dynamic> toJson() => _$UncompleteTodoInputDTOToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UncompleteTodoInputDTO &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^ runtimeType.hashCode;
}

extension $UncompleteTodoInputDTOExtension on UncompleteTodoInputDTO {
  UncompleteTodoInputDTO copyWith({String? id}) {
    return UncompleteTodoInputDTO(id: id ?? this.id);
  }
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  chopper.Response<ResultType> convertResponse<ResultType, Item>(
      chopper.Response response) {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    final jsonRes = super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}
