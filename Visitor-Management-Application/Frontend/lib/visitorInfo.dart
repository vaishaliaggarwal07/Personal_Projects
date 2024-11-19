import 'package:flutter/material.dart';
import 'package:visitor_application/editInfo.dart';
import 'package:visitor_application/thank_you.dart';
import 'package:http/http.dart' as http;
// import 'package:visitor_application/userDeleted.dart';
import 'navbar.dart';
import 'visitor.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// ignore: must_be_immutable
class VisitorsInfo extends StatefulWidget {
  Visitor visitor;
  final Future<void> Function() fetchAndUpdateVisitorsList;

  VisitorsInfo(
      {required this.visitor, required this.fetchAndUpdateVisitorsList});

  @override
  State<VisitorsInfo> createState() => _VisitorsInfoState();
}

class _VisitorsInfoState extends State<VisitorsInfo> {
  @override
  void initState() {
    super.initState();
    _isCheckedOut = widget.visitor.status_visitor;
  }

  bool _isCheckedOut = false;

  Future<void> checkOutVisitor(int visitorId) async {
    final apiUrl = Uri.parse('http://20.55.109.32:80/check_out?id=$visitorId');
    final response = await http.patch(apiUrl);
    print(visitorId);
   
    if (response.statusCode == 200) {
      print('Visitor checked out successfully');
      // Update the _isCheckedOut state here if needed
    } else {
      print('Error checking out visitor');
    }
  }

  Future<void> _handleCheckOut() async {
    if (_isCheckedOut) {
      await checkOutVisitor(
          widget.visitor.id); // Update visitor status in the database
      setState(() {
        _isCheckedOut = !_isCheckedOut;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ThankYou()));
    }
  }

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this visitor?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleDelete(BuildContext context) async {
    bool confirmDeletion =
        (await _showDeleteConfirmationDialog(context) as bool);

    if (confirmDeletion) {
      // Perform the deletion logic
      final response = await http.patch(
        Uri.parse('http://20.55.109.32:80/delete_visitor'),
        body: {'id': widget.visitor.id.toString()},
      );

      if (response.statusCode == 200) {
        // Show the success pop-up
        // ignore: use_build_context_synchronously
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('User Deleted'),
              content: Text('The user has been deleted.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    widget.fetchAndUpdateVisitorsList();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(); // Go back to visitor list
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('Error deleting visitor');
      }
    }
  }

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
            title:
                // SizedBox(
                //   height: 50,
                // ),

                Image.asset(
              'assets/logo.png',
              fit: BoxFit.cover,
              // height: 500,
              width: 200,
            ),
          ),
        ),
        body: Center(
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   width: 8,
                // ),
                Text(
                  'Visitor Info',
                  style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFFFE4C2D),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Divider(
              color: Color(0xFFF39D23),
            ),
            SizedBox(
              height: 50,
            ),
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(widget.visitor.image_url),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          width: 100,
                          child: Text(
                            'Name',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400),
                          )),
                      SizedBox(
                          width: 170,
                          child: Text(
                            widget.visitor.visitor_name,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFF2600)),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          width: 100,
                          child: Text(
                            'Organization',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400),
                          )),
                      SizedBox(
                          width: 170,
                          child: Text(
                            widget.visitor.visitor_organization,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFF2600)),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          width: 100,
                          child: Text(
                            'Email',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400),
                          )),
                      SizedBox(
                          width: 170,
                          child: Text(
                            widget.visitor.visitor_email,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFF2600)),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          width: 100,
                          child: Text(
                            'Mobile No.',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400),
                          )),
                      SizedBox(
                          width: 170,
                          child: Text(
                            widget.visitor.visitor_phone_number,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFF2600)),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          width: 100,
                          child: Text(
                            'Meet with',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400),
                          )),
                      SizedBox(
                          width: 170,
                          child: Text(
                            widget.visitor.visitor_whom_meet,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFF2600)),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          width: 100,
                          child: Text(
                            'Date',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400),
                          )),
                      SizedBox(
                          width: 170,
                          child: Text(
                            widget.visitor.visit_date,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFF2600)),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 35,
                          // width: 120,
                          child: ElevatedButton.icon(
                              onPressed:
                                  !_isCheckedOut ? null : _handleCheckOut,
                              icon: Icon(
                                // <-- Icon
                                Icons.outbond_outlined,
                                size: 15.0,
                                color: Color(0xFFFE4C2D),
                              ),
                              label: Text(
                                !_isCheckedOut ? 'Checked Out' : 'Check Out',
                                style: TextStyle(
                                    color: Color(0xFFFE4C2D),
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                    width: 1.0, color: Color(0xFFFF5C00)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ) // <-- Text
                              ),
                        ),
                        SizedBox(
                          // width: 120,
                          height: 35,
                          child: ElevatedButton.icon(
                              onPressed: !_isCheckedOut
                                  ? null
                                  : () async {
                                      final updatedVisitor =
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditVisitor(
                                                        visitor: widget.visitor,
                                                      )));
                                      if (updatedVisitor != null) {
                                        setState(() {
                                          widget.visitor = updatedVisitor;
                                        });
                                      }
                                    },
                              icon: Icon(
                                // <-- Icon
                                Icons.edit,
                                size: 17.0,
                                color: Color(0xFFFE4C2D),
                              ),
                              label: Text(
                                'Edit',
                                style: TextStyle(
                                    color: Color(0xFFFE4C2D),
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                    width: 1.0, color: Color(0xFFFF5C00)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ) // <-- Text
                              ),
                        ),
                        SizedBox(
                          // width: 100,
                          height: 35,
                          child: ElevatedButton.icon(
                              onPressed: !_isCheckedOut
                                  ? null
                                  : () async {
                                      await _handleDelete(context);
                                    },
                              icon: Icon(
                                // <-- Icon
                                Icons.delete,
                                size: 15.0,
                                color: Color(0xFFFE4C2D),
                              ),
                              label: Text(
                                'Delete',
                                style: TextStyle(
                                    color: Color(0xFFFE4C2D),
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                    width: 1.0, color: Color(0xFFFF5C00)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ) // <-- Text
                              ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
