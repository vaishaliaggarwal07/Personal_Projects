
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
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
                        'Generate',
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
                        'NOTES',
                        style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'Bebas',
                            letterSpacing: 5,
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

          // Padding(
          //   padding: EdgeInsets.only(top: 40, left: 20, right: 20),
          Padding(
            padding: EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: Offset(0, 4)),
                ],
              ),
              child: Theme(
                data: ThemeData(
                    textSelectionTheme:
                        TextSelectionThemeData(cursorColor: Colors.red)),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.red,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 110,
                height: 28,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xabf8990c), Color(0xadff6d64)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: -3,
                        blurRadius: 20,
                        offset: Offset(0, 0)),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Generate',
                    style: TextStyle(
                        fontFamily: 'Bebas',
                        fontSize: 15,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ),

          // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          //   Padding(
          //     padding: EdgeInsets.only(left: 22.0, bottom: 0.0, top: 49.0),
          //     child: Align(
          //       alignment: Alignment.bottomLeft,
          //       child: Text(
          //         'Generate',
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
          //
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'IMPORTANT',
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
                      fontSize: 15, fontFamily: 'Roboto', color: Colors.red),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Container(
              height: 60,
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
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Container(
              height: 60,
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
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'RECENT',
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
                      fontSize: 15, fontFamily: 'Roboto', color: Colors.red),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Container(
              height: 60,
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
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Container(
              height: 60,
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
            ),
          ),
        ]),
      ),
    );
  }
}
