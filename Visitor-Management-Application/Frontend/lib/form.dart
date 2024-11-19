// import 'dart:io';
// import 'package:file_picker/_internal/file_picker_web.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'dart:html' as html;

// import 'package:visitor_application/visitorListPage.dart';
import 'package:visitor_application/visitorPass.dart';
import 'package:visitor_application/visitors_list.dart';

// import 'uploadImage.dart';
import 'visitor.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  // File? image;
  MemoryImage? image;
  final _formKey = GlobalKey<FormState>();
  String imageFilename = '';
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _purposeOfVisitController = TextEditingController();
  TextEditingController _whomToMeetController = TextEditingController();
  TextEditingController _OrganizationController = TextEditingController();

  TextEditingController dateInput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  // Future pickImage(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     if (image == null) return;

  //     final imageTemporary = File(image.path);
  //     setState(() => this.image = imageTemporary as MemoryImage?);

  //     if (image != null) {
  //       await sendImageToBackend(image);
  //     }
  //   } catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }
  // Future<Visitor> fetchVisitorDataFromBackend(int visitorId) async {
  //   Uri apiUrl = Uri.parse(
  //       'http://localhost:3000/all_visitor/$visitorId'); // Update the URL endpoint accordingly

  //   try {
  //     final response = await http.get(apiUrl);

  //     if (response.statusCode == 200) {
  //       // Parse the JSON response and create a Visitor object
  //       final Map<String, dynamic> jsonData = json.decode(response.body);

  //       Visitor fetchedVisitor = Visitor(
  //         status_visitor: jsonData['status_visitor'],
  //         id: jsonData['id'],
  //         visitor_name: jsonData['visitor_name'],
  //         visitor_email: jsonData['visitor_email'],
  //         visitor_phone_number: jsonData['visitor_phone_number'],
  //         visitor_organization: jsonData['visitor_organization'],
  //         visitor_purpose: jsonData['visitor_purpose'],
  //         visitor_whom_meet: jsonData['visitor_whom_meet'],
  //         visit_date: jsonData['visit_date'],
  //         visit_time: jsonData['visit_time'],
  //         image_filename: jsonData['image_filename'],
  //         image_url: jsonData['image_url'],
  //       );

  //       return fetchedVisitor;
  //     } else {
  //       throw Exception('Failed to fetch visitor data');
  //     }
  //   } catch (e) {
  //     throw Exception('Error connecting to the backend: $e');
  //   }
  // }

  Future<List<Visitor>> fetchVisitors() async {
    final apiUrl = Uri.parse('http://20.55.109.32:80/all_visitor');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      List<Visitor> updatedList =
          jsonData.map((item) => Visitor.fromJson(item)).toList();
      // updatedList.sort((a, b) => b.visit_date.compareTo(a.visit_date));
      return updatedList;
    } else {
      throw Exception('Error fetching visitors from the server.');
    }
  }

  Future<void> pickImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      final imageBytes = await image.readAsBytes();
      await sendImageToBackend(Uint8List.fromList(imageBytes));
    }
  }

  Future<void> sendImageToBackend(Uint8List imageBytes) async {
    final apiUrl = Uri.parse(
        'http://20.55.109.32:80/upload'); // Change this URL to your backend API URL
    var request = http.MultipartRequest('POST', apiUrl)
      ..files.add(http.MultipartFile.fromBytes('image', imageBytes,
          filename: 'image.jpg'));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        // Image uploaded successfully
        print('Image uploaded to the backend.');
      } else {
        print('Error uploading image to the backend.');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  void initState() {
    DateTime currentDate = DateTime.now();
    dateInput.text = DateFormat('dd-MM-yy').format(currentDate);
    timeinput.text = DateFormat('HH:mm').format(currentDate);
    super.initState();
  }

  Widget selectedImageWidget() {
    if (image != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.memory(
            image!.bytes,
            width: 50,
            height: 50,
          ),
          // child: const Text(
          //   'Image uploaded',
          //   style: TextStyle(
          //       fontFamily: 'Roboto', color: Color(0xFF797979), fontSize: 14),
          // ),
        ),
      );
      // return Container(
      //     width: 100, height: 100, child: Image.memory(image!.bytes));
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'No image selected',
            style: TextStyle(
                fontFamily: 'Roboto', color: Color(0xFF797979), fontSize: 14),
          ),
        ),
      );
    }
  }

  final RegExp _phoneNumberRegExp = RegExp(r'^[0-9]{10}$');
  final RegExp _emailRegExp = RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$');

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
                'Visitor Name *',
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
                  hintText: 'Enter Name',
                  hintStyle: TextStyle(
                    color: Color(0xFF797979),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter visitor\'s name';
                }
                if (value.contains(RegExp(r'[0-9]'))) {
                  return 'Name should not contain any numbers';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 9, 7, 5),
              child: Text(
                'Visitor Organization *',
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
                  hintStyle: TextStyle(
                    color: Color(0xFF797979),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter organization\'s name';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 9, 7, 5),
              child: Text(
                'Here to meet? *',
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
                  hintText: 'Please enter whom to meet',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter whom you want to meet?';
                }
                if (value.contains(RegExp(r'[0-9]'))) {
                  return 'Whom to meet should not contain any numbers';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 9, 7, 5),
              child: Text(
                'Visitor Email ID *',
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
                  hintText: 'Please enter email ',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter visitor\'s email';
                } else if (!_emailRegExp.hasMatch(value)) {
                  return 'Invalid email address';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 9, 7, 5),
              child: Text(
                'Visitor Contact number *',
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
                  return 'Please enter visitor\'s contact number';
                } else if (!_phoneNumberRegExp.hasMatch(value)) {
                  return 'Invalid phone number';
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
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter some text';
              //   }
              //   return null;
              // },
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton.icon(
                          onPressed: () {
                            pickImageFromCamera();
                            // if (kIsWeb) {
                            //   // pickImageFromGallery();
                            // } else {
                            //   print('failed');
                            //   // pickImage(ImageSource.camera);
                            //   // Navigator.push(
                            //   //   context,
                            //   //   MaterialPageRoute(
                            //   //       builder: (context) => UploadImage()),
                            //   // );
                            // }

                            // pickImage(ImageSource.gallery);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => UploadImage()),
                            // );
                          },
                          icon: Icon(
                            Icons.add_a_photo_outlined,
                            color: Color(0xFFF39D23),
                          ),
                          label: Text(
                            'Take a picture',
                            style: TextStyle(
                                color: Color(0xFFF39D23),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(
                                width: 1.0, color: Color(0xFFFF5C00)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          )),
                    ),
                  ),
                ),
              ],
            ),
            selectedImageWidget(),
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
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(formattedDate);
                                setState(() {
                                  dateInput.text = formattedDate;
                                });
                              } else {
                                setState(() {
                                  dateInput.text = DateTime.now() as String;
                                });
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
                                setState(() {
                                  timeinput.text = DateTime.now() as String;
                                });
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
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _saveVisitor();
                            _nameController.clear();
                            _contactNumberController.clear();
                            _emailController.clear();
                            _OrganizationController.clear();
                            _purposeOfVisitController.clear();
                            _whomToMeetController.clear();
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

  void _saveVisitor() async {
    String visitorName = _nameController.text;
    String visitorPhoneNumber = _contactNumberController.text;
    String visitorOrganization = _OrganizationController.text;
    String visitorEmail = _emailController.text;
    String visitorWhomMeet = _whomToMeetController.text;
    String visitDate = dateInput.text;
    String visitorPurpose = _purposeOfVisitController.text;
    String visitTime = timeinput.text;
    if (visitDate.isEmpty) {
      visitDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    }
    if (visitTime.isEmpty) {
      visitDate = DateFormat('HH:mm').format(DateTime.now());
    }
    Visitor newVisitor = Visitor(
        status_visitor: false,
        id: 0,
        visitor_name: visitorName,
        visitor_email: visitorEmail,
        visitor_phone_number: visitorPhoneNumber,
        visitor_organization: visitorOrganization,
        visitor_purpose: visitorPurpose,
        visitor_whom_meet: visitorWhomMeet,
        visit_date: visitDate,
        visit_time: visitTime,
        image_filename: '',
        image_url: '');

    setState(() {
      visitorsList.insert(0, newVisitor);
      // newvisitorsList.add(newVisitor);
    });

    List<Map<String, dynamic>> visitorJsonList =
        visitorsList.map((visitor) => visitor.toJson()).toList();

    Uri apiUrl = Uri.parse('http://20.55.109.32:80/insert_visitor');
    final response = await http.post(
      apiUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(visitorJsonList),
    );
    print(visitorJsonList);
    if (response.statusCode == 200) {
      List<Visitor> fetchedVisitor = await fetchVisitors();
      print(fetchedVisitor.first.id);
      print(newVisitor.visitor_name);
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VisitorPass(
                    visitor: fetchedVisitor.first,
                  )));
    } else {
      // Handle error.
      print('Error sending data to the backend.');
    }
  }
}
