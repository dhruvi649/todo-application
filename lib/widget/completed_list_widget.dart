import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/widget/todo_widget.dart';
import '../provider/todos.dart';

class CompletedListWidget extends StatelessWidget {
  const CompletedListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todosCompleted;

    return todos.isEmpty
        ? const Text(
            'No completed tasks',
            style: TextStyle(fontSize: 20.0),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(16.0),
            physics: const BouncingScrollPhysics(),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoWidget(todo: todo);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 10.0,
              );
            },
          );
  }
}
