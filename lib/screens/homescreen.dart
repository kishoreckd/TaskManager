// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class HomeScreen extends StatelessWidget {
//   static const routeName = '/Home';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Task Manager',
//           style: GoogleFonts.montserrat(),
//         ),
//       ),
//       body: const Center(
//         child: Text("No Task Addded yet"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blue,
//         onPressed: () => showBottomSheet(
//             context: context,
//             builder: (BuildContext context) => Container(
//                   color: Colors.blue,
//                   child: Column(
//                     children: [
//                       Text(
//                         'Add Task',
//                         style: GoogleFonts.montserrat(
//                             color: Colors.white, fontSize: 20.0),
//                       )
//                     ],
//                   ),
//                 )),
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

class MyHome extends StatefulWidget {
  const MyHome({super.key});
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  static const routeName = '/Home';
  var taskController;

Future<void> saveData() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    taskController.dispose();
  }
  // var scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Manager',
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: const Center(
        child: Text("No Task Addded yet"),
      ),
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
                          controller: taskController,
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
                                      taskController.text = '';
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
