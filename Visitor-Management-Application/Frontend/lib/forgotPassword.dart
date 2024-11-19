import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:visitor_application/hostVisitorForm.dart';
import 'package:visitor_application/logIn.dart';

// import 'navbar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _showpassField = false;
  bool _showEmailField = true;
  String _verificationCode = "";
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password resent link sent! Check your email'),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
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
        // drawer: Navbar(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            toolbarHeight: 100,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   width: 15,
                  // ),
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                        fontSize: 17,
                        // color: Color(0xFFFE4C2D),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 15,
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                child: Center(
                  child: Text(
                    'Recover your password if you have forgot the password!',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                  child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (_showEmailField)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 9, 7, 5),
                        child: Text(
                          'Email',
                          style: TextStyle(
                              color: Color(0xFFF39D23),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    if (_showEmailField)
                      TextFormField(
                        controller: _emailController,
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
                            hintText: 'Please enter Email ID',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter visito\'s name';
                          }
                          if (value.contains(RegExp(r'[0-9]'))) {
                            return 'Name should not contain any numbers';
                          }
                          return null;
                        },
                      ),
                    if (!_showEmailField)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 9, 7, 5),
                        child: Text(
                          'Verification Code',
                          style: TextStyle(
                              color: Color(0xFFF39D23),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    if (!_showEmailField)
                      TextFormField(
                        // controller: _nameController,
                        onChanged: (value) {
                          setState(() {
                            _verificationCode = value;
                          });
                        },
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
                            hintText:
                                'Please enter verification code sent to email',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter visito\'s name';
                          }
                          if (value.contains(RegExp(r'[0-9]'))) {
                            return 'Name should not contain any numbers';
                          }
                          return null;
                        },
                      ),
                    if (_verificationCode.isNotEmpty && !_showpassField)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 9, 7, 5),
                        child: Text(
                          'New Password',
                          style: TextStyle(
                              color: Color(0xFFF39D23),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    if (_verificationCode.isNotEmpty && !_showpassField)
                      TextFormField(
                        // controller: _nameController,
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
                            hintText: 'Please enter new password',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter visito\'s name';
                          }
                          if (value.contains(RegExp(r'[0-9]'))) {
                            return 'Name should not contain any numbers';
                          }
                          return null;
                        },
                      ),
                    if (_verificationCode.isNotEmpty && !_showpassField)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 9, 7, 5),
                        child: Text(
                          'Confirm Password',
                          style: TextStyle(
                              color: Color(0xFFF39D23),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    if (_verificationCode.isNotEmpty && !_showpassField)
                      TextFormField(
                        // controller: _nameController,
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
                            hintText: 'Please confirm your password',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter visito\'s name';
                          }
                          if (value.contains(RegExp(r'[0-9]'))) {
                            return 'Name should not contain any numbers';
                          }
                          return null;
                        },
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                              child: SizedBox(
                                height: 30,
                                child: ElevatedButton(
                                  onPressed: () {
                                    passwordReset();
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => const LogIn()),
                                    // );
                                    // if (_formKey.currentState!.validate()) {
                                    //   _saveVisitor();
                                    //   _nameController.clear();
                                    //   _contactNumberController.clear();
                                    //   _emailController.clear();
                                    //   _OrganizationController.clear();
                                    //   _purposeOfVisitController.clear();
                                    //   _whomToMeetController.clear();
                                    //   dateInput.clear();
                                    //   timeinput.clear();
                                    // }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFF39D23),
                                      // side: BorderSide(
                                      //     width: 1.0, color: Color(0xFFFF5C00)),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
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
            ]),
          ),
        ),
      ),
    );
  }
}
