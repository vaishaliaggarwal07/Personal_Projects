import 'package:flutter/material.dart';
import 'package:visitor_application/editInfoForm.dart';
import 'package:visitor_application/visitor.dart';

import 'navbar.dart';

class EditVisitor extends StatelessWidget {
  final Visitor visitor;
  const EditVisitor({required this.visitor});

  @override
  Widget build(BuildContext context) {
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
                Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.cover,
                  // height: 500,
                  width: 200,
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () => {},
                    child: Text(
                      'Edit Visitor',
                      style: TextStyle(
                          fontSize: 17,
                          color: Color(0xFFFE4C2D),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Color(0xFFF39D23),
              ),
              EditVisitorForm(visitor: visitor),
            ]),
          ),
        ),
      ),
    );
  }
}
