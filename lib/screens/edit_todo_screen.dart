import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/widget/todo_form_widget.dart';

class EditTodoScreen extends StatefulWidget {
  final Todo todo;

  const EditTodoScreen({Key? key, required this.todo}) : super(key: key);

  @override
  _EditTodoScreenState createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: titleDescriptionTextFormField(),
    );
  }

  Padding titleDescriptionTextFormField() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: TodoFormWidget(
              title: title,
              description: description,
              onChangedTitle: (title) => setState(() {
                    this.title = title;
                  }),
              onChangedDescription: (description) => setState(() {
                    this.description = description;
                  }),
              onSavedTodo: saveTodo),
        ),
      );

  AppBar customAppBar(BuildContext context) => AppBar(
        title: const Text('Edit Todo'),
        actions: [
          IconButton(
            onPressed: () {
              final provider =
                  Provider.of<TodosProvider>(context, listen: false);
              provider.removeTodo(widget.todo);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      );

  Future<void> saveTodo() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.updateTodo(widget.todo, title, description);
      Navigator.of(context).pop();
    }
  }
}
