// ignore_for_file: avoid_print
// import 'dart:convert';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/task.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  static const routeName = '/Home';
  var _taskController = TextEditingController();

  ///It saves all thelist of tasks
  List _tasks = [];

  ///Task completed checking
  List<bool>? _tasksDone;

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Task t = Task.fromString(_taskController.text);
    // print(t);
    // prefs.remove('task');
    var tasks = prefs.getString('task');
    List list = (tasks == null) ? [] : json.decode(tasks);
    print(list.runtimeType);
    list.add((t.getMap()));
    print(list.runtimeType);

    print(list);

    prefs.setString('task', json.encode(list));
    _taskController.text = '';
    Navigator.of(context).pop();

    _getTasks();
  }

  void _getTasks() async {
    _tasks = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tasks = prefs.getString('task');
    List list = (tasks == null) ? [] : json.decode(tasks);
    for (dynamic i in list) {
      // print(i.runtimeType);
      _tasks.add(Task.fromMap(i as Map<String, dynamic>));
    }

    _tasksDone = List.generate(_tasks.length, (index) => false);
    setState(() {});
  }

  Future<void> updatePendingTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Task> pendingList = [];

    for (var i = 0; i < _tasks.length; i++) {
      if (!_tasksDone![i]) pendingList.add(_tasks[i]);
    }

    var pendingListEncoded = List.generate(
        pendingList.length, (i) => json.encode(pendingList[i].getMap()));
    print(pendingListEncoded);
    prefs.setString('task', json.encode(pendingListEncoded));

    _getTasks();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _taskController = TextEditingController();
    // Future(() async {
    //   await saveData();
    // });
    _getTasks();
  }

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose

    _taskController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Manager',
          style: GoogleFonts.montserrat(),
        ),
        actions: [
          IconButton(
              onPressed: () {
                updatePendingTasks();
              },
              icon: Icon(Icons.save)),
          IconButton(
              onPressed: () async {
                // print('pressed');
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('task', json.encode([]));
                setState(() {
                  _getTasks();
                });
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Column(
          children: _tasks
              .map((e) => Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    padding: EdgeInsets.only(left: 10.0),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.black, width: 0.5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.task,
                          style: GoogleFonts.montserrat(),
                        ),
                        Checkbox(
                          value: _tasksDone?[_tasks.indexOf(e)],
                          key: GlobalKey(),
                          onChanged: (val) {
                            setState(() {
                              _tasksDone![_tasks.indexOf(e)] = val!;
                            });
                          },
                        )
                      ],
                    ),
                  ))
              .toList()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => {
          print("pressed"),
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(10.0),
                    height: 250,
                    color: Colors.blue[200],
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add Task',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Icon(Icons.close),
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 1.2,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextField(
                          controller: _taskController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0)),
                              hintText: 'Enter your Task',
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: GoogleFonts.montserrat()),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              SizedBox(
                                width: (MediaQuery.of(context).size.width / 2) -
                                    20,
                                child: ElevatedButton(
                                    onPressed: () {
                                      _taskController.text = '';
                                    },
                                    child: Text(
                                      'Reset',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white),
                                    )),
                              ),
                              SizedBox(
                                width: (MediaQuery.of(context).size.width / 2) -
                                    20,
                                child: ElevatedButton(
                                    onPressed: () {
                                      saveData();
                                    },
                                    child: Text(
                                      'Add',
                                      style: GoogleFonts.montserrat(),
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
