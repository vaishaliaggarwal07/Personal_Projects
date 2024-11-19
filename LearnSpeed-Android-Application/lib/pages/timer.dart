import 'package:flutter/material.dart';

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({Key? key}) : super(key: key);
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
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
                      child: Text(
                        'Timer',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                            color: Colors.red),
                      )
                      // ),
                      ),
                  // ),
                  Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      // child: Align(
                      //     alignment: Alignment.topLeft,
                      child: Text(
                        'POMODORO',
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
              
              height: 360,
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

              child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.topRight,
                    
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        
                      color: Colors.black,
                        borderRadius: BorderRadius.circular(3),
                         boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: -3,
                    blurRadius: 20,
                    offset: Offset(0, 0)),
              ],
                        ),
                      alignment: Alignment.center,
                         child: Icon(Icons.add,size: 16,color: Colors.white,)
                          
                    
                    ),
                  ),
                ),

              
              ]
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              width: 40,
              height: 40,
              // margin: 1,
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
              color: Colors.transparent,
              border: Border.all(
                // color: Colors.white,
                width: 2
              ),
              
              
              ),
                    
                    
                      child: 
                      Icon(Icons.play_arrow,
                      size: 40,
                      color: Colors.red,
                      )
                      
                  
            ),
          )
          // Padding(
          //   padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          //   child: Container(
          //       // width: 300,
          //       width: 315,
          //       height: 80,
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(20),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black.withOpacity(0.25),
          //             spreadRadius: 0,
          //             blurRadius: 7,
          //             offset: Offset(0, 4),
          //           ),
          //         ],
          //       ),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Text(
          //             'PomoDoro 1',
          //             style: TextStyle(
          //                 fontFamily: 'Roboto',
          //                 fontSize: 20,
          //                 color: Colors.red,
          //                 fontWeight: FontWeight.bold),
          //           ),
          //           Text('15min: Working, 3min: Break',
          //               style: TextStyle(
          //                 fontFamily: 'Roboto',
          //               )),
          //         ],
          //       )),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(top: 15, left: 20, right: 20),
          //   child: Container(
          //       // width: 300,
          //       width: 315,
          //       height: 80,
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(20),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black.withOpacity(0.25),
          //             spreadRadius: 0,
          //             blurRadius: 7,
          //             offset: Offset(0, 4),
          //           ),
          //         ],
          //       ),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Text(
          //             'PomoDoro 2',
          //             style: TextStyle(
          //                 fontFamily: 'Roboto',
          //                 fontSize: 20,
          //                 color: Colors.red,
          //                 fontWeight: FontWeight.bold),
          //           ),
          //           Text('25min: Working, 5min: Break',
          //               style: TextStyle(
          //                 fontFamily: 'Roboto',
          //               )),
          //         ],
          //       )),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(top: 15, left: 20, right: 20),
          //   child: Container(
          //       // width: 300,
          //       width: 315,
          //       height: 80,
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(20),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black.withOpacity(0.25),
          //             spreadRadius: 0,
          //             blurRadius: 7,
          //             offset: Offset(0, 4),
          //           ),
          //         ],
          //       ),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Text(
          //             'PomoDoro 3',
          //             style: TextStyle(
          //                 fontFamily: 'Roboto',
          //                 fontSize: 20,
          //                 color: Colors.red,
          //                 fontWeight: FontWeight.bold),
          //           ),
          //           Text('45min: Working, 15min: Break',
          //               style: TextStyle(
          //                 fontFamily: 'Roboto',
          //               )),
          //         ],
          //       )),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(top: 15, left: 20, right: 20),
          //   child: Container(
          //       // width: 300,
          //       width: 315,
          //       height: 80,
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(20),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black.withOpacity(0.25),
          //             spreadRadius: 0,
          //             blurRadius: 7,
          //             offset: Offset(0, 4),
          //           ),
          //         ],
          //       ),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Text(
          //             'PomoDoro 4',
          //             style: TextStyle(
          //                 fontFamily: 'Roboto',
          //                 fontSize: 20,
          //                 color: Colors.red,
          //                 fontWeight: FontWeight.bold),
          //           ),
          //           Text('90min: Working, 30min: Break',
          //               style: TextStyle(
          //                 fontFamily: 'Roboto',
          //               )),
          //         ],
          //       )),
          // )
          // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          //   Padding(
          //     padding: EdgeInsets.only(left: 22.0, bottom: 0.0, top: 49.0),
          //     child: Align(
          //       alignment: Alignment.bottomLeft,
          //       child: Text(
          //         'Timer',
          //         style: TextStyle(
          //             fontSize: 15,
          //             fontFamily: 'Roboto',
          //             fontWeight: FontWeight.w300,
          //             color: Colors.red),
          //       ),
          //     ),
          //   ),
          //   Padding(
          //     padding: EdgeInsets.only(right: 20.0, top: 50.0),
          //     child: Icon(
          //       Icons.notifications,
          //       size: 40,
          //     ),
          //   ),
          // ]),
          // Padding(
          //   padding: EdgeInsets.only(left: 20.0),
          //   child: Align(
          //       alignment: Alignment.topLeft,
          //       child: Text(
          //         'POMODORO',
          //         style: TextStyle(
          //             fontSize: 32,
          //             fontFamily: 'Bebas',
          //             letterSpacing: 2,
          //             fontWeight: FontWeight.w400),
          //       )),
          // ),
        ],
      ),
    ));
  }
}
