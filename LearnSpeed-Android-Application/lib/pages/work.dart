import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:todo_list/pages/today.dart';

import '../AddTodo.dart';


class Work extends StatefulWidget {
  const Work({Key? key}) : super(key: key);
  _WorkState createState() => _WorkState();
}

class _WorkState extends State<Work> {
  // int _selectedIndex = 0;
  // final List<Widget> _pages = [
  //   First(),
  //   Notes(),
  //   Home(),
  //   Calender(),
  //   PomodoroTimer(),
  // ];

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xffffef4c), Color(0xffffffff)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )),
        child: SingleChildScrollView(
          // decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //   colors: [Color(0xffffef4c), Color(0xffffffff)],
          //   begin: Alignment.bottomCenter,
          //   end: Alignment.topCenter,
          // )),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      // Align(
                      //   alignment: Alignment.topLeft,
                      Padding(
                          padding: EdgeInsets.only(top: 50),

                          // child: Align(
                          // alignment: Alignment.topLeft,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.red),
                            ),
                          )
                          // ),
                          ),
                      // ),
                      Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          // child: Align(
                          //     alignment: Alignment.topLeft,
                          child: Text(
                            'WORK',
                            style: TextStyle(
                                fontSize: 32,
                                fontFamily: 'Bebas',
                                letterSpacing: 3,
                                fontWeight: FontWeight.w400),
                          )
                          // ),
                          ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50, right: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.notifications,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                    width: 315,
                    height: 152,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: -3,
                            blurRadius: 20,
                            offset: Offset(0, 0)),
                      ],
                      gradient: LinearGradient(
                        colors: [Color(0xabf8990c), Color(0xadff6d64)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10, top: 10),
                                  child: Text('PROGRESS',
                                      style: TextStyle(
                                          fontFamily: 'Bebas',
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20,
                                          color: Colors.black)),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text('Total Tasks',
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300)),
                                    ),
                                    SizedBox(width: 10),
                                    Text('0',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.red)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text('Completed',
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300)),
                                    ),
                                    SizedBox(width: 10),
                                    Text('0',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.red)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text('Remaining',
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300)),
                                    ),
                                    SizedBox(width: 10),
                                    Text('0',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.red)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  // border: Border.all(),
                                )),
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TASKS LISTS',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Bebas',
                        letterSpacing: 2,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Show All',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Roboto',
                          color: Colors.red),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TodayTask()),
                          );
                        },
                        child: Container(
                            height: 162,
                            width: 149,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 7,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 20,
                                        bottom: 15),
                                    child: Icon(
                                      Icons.wb_sunny_outlined,
                                      color: Colors.red,
                                      size: 40,
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(left: 20, top: 5),
                                    child: Text('TODAY',
                                        style: TextStyle(
                                          fontFamily: 'Bebas',
                                          fontSize: 30,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 4,
                                        ))),
                                // SizedBox(
                                //   height: 20,
                                // ),
                                Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                            height: 28,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              // boxShadow: [
                                              //   BoxShadow(
                                              //     color:
                                              //         Colors.black.withOpacity(0.25),
                                              //     spreadRadius: 0,
                                              //     blurRadius: 7,
                                              //     offset: Offset(0, 4),
                                              //   ),
                                              // ],
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text('0 Done',
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 12,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )),
                                        Container(
                                            height: 28,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              // boxShadow: [
                                              //   BoxShadow(
                                              //     color:
                                              //         Colors.black.withOpacity(0.25),
                                              //     spreadRadius: 0,
                                              //     blurRadius: 7,
                                              //     offset: Offset(0, 4),
                                              //   ),
                                              // ],
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text('0 Left',
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 12,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )),
                                      ]),
                                )
                              ],
                            )),
                      ),
                      Container(
                          height: 162,
                          width: 149,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                spreadRadius: 0,
                                blurRadius: 7,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 20, bottom: 15),
                                  child: Icon(
                                    Icons.timer_outlined,
                                    color: Colors.red,
                                    size: 40,
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(left: 20, top: 5),
                                  child: Text('RECENT',
                                      style: TextStyle(
                                        fontFamily: 'Bebas',
                                        fontSize: 30,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 4,
                                      ))),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                          height: 28,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color:
                                            //         Colors.black.withOpacity(0.25),
                                            //     spreadRadius: 0,
                                            //     blurRadius: 7,
                                            //     offset: Offset(0, 4),
                                            //   ),
                                            // ],
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text('0 Done',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 12,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )),
                                      Container(
                                          height: 28,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color: Colors.black
                                            //         .withOpacity(0.25),
                                            //     spreadRadius: 0,
                                            //     blurRadius: 7,
                                            //     offset: Offset(0, 4),
                                            //   ),
                                            // ]
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text('0 Left',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 12,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )),
                                    ]),
                              )
                            ],
                          )),
                    ]),
              ),
              SizedBox(height: 250),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTodoPage()),
                    );
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 7,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.home_filled, size: 30),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
