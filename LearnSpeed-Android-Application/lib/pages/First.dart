import 'package:flutter/material.dart';

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xabf8990c), Color(0xadff6d64)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          // padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Padding(
              padding: EdgeInsets.only(right: 20.0, top: 50.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.notifications,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 27.0, bottom: 0.0),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Welcome',
                    style: TextStyle(fontSize: 20,fontFamily: 'Roboto',fontWeight: FontWeight.w300,color: Color.fromARGB(1, 206, 18, 18)),
                  )),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 27.0, top: 0.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Akshat Roy',
                    style: TextStyle(fontSize: 48, fontFamily: 'Bebas',letterSpacing: 8,fontWeight: FontWeight.w400,color: Color.fromARGB(1, 0, 0, 0)),
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 27.0, bottom: 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Please Create New Tasks and Profiles',
                  style: TextStyle(fontSize: 14,fontFamily: 'Roboto',fontWeight: FontWeight.w300,color: Color.fromARGB(1, 19, 18, 18)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 27.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'TASK LISTS',
                      style: TextStyle(fontSize: 20,fontFamily: 'Bebas',letterSpacing: 8,fontWeight: FontWeight.w400,color: Color.fromARGB(1, 0, 0, 0)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed: null,
                        child: const Text('create new',
                        style: TextStyle(fontFamily: 'Roboto',fontSize: 15,fontWeight: FontWeight.w300,color: Color.fromARGB(1, 206, 18, 18)),
                        ),
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 27.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'PROFILE',
                      style: TextStyle(fontSize: 20,fontFamily: 'Bebas',letterSpacing: 8,fontWeight: FontWeight.w400,color: Color.fromARGB(1,0,0,0)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed: null,
                        child: const Text('create new',
                        style: TextStyle(fontFamily: 'Roboto',fontSize: 15,fontWeight: FontWeight.w300,color: Color.fromARGB(1,206,18,18))
                        ),
                      ),
                    ),
                  ]),
            )
          ]),
        ),
      ),
    );
  }
}
