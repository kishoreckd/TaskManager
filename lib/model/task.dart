// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';

class Task {
  String task;
  DateTime time;
  Task({required this.task, required this.time});

  factory Task.fromString(String task) {
    return Task(task: task, time: DateTime.now());
  }
  factory Task.fromMap(Map<String, dynamic> map) {
    print(map);
    return Task(
        task: map['task'],
        time: DateTime.fromMicrosecondsSinceEpoch(map['time']));
  }

  Map<String, dynamic> getMap() {
    return {'task': task, 'time': time.microsecondsSinceEpoch};
  }
}
