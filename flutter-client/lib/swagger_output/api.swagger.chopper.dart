//Generated code

part of 'api.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$Api extends Api {
  _$Api([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = Api;

  @override
  Future<Response<dynamic>> _healthGetGet() {
    final $url = '/Health/Get';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _healthIdentityGet() {
    final $url = '/Health/Identity';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _todoCreatePost(
      {required CreateTodoInputDTO? body}) {
    final $url = '/Todo/Create';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Todo>>> _todoListGet(
      {required ListTodosInputDTO? body}) {
    final $url = '/Todo/List';
    final $body = body;
    final $request = Request('GET', $url, client.baseUrl, body: $body);
    return client.send<List<Todo>, Todo>($request);
  }

  @override
  Future<Response<List<Todo>>> _todoCompletePut(
      {required CompleteTodoInputDTO? body}) {
    final $url = '/Todo/Complete';
    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<List<Todo>, Todo>($request);
  }

  @override
  Future<Response<List<Todo>>> _todoUncompletePut(
      {required UncompleteTodoInputDTO? body}) {
    final $url = '/Todo/Uncomplete';
    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<List<Todo>, Todo>($request);
  }
}
