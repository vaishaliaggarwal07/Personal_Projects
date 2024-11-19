import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:todo_list/pages/self.dart';
import 'package:todo_list/pages/work.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isPanelOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  // Align(
                  //   alignment: Alignment.topLeft,
                  const Padding(
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
                  const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      // child: Align(
                      //     alignment: Alignment.topLeft,
                      child: Text(
                        'HOME',
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
              const Padding(
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
            padding: const EdgeInsets.all(20),
            child: Container(
                // width: 3,
                height: 172,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: -3,
                        blurRadius: 20,
                        offset: const Offset(0, 0)),
                  ],
                  gradient: const LinearGradient(
                    colors: [Color(0xabf8990c), Color(0xadff6d64)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            const Padding(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('Total Tasks',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300)),
                                ),
                                const SizedBox(width: 10),
                                const Text('0',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.red)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('Completed',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300)),
                                ),
                                const SizedBox(width: 10),
                                const Text('0',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.red)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('Remaining',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300)),
                                ),
                                const SizedBox(width: 10),
                                const Text('0',
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
                        padding: const EdgeInsets.only(right: 10),
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
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'TASKS LISTS',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Bebas',
                    letterSpacing: 2,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Show All',
                  style: TextStyle(
                      fontSize: 15, fontFamily: 'Roboto', color: Colors.red),
                ),
              ],
            ),
          ),

          Container(
            // width: 300,
            height: 330,
            // padding: EdgeInsets.all(20),
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10, left: 20, bottom: 10),
                  child: Container(
                      height: 152,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              spreadRadius: 0,
                              blurRadius: 7,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          gradient: const LinearGradient(
                            colors: [Color(0xffffef4c), Color(0xffffffff)],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 15),
                              child: Icon(
                                Icons.work_outline_outlined,
                                color: Color(0xffffef4c),
                                size: 40,
                              )),
                          const Padding(
                              padding: EdgeInsets.only(left: 20, top: 5),
                              child: Text('WORK',
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
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      height: 28,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
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
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text('0 Done',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 12,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold)),
                                      )),
                                  Container(
                                      height: 28,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
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
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text('0 Left',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 12,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold)),
                                      )),
                                ]),
                          )
                        ],
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 20, bottom: 10),
                  child: Container(
                      height: 162,
                      width: 160,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              spreadRadius: 0,
                              blurRadius: 7,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          gradient: const LinearGradient(
                            colors: [Color(0xffdd914f), Color(0xffffffff)],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 15),
                              child: Icon(
                                Icons.person_outlined,
                                color: Color(0xffdd914f),
                                size: 40,
                              )),
                          const Padding(
                              padding: EdgeInsets.only(left: 20, top: 5),
                              child: Text('SELF',
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
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      height: 28,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
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
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text('0 Done',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 12,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold)),
                                      )),
                                  Container(
                                      height: 28,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
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
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text('0 Left',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 12,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold)),
                                      )),
                                ]),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),

          //  Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => const Work()),
          //           );
          //         },
          //         child: Padding(
          //           padding: EdgeInsets.only(right: 10,left: 20,top:20,bottom: 10),
          //           child: Container(
          //               height: 162,
          //               width: 160,
          //               decoration: BoxDecoration(
          //                   color: Colors.white,
          //                   borderRadius: BorderRadius.circular(20),
          //                   boxShadow: [
          //                     BoxShadow(
          //                       color: Colors.black.withOpacity(0.25),
          //                       spreadRadius: 0,
          //                       blurRadius: 7,
          //                       offset: const Offset(0, 4),
          //                     ),
          //                   ],
          //                   gradient: const LinearGradient(
          //                     colors: [Color(0xffffef4c), Color(0xffffffff)],
          //                     begin: Alignment.bottomCenter,
          //                     end: Alignment.topCenter,
          //                   )),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   const Padding(
          //                       padding: EdgeInsets.only(
          //                           left: 20, right: 20, top: 20, bottom: 15),
          //                       child: Icon(
          //                         Icons.work_outline_outlined,
          //                         color: Color(0xffffef4c),
          //                         size: 40,
          //                       )),
          //                   const Padding(
          //                       padding: EdgeInsets.only(left: 20, top: 5),
          //                       child: Text('WORK',
          //                           style: TextStyle(
          //                             fontFamily: 'Bebas',
          //                             fontSize: 30,
          //                             fontWeight: FontWeight.w400,
          //                             letterSpacing: 4,
          //                           ))),
          //                   // SizedBox(
          //                   //   height: 20,
          //                   // ),
          //                   Padding(
          //                     padding: const EdgeInsets.only(top: 0),
          //                     child: Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceEvenly,
          //                         children: [
          //                           Container(
          //                               height: 28,
          //                               width: 60,
          //                               decoration: BoxDecoration(
          //                                 color: Colors.white,
          //                                 borderRadius:
          //                                     BorderRadius.circular(20),
          //                                 // boxShadow: [
          //                                 //   BoxShadow(
          //                                 //     color:
          //                                 //         Colors.black.withOpacity(0.25),
          //                                 //     spreadRadius: 0,
          //                                 //     blurRadius: 7,
          //                                 //     offset: Offset(0, 4),
          //                                 //   ),
          //                                 // ],
          //                               ),
          //                               child: const Align(
          //                                 alignment: Alignment.center,
          //                                 child: Text('0 Done',
          //                                     style: TextStyle(
          //                                         fontFamily: 'Roboto',
          //                                         fontSize: 12,
          //                                         color: Colors.red,
          //                                         fontWeight: FontWeight.bold)),
          //                               )),
          //                           Container(
          //                               height: 28,
          //                               width: 60,
          //                               decoration: BoxDecoration(
          //                                 color: Colors.white,
          //                                 borderRadius:
          //                                     BorderRadius.circular(20),
          //                                 // boxShadow: [
          //                                 //   BoxShadow(
          //                                 //     color:
          //                                 //         Colors.black.withOpacity(0.25),
          //                                 //     spreadRadius: 0,
          //                                 //     blurRadius: 7,
          //                                 //     offset: Offset(0, 4),
          //                                 //   ),
          //                                 // ],
          //                               ),
          //                               child: const Align(
          //                                 alignment: Alignment.center,
          //                                 child: Text('0 Left',
          //                                     style: TextStyle(
          //                                         fontFamily: 'Roboto',
          //                                         fontSize: 12,
          //                                         color: Colors.red,
          //                                         fontWeight: FontWeight.bold)),
          //                               )),
          //                         ]),
          //                   )
          //                 ],
          //               )),
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => const Self()),
          //           );
          //         },
          //         child: Padding(
          //           padding: EdgeInsets.only(left: 10,right: 20,top: 20,bottom: 10),
          //           child: Container(
          //               height: 162,
          //               width: 160,
          //               decoration: BoxDecoration(
          //                   color: Colors.white,
          //                   borderRadius: BorderRadius.circular(20),
          //                   boxShadow: [
          //                     BoxShadow(
          //                       color: Colors.black.withOpacity(0.25),
          //                       spreadRadius: 0,
          //                       blurRadius: 7,
          //                       offset: const Offset(0, 4),
          //                     ),
          //                   ],
          //                   gradient: const LinearGradient(
          //                     colors: [Color(0xffdd914f), Color(0xffffffff)],
          //                     begin: Alignment.bottomCenter,
          //                     end: Alignment.topCenter,
          //                   )),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   const Padding(
          //                       padding: EdgeInsets.only(
          //                           left: 20, right: 20, top: 20, bottom: 15),
          //                       child: Icon(
          //                         Icons.person_outlined,
          //                         color: Color(0xffdd914f),
          //                         size: 40,
          //                       )),
          //                   const Padding(
          //                       padding: EdgeInsets.only(left: 20, top: 5),
          //                       child: Text('SELF',
          //                           style: TextStyle(
          //                             fontFamily: 'Bebas',
          //                             fontSize: 30,
          //                             fontWeight: FontWeight.w400,
          //                             letterSpacing: 4,
          //                           ))),
          //                   // SizedBox(
          //                   //   height: 20,
          //                   // ),
          //                   Padding(
          //                     padding: const EdgeInsets.only(top: 0),
          //                     child: Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceEvenly,
          //                         children: [
          //                           Container(
          //                               height: 28,
          //                               width: 60,
          //                               decoration: BoxDecoration(
          //                                 color: Colors.white,
          //                                 borderRadius:
          //                                     BorderRadius.circular(20),
          //                                 // boxShadow: [
          //                                 //   BoxShadow(
          //                                 //     color:
          //                                 //         Colors.black.withOpacity(0.25),
          //                                 //     spreadRadius: 0,
          //                                 //     blurRadius: 7,
          //                                 //     offset: Offset(0, 4),
          //                                 //   ),
          //                                 // ],
          //                               ),
          //                               child: const Align(
          //                                 alignment: Alignment.center,
          //                                 child: Text('0 Done',
          //                                     style: TextStyle(
          //                                         fontFamily: 'Roboto',
          //                                         fontSize: 12,
          //                                         color: Colors.red,
          //                                         fontWeight: FontWeight.bold)),
          //                               )),
          //                           Container(
          //                               height: 28,
          //                               width: 60,
          //                               decoration: BoxDecoration(
          //                                 color: Colors.white,
          //                                 borderRadius:
          //                                     BorderRadius.circular(20),
          //                                 // boxShadow: [
          //                                 //   BoxShadow(
          //                                 //     color: Colors.black
          //                                 //         .withOpacity(0.25),
          //                                 //     spreadRadius: 0,
          //                                 //     blurRadius: 7,
          //                                 //     offset: Offset(0, 4),
          //                                 //   ),
          //                                 // ]
          //                               ),
          //                               child: const Align(
          //                                 alignment: Alignment.center,
          //                                 child: Text('0 Left',
          //                                     style: TextStyle(
          //                                         fontFamily: 'Roboto',
          //                                         fontSize: 12,
          //                                         color: Colors.red,
          //                                         fontWeight: FontWeight.bold)),
          //                               )),
          //                         ]),
          //                   )
          //                 ],
          //               )),
          //         ),
          //       ),
          //     ]),

          // Padding(
          //   padding: const EdgeInsets.all(20),
          //   child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Container(
          //             height: 162,
          //             width: 149,
          //             decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.circular(20),
          //                 boxShadow: [
          //                   BoxShadow(
          //                     color: Colors.black.withOpacity(0.25),
          //                     spreadRadius: 0,
          //                     blurRadius: 7,
          //                     offset: const Offset(0, 4),
          //                   ),
          //                 ],
          //                 gradient: const LinearGradient(
          //                   colors: [Color(0xfff1709c), Color(0xffffffff)],
          //                   begin: Alignment.bottomCenter,
          //                   end: Alignment.topCenter,
          //                 )),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 const Padding(
          //                     padding: EdgeInsets.only(
          //                         left: 20, right: 20, top: 20, bottom: 15),
          //                     child: Icon(
          //                       Icons.health_and_safety_outlined,
          //                       color: Color(0xfff1709c),
          //                       size: 40,
          //                     )),
          //                 const Padding(
          //                     padding: EdgeInsets.only(left: 20, top: 5),
          //                     child: Text('HEALTH',
          //                         style: TextStyle(
          //                           fontFamily: 'Bebas',
          //                           fontSize: 30,
          //                           fontWeight: FontWeight.w400,
          //                           letterSpacing: 4,
          //                         ))),
          //                 // SizedBox(
          //                 //   height: 20,
          //                 // ),
          //                 Padding(
          //                   padding: const EdgeInsets.only(top: 0),
          //                   child: Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceEvenly,
          //                       children: [
          //                         Container(
          //                             height: 28,
          //                             width: 60,
          //                             decoration: BoxDecoration(
          //                               color: Colors.white,
          //                               borderRadius: BorderRadius.circular(20),
          //                               // boxShadow: [
          //                               //   BoxShadow(
          //                               //     color:
          //                               //         Colors.black.withOpacity(0.25),
          //                               //     spreadRadius: 0,
          //                               //     blurRadius: 7,
          //                               //     offset: Offset(0, 4),
          //                               //   ),
          //                               // ],
          //                             ),
          //                             child: const Align(
          //                               alignment: Alignment.center,
          //                               child: Text('0 Done',
          //                                   style: TextStyle(
          //                                       fontFamily: 'Roboto',
          //                                       fontSize: 12,
          //                                       color: Colors.red,
          //                                       fontWeight: FontWeight.bold)),
          //                             )),
          //                         Container(
          //                             height: 28,
          //                             width: 60,
          //                             decoration: BoxDecoration(
          //                               color: Colors.white,
          //                               borderRadius: BorderRadius.circular(20),
          //                               // boxShadow: [
          //                               //   BoxShadow(
          //                               //     color: Colors.black
          //                               //         .withOpacity(0.25),
          //                               //     spreadRadius: 0,
          //                               //     blurRadius: 7,
          //                               //     offset: Offset(0, 4),
          //                               //   ),
          //                               // ]
          //                             ),
          //                             child: const Align(
          //                               alignment: Alignment.center,
          //                               child: Text('0 Left',
          //                                   style: TextStyle(
          //                                       fontFamily: 'Roboto',
          //                                       fontSize: 12,
          //                                       color: Colors.red,
          //                                       fontWeight: FontWeight.bold)),
          //                             )),
          //                       ]),
          //                 )
          //               ],
          //             )),
          //         Container(
          //             height: 162,
          //             width: 149,
          //             decoration: BoxDecoration(
          //               border: Border.all(style: BorderStyle.solid),
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(20),
          //               // boxShadow: [
          //               //   BoxShadow(
          //               //     color: Colors.black.withOpacity(0.25),
          //               //     spreadRadius: 0,
          //               //     blurRadius: 7,
          //               //     offset: Offset(0, 4),
          //               //   ),
          //               // ],
          //             ),
          //             child: const Align(
          //               alignment: Alignment.center,
          //               child: Text(
          //                 'ADD +',
          //                 style: TextStyle(
          //                     fontFamily: 'Bebas',
          //                     color: Colors.black,
          //                     fontSize: 30,
          //                     fontWeight: FontWeight.w300,
          //                     letterSpacing: 4),
          //               ),
          //             ))
          //       ]),
          // )

          SlidingUpPanel(
            minHeight: 50,
            maxHeight: 200,
            panel: Container(
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Item 1'),
                  ),
                ],
              ),
            ),
            collapsed: Container(),
            isDraggable: false,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0)),
            onPanelClosed: () {
              setState(() {
                _isPanelOpen = false;
              });
            },
            onPanelOpened: () {
              setState(() {
                _isPanelOpen = true;
              });
            },
          ),
        ],
      ),
      // ),

      floatingActionButton: FloatingActionButton(
        
        onPressed: () {
          setState(() {
            _isPanelOpen = !_isPanelOpen;
          });
        },
        child: Icon(
          Icons.add,
          size: 40,
        ),
        backgroundColor: Color.fromARGB(255, 31, 31, 31),
        
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}


import 'package:flutter/material.dart';

void main() => runApp(const BottomSheetApp());

class BottomSheetApp extends StatelessWidget {
  const BottomSheetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Bottom Sheet Sample')),
        body: const BottomSheetExample(),
      ),
    );
  }
}

class BottomSheetExample extends StatelessWidget {
  const BottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.amber,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

