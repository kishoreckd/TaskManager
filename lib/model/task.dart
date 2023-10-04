import 'package:flutter/foundation.dart';

class Task {
  String task;
  DateTime time;
  Task({required this.task, required this.time});

  factory Task.fromMap(Map<String,dynamic> map) {
    return Task(task: map['task'], time: DateTime.fromMicrosecondsSinceEpoch(map['time']));
  }

  Map<String, dynamic> getMap() {
    return {'task': task, 'time': time.millisecondsSinceEpoch};
  }
}
