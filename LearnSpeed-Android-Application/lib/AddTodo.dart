import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:todo_list/pages/First.dart';
import 'package:todo_list/pages/home.dart';
import 'package:todo_list/pages/notes.dart';
import 'package:todo_list/pages/timer.dart';
import 'package:todo_list/pages/work.dart';
import 'pages/calender.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  // var currentIndex = 0;
  int _selectedIndex = 1;
  // void _navigateBottomBar(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  final List<Widget> _pages = [
    
    Notes(),
    Home(),
    Calender(),
    PomodoroTimer(),
    Work(),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _pages[_selectedIndex],

      // body: SafeArea(
      //   child: Container(
      //     decoration: const BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [Color(0xabf8990c), Color(0xadff6d64)],
      //         begin: Alignment.bottomCenter,
      //         end: Alignment.topCenter,
      //       ),
      //     ),
      //     // padding: const EdgeInsets.all(20),
      //     child:
      //         Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      //       const Padding(
      //         padding: EdgeInsets.all(20),
      //         child: Align(
      //           alignment: Alignment.topRight,
      //           child: Icon(
      //             Icons.notifications,
      //             size: 40,
      //           ),
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 100,
      //       ),
      //       const Padding(
      //         padding: EdgeInsets.only(left: 27.0, bottom: 0.0),
      //         child: Align(
      //             alignment: Alignment.bottomLeft,
      //             child: Text(
      //               'Welcome',
      //               style: TextStyle(fontSize: 20),
      //             )),
      //       ),
      //       const Padding(
      //         padding: EdgeInsets.only(left: 27.0, top: 0.0),
      //         child: Align(
      //             alignment: Alignment.topLeft,
      //             child: Text(
      //               'Akshat Roy',
      //               style: TextStyle(fontSize: 48),
      //             )),
      //       ),
      //       const SizedBox(
      //         height: 50,
      //       ),
      //       const Padding(
      //         padding: EdgeInsets.only(left: 27.0, bottom: 5.0),
      //         child: Align(
      //           alignment: Alignment.centerLeft,
      //           child: Text(
      //             'Please Create New Tasks and Profiles',
      //             style: TextStyle(fontSize: 14),
      //           ),
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(left: 27.0),
      //         child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               const Text(
      //                 'TASK LISTS',
      //                 style: TextStyle(fontSize: 20),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(right: 20.0),
      //                 child: TextButton(
      //                   style: TextButton.styleFrom(
      //                     textStyle: const TextStyle(fontSize: 15),
      //                   ),
      //                   onPressed: null,
      //                   child: const Text('create new'),
      //                 ),
      //               ),
      //             ]),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(left: 27.0),
      //         child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               const Text(
      //                 'PROFILE',
      //                 style: TextStyle(fontSize: 20),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(right: 20.0),
      //                 child: TextButton(
      //                   style: TextButton.styleFrom(
      //                     textStyle: const TextStyle(fontSize: 15),
      //                   ),
      //                   onPressed: null,
      //                   child: const Text('create new'),
      //                 ),
      //               ),
      //             ]),
      //       )

      //     ]),
      //   ),

      // ),
      //
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        height: screenWidth * 0.155,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 31, 31, 31),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.024),
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                      HapticFeedback.lightImpact();
                    });
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Stack(children: [
                    SizedBox(
                        width: screenWidth * 0.2125,
                        child: Center(
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            height: index == _selectedIndex
                                ? screenWidth * 0.12
                                : 0,
                            width: index == _selectedIndex
                                ? screenWidth * 0.2125
                                : 0,
                            decoration: BoxDecoration(
                              color: index == _selectedIndex
                                  ? Color(0xabf8990c).withOpacity(0.2)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        )),
                    Container(
                        width: screenWidth * 0.2125,
                        alignment: Alignment.center,
                        child: Icon(
                          listOfIcons[index],
                          size: screenWidth * 0.076,
                          color: index == _selectedIndex
                              ? Colors.red
                              : Color.fromARGB(255, 255, 248, 248),
                        ))
                  ]),
                )),
      ),
      // bottomNavigationBar: BottomNavigationBar(

      //     currentIndex: _selectedIndex,
      //     onTap: _navigateBottomBar,
      //     type: BottomNavigationBarType.fixed,
      //     items: const [
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.auto_stories_outlined), label: 'Notes'),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.map_outlined), label: 'Map'),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.calendar_month_outlined), label: 'Calender'),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.alarm_on_outlined), label: 'timer'),
      //     ]),
    ); //         ));
  }

  List<IconData> listOfIcons = [
    Icons.auto_stories_outlined,
    
    Icons.home_outlined,
    Icons.calendar_month_outlined,
    Icons.alarm_on_outlined,
  ];
}
