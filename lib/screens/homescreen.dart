// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    padding: EdgeInsets.all(10.0),
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
                              child: Icon(Icons.close),
                            )
                          ],
                        ),
                        Divider(
                          thickness: 1.2,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0)),
                              hintText: 'Enter your Task',
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: GoogleFonts.montserrat()),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              SizedBox(
                                width: (MediaQuery.of(context).size.width / 2) -
                                    20,
                                child: ElevatedButton(
                                    onPressed: () {},
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
                                    onPressed: () {},
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
        child: Icon(Icons.add),
      ),
    );
  }
}
