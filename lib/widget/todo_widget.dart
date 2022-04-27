import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/provider/todos.dart';
import '../screens/edit_todo_screen.dart';
import '../utils.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: editDeleteSlidableWidget(context),
    );
  }

  Slidable editDeleteSlidableWidget(BuildContext context) => Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          key: Key(todo.id),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                editTodo(context, todo);
              },
              backgroundColor: Colors.green,
              label: 'Edit',
              icon: Icons.edit,
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: 'Delete',
              onPressed: (BuildContext context) {
                deleteTodo(context, todo);
              },
            ),
          ],
        ),
        child: buildTodo(context),
      );

  Widget buildTodo(BuildContext context) => GestureDetector(
        onTap: () {
          editTodo(context, todo);
        },
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Checkbox(
                value: todo.isDone,
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                onChanged: (_) {
                  final provider =
                      Provider.of<TodosProvider>(context, listen: false);
                  final isDone = provider.toggleTodoStatus(todo);

                  Utils.showSnackBar(
                      context, isDone ? 'text' : 'Task marked completed');
                },
              ),
              const SizedBox(width: 20.0),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 22.0,
                    ),
                  ),
                  if (todo.description.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        todo.description,
                        style: const TextStyle(fontSize: 20.0, height: 1.5),
                      ),
                    ),
                ],
              )),
            ],
          ),
        ),
      );

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'Deleted the task');
  }

  editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoScreen(todo: todo),
        ),
      );
}
