// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompleteTodoInputDTO _$CompleteTodoInputDTOFromJson(
        Map<String, dynamic> json) =>
    CompleteTodoInputDTO(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$CompleteTodoInputDTOToJson(
        CompleteTodoInputDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

CreateTodoInputDTO _$CreateTodoInputDTOFromJson(Map<String, dynamic> json) =>
    CreateTodoInputDTO(
      title: json['title'] as String?,
    );

Map<String, dynamic> _$CreateTodoInputDTOToJson(CreateTodoInputDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
    };

ListTodosInputDTO _$ListTodosInputDTOFromJson(Map<String, dynamic> json) =>
    ListTodosInputDTO(
      isCompleted: json['isCompleted'] as bool?,
    );

Map<String, dynamic> _$ListTodosInputDTOToJson(ListTodosInputDTO instance) =>
    <String, dynamic>{
      'isCompleted': instance.isCompleted,
    };

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      id: json['id'] as String?,
      title: json['title'] as String?,
      isCompleted: json['isCompleted'] as bool?,
      completed: json['completed'] == null
          ? null
          : DateTime.parse(json['completed'] as String),
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isCompleted': instance.isCompleted,
      'completed': instance.completed?.toIso8601String(),
    };

UncompleteTodoInputDTO _$UncompleteTodoInputDTOFromJson(
        Map<String, dynamic> json) =>
    UncompleteTodoInputDTO(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$UncompleteTodoInputDTOToJson(
        UncompleteTodoInputDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
