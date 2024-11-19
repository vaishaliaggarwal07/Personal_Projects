import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:visitor_application/visitor.dart';
// import 'package:visitor_application/visitors_list.dart';

class EditVisitorForm extends StatefulWidget {
  final Visitor visitor;
  const EditVisitorForm({required this.visitor});

  @override
  EditVisitorFormState createState() {
    return EditVisitorFormState();
  }
}

class EditVisitorFormState extends State<EditVisitorForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _purposeOfVisitController = TextEditingController();
  TextEditingController _whomToMeetController = TextEditingController();
  TextEditingController _OrganizationController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeinput = TextEditingController();

  @override
  void initState() {
    dateInput.text = widget.visitor.visit_date;
    timeinput.text = widget.visitor.visit_time;
    _nameController.text = widget.visitor.visitor_name;
    _emailController.text = widget.visitor.visitor_email;
    _contactNumberController.text = widget.visitor.visitor_phone_number;
    _purposeOfVisitController.text = widget.visitor.visitor_purpose;
    _whomToMeetController.text = widget.visitor.visitor_whom_meet;
    _OrganizationController.text = widget.visitor.visitor_organization;
    // final visitorId = widget.visitor.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 9, 7, 5),
              child: Text(
                'Name',
                style: TextStyle(
                    color: Color(0xFFF39D23),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500),
              ),
            ),
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFF797979),
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(15, 25, 25, 0),
                  // labelText: 'Enter Name',
                  // hintText: 'Enter Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 9, 7, 5),
              child: Text(
                'Visitor Organization',
                style: TextStyle(
                    color: Color(0xFFF39D23),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500),
              ),
            ),
            TextFormField(
              controller: _OrganizationController,
              keyboardType: TextInputType.text,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFF797979),
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(15, 25, 25, 0),
                  // labelText: 'Enter Name',
                  hintText: 'Please enter organization',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 9, 7, 5),
              child: Text(
                'Here to meet?',
                style: TextStyle(
                    color: Color(0xFFF39D23),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500),
              ),
            ),
            TextFormField(
              controller: _whomToMeetController,
              keyboardType: TextInputType.name,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFF797979),
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(15, 25, 25, 0),
                  // labelText: 'Enter Name',
                  hintText: 'Please enter person name whom you want to meet',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 9, 7, 5),
              child: Text(
                'Visitor Email ID',
                style: TextStyle(
                    color: Color(0xFFF39D23),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500),
              ),
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFF797979),
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(15, 25, 25, 0),
                  // labelText: 'Enter Name',
                  hintText: 'Please enter email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 9, 7, 5),
              child: Text(
                'Visitor Contact number',
                style: TextStyle(
                    color: Color(0xFFF39D23),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500),
              ),
            ),
            TextFormField(
              controller: _contactNumberController,
              keyboardType: TextInputType.phone,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFF797979),
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(15, 25, 25, 0),
                  // labelText: 'Enter Name',
                  hintText: 'Please enter mobile number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 9, 7, 5),
              child: Text(
                'Visiting Purpose',
                style: TextStyle(
                    color: Color(0xFFF39D23),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500),
              ),
            ),
            TextFormField(
              controller: _purposeOfVisitController,
              keyboardType: TextInputType.text,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFF797979),
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(15, 25, 25, 0),
                  // labelText: 'Enter Name',
                  hintText: 'Please enter visiting purpose',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 130,
                    child: TextField(
                      controller: dateInput,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xFFFF2600),
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(15, 25, 25, 0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.calendar_today,
                              size: 15,
                              color: Color(0xFFFF2600),
                            ),
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2100),
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly,
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: Color(0xFFFFFFFF),
                                          onPrimary: Color(0xFFFF2600),
                                          // onSurface: Color(0xFFF39D23)),
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Color(
                                                0xFFF39D23), // button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  });

                              if (pickedDate != null) {
                                print(pickedDate);
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(formattedDate);
                                setState(() {
                                  dateInput.text = formattedDate;
                                });
                              } else {
                                print(DateTime.now());
                              }
                            },
                          ),
                          hintText: "Enter Date"),
                      readOnly: true,
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: TextField(
                      controller: timeinput,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xFFFF2600),
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(15, 25, 25, 0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.timer,
                              size: 15,
                              color: Color(0xFFFF2600),
                            ),
                            onPressed: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode:
                                      TimePickerEntryMode.dialOnly,
                                  context: context,
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: Color(0xFFFF2600),
                                          onPrimary: Color(0xFFFFFFFF),
                                          onSurface: Color(0xFFF39D23),
                                        ),
                                        // textButtonTheme: TextButtonThemeData(
                                        //   style: TextButton.styleFrom(
                                        //     backgroundColor: Color(0xFFF39D23),
                                        //     // button text color
                                        //   ),
                                        // ),
                                        // buttonTheme: ButtonThemeData(
                                        //   colorScheme: ColorScheme.light(
                                        //     primary: Colors.green,
                                        //   ),
                                        // ),
                                      ),
                                      child: child!,
                                    );
                                  });

                              if (pickedTime != null) {
                                print(pickedTime.format(context));
                                DateTime parsedTime = DateFormat.jm().parse(
                                    pickedTime.format(context).toString());
                                //converting to DateTime so that we can further format on different pattern.
                                print(
                                    parsedTime); //output 1970-01-01 22:53:00.000
                                String formattedTime =
                                    DateFormat('HH:mm:ss').format(parsedTime);
                                print(formattedTime); //output 14:59:00
                                //DateFormat() is from intl package, you can format the time on any pattern you need.

                                setState(() {
                                  timeinput.text =
                                      formattedTime; //set the value of text field.
                                });
                              } else {
                                print("time not selected");
                              }
                            },
                          ),
                          hintText: "Enter Time"),
                      readOnly: true,
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _submitForm();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF39D23),
                            side: BorderSide(
                                width: 1.0, color: Color(0xFFFF5C00)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text(
                          'Submit',
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
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    widget.visitor.visitor_name = _nameController.text;
    widget.visitor.visitor_email = _emailController.text;
    widget.visitor.visitor_phone_number = _contactNumberController.text;
    widget.visitor.visitor_organization = _OrganizationController.text;
    widget.visitor.visitor_purpose = _purposeOfVisitController.text;

    widget.visitor.visitor_whom_meet = _whomToMeetController.text;

    final visitorId = widget.visitor.id;
    print(visitorId);
    // int visitorIndex = visitorsList.indexOf(widget.visitor);
    // if (visitorIndex != -1) {
    //   visitorsList[visitorIndex] = widget.visitor;
    // }

    final apiUrl = Uri.parse('http://20.55.109.32:80/update_visitor');
    final updatedVisitorFields = {
      'id': widget.visitor.id,
      'visitor_name': widget.visitor.visitor_name,
      'visitor_email': widget.visitor.visitor_email,
      'visitor_phone_number': widget.visitor.visitor_phone_number,
      'visitor_organization': widget.visitor.visitor_organization,
      'visitor_purpose': widget.visitor.visitor_purpose,
      'visitor_whom_meet': widget.visitor.visitor_whom_meet,
    };
    print(updatedVisitorFields);
    final response = await http.patch(apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedVisitorFields));
    if (response.statusCode == 200) {
      // Successfully updated on the server
      Navigator.pop(context, widget.visitor);
    } else {
      // Handle error
      print('Error updating data on the server.');
    }
  }
  // ${widget.visitor.id}
}
