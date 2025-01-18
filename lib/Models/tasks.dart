class Tasks {
  String todo;
  DateTime timestamp;
  bool done;

  Tasks({required this.todo, required this.timestamp, required this.done});

  Map toMap() {
    return {
      'todo': todo,
      'timestamp': timestamp,
      'done': done,
    };
  }

  factory Tasks.fromMap(Map task) {
    return Tasks(
        todo: task['todo'], timestamp: task['timestamp'], done: task['done']);
  }
}
