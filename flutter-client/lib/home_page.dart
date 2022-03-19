// import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/text_input_widget.dart';
import 'auth_interceptor.dart';
import 'completed_todo_list.dart';
import 'logout.dart';
// import 'package:http/http.dart' as http;
import 'reload.dart';
import 'swagger_output/api.swagger.dart';
import 'todo_list.dart';


class HomePage extends StatefulWidget {
  final String username;
  final String accessToken;
  const HomePage(this.username, this.accessToken, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> todos = [];
  List<Todo> completedTodos = [];

  @override
  void initState() {
    super.initState();
    loadTodos();
    loadCompletedTodos();
  }

  Api apiFactory() {
    return Api.create(
      baseUrl: dotenv.env['API'],
      interceptors: [AuthInterceptor()]
    );
    // return Api.create(
    //   baseUrl: 'http://10.0.0.102:7000',
    //   interceptors: [AuthInterceptor()]
    // );
  }

  Future loadTodos() async {
    var api = apiFactory();
    final response = await api.todoListGet(body: ListTodosInputDTO(isCompleted: false));
    if (response.body != null)
    {
      setState(() {
        todos = response.body!;      
      });
    }
  }

  Future loadCompletedTodos() async {
    var api = apiFactory();
    final response = await api.todoListGet(body: ListTodosInputDTO(isCompleted: true));
    if (response.body != null)
    {
      setState(() {
        completedTodos = response.body!;      
      });
    }
  }

  Future newTodo(String text) async {
    final api = apiFactory();
    final response = await api.todoCreatePost(body: CreateTodoInputDTO(title: text));

    if (response.statusCode == 200)
    {
      log("success");
      await loadTodos();
      await loadCompletedTodos();
    }
    else
    {
      log("failure");
    }
  }

  Future completeTodo(String? id) async {
    final api = apiFactory();
    final response = await api.todoCompletePut(body: CompleteTodoInputDTO(id: id));
    
    if (response.statusCode == 200)
    {
      log("completed success");
      await loadTodos();
      await loadCompletedTodos();
    }
    else
    {
      log("completed failure");
    }
  }

  Future uncompleteTodo(String? id) async {
    final api = apiFactory();
    final response = await api.todoUncompletePut(body: UncompleteTodoInputDTO(id: id));
    
    if (response.statusCode == 200)
    {
      log("uncompleted success");
      await loadTodos();
      await loadCompletedTodos();
    }
    else
    {
      log("uncompleted failure");
    }
  }

  Future reload() async {
    await loadTodos();
    await loadCompletedTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          const Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Logout()
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Reload(reload)
          )
        ]
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
              child: const Text('Header')),
            ListTile (
              title: const Text('Item 1'),
              onTap: () => {
                Navigator.pop(context)
              },
            )
          ]
        ),
      ),
      body: Column(
        children: [
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                TodoList(todos, completeTodo),
                ExpansionTile(
                  title: const Text('Completed'),
                  initiallyExpanded: true,
                  children: [CompletedTodoList(completedTodos, uncompleteTodo)],),
              ]
            )
          )),
          TextInputWidget(newTodo)
        ]
      )
    );
  }
}