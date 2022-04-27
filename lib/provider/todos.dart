import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class TodosProvider extends ChangeNotifier {
  final List<Todo> _todos = [
    Todo(
        createdTime: DateTime.now(), title:
      'Buy food', description: '''
      -Eggs
      -Milk
      -Bread
      -Waters'''),
    Todo(
      createdTime: DateTime.now(),
      title:
      'Plan family trip to london',
      description: '''
      -Rent some hotels
      -Rent a car
      -Pack suitcase''',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Plan jacobs birthday party',
    ),
    Todo(
        title: 'Time to have fun 🥳',
        createdTime: DateTime.now(),
    ),
  ];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void addTodo(Todo todo){
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(Todo todo){
    _todos.remove(todo);
    notifyListeners();
  }

  bool toggleTodoStatus(Todo todo){
    todo.isDone = !todo.isDone;
    notifyListeners();
    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description){
    todo.title = title;
    todo.description = description;
    notifyListeners();
  }

}
