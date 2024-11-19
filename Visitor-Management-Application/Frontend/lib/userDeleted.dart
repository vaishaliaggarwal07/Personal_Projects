import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visitor_application/navbar.dart';
import 'package:visitor_application/visitorListPage.dart';

class UserDeleted extends StatefulWidget {
  UserDeleted({Key? key}) : super(key: key);
  // const ThankYou({super.key});

  @override
  State<UserDeleted> createState() => _UserDeletedState();
}

class _UserDeletedState extends State<UserDeleted> {
  late DateTime checkoutTime;
  late Timer timer;
  @override
  // void initStae() {
  //   super.initState();
  //   checkoutTime = DateTime.now();
  //   timer = Timer.periodic(Duration(minutes: 1), (Timer t) {
  //     setState(() {
  //       checkoutTime = DateTime.now();
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   timer.cancel();
  //   super.dispose();
  // }

  // @override
  Widget build(BuildContext context) {
    // String hourMinute = DateFormat('hh:mm').format(checkoutTime);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFF6e5), Color(0xFFF39D23)],
      )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          drawer: Navbar(),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBar(
              toolbarHeight: 100,
              backgroundColor: Colors.transparent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 50,
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.cover,
                      // height: 500,
                      width: 180,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 90, 15, 15),
                  child: Image.asset(
                    'thankyou.png',
                    height: 200,
                  ),
                ),
                Text(
                  'User has been deleted',
                  style: TextStyle(
                      color: Color(0xFFFE4C2D),
                      fontSize: 26,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Go back to visitor\'s list ',
                    style: TextStyle(
                        color: Color(0xFFFE4C2D),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 10, 60, 0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VisitorsListPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFF39D23),
                                  side: BorderSide(
                                      width: 1.0, color: Color(0xFFFF5C00)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Text(
                                'Visitor\'s list',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
