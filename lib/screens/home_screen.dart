import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import '../widget/add_todo_dialog_widget.dart';
import '../widget/completed_list_widget.dart';
import '../widget/todo_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const TodoListWidget(),
      const CompletedListWidget(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
      ),
      bottomNavigationBar: bottomNavigationBar(context),
      body: tabs[selectedIndex],
      floatingActionButton: floatingActionButton(context),
    );
  }

  FloatingActionButton floatingActionButton(BuildContext context) => FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.black,
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return const AddTodoDialogWidget();
            },
            barrierDismissible: false);
      },
      child: const Icon(Icons.add),
    );

  BottomNavigationBar bottomNavigationBar(BuildContext context) => BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.white.withOpacity(0.7),
      selectedItemColor: Colors.white,
      currentIndex: selectedIndex,
      onTap: (index) => setState(() {
        selectedIndex = index;
      }),
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined), label: 'Todo\'s'),
        BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed'),
      ],
    );
}
