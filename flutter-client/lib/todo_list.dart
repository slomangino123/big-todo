
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helloworld/swagger_output/api.swagger.dart';

class TodoList extends StatefulWidget {
  final List<Todo> todos;
  final Future Function(String) todoItemCallback;
  const TodoList(
    this.todos,
    this.todoItemCallback,
    { Key? key }) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  todoItemClicked(String id) {
    // perform callback using todo id
    widget.todoItemCallback(id);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.todos.length,
      itemBuilder: (ctx, index) {
        var todo = widget.todos[index];
        return Card(
          child: Row(
            children: <Widget>
            [
              Expanded(
                child: ListTile(
                  title: Text(todo.title!),
                ),
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.check,
                      color: todo.isCompleted! ? Colors.green : Colors.black,
                    ),
                    splashColor: Colors.purple,
                    onPressed: () => todoItemClicked(todo.id!),
                  )
                ],
              ),
            ],
          )
        );
      },
    );
  }
}