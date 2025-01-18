// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/Models/tasks.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  
  double? _deviceHeight, _deviceWidth;
  String? content;
  late Box _box;

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    _box = await Hive.openBox("tasks");
    setState(() {}); // Trigger a rebuild once the box is ready
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight! * 0.1,
        title: const Text("Daily Planner"),
      ),
      body: _tasksWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: displayTaskPop,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _todoList() {
    if (_box.isEmpty) {
      return const Center(
        child: Text("No tasks yet! Add some using the + button."),
      );
    }

    List tasks = _box.values.toList();
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        var task = Tasks.fromMap(tasks[index]);
        return ListTile(
          title: Text(task.todo),
          subtitle: Text(task.timestamp.toString()),
          trailing: task.done
              ? const Icon(Icons.check_box_outlined, color: Colors.green)
              : const Icon(Icons.check_box_outline_blank),
          onTap: () {
            setState(() {
              task.done = !task.done;
              _box.putAt(index, task.toMap());
            });
          },
          onLongPress: () {
            setState(() {
              _box.deleteAt(index);
            });
          },
        );
      },
    );
  }

  Widget _tasksWidget() {
    return _box.isOpen
        ? _todoList()
        : const Center(child: CircularProgressIndicator());
  }

  void displayTaskPop() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add a To-Do"),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: "Enter your task"),
            onChanged: (value) {
              setState(() {
                content = value;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (content != null && content!.trim().isNotEmpty) {
                  var task = Tasks(
                    todo: content!,
                    timestamp: DateTime.now(),
                    done: false,
                  );
                  setState(() {
                    _box.add(task.toMap());
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
