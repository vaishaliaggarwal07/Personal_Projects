import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:visitor_application/hostVisitorForm.dart';
import 'package:visitor_application/logIn.dart';
// import 'package:visitor_application/signUp.dart';

import 'auth.dart';
// import 'navbar.dart';

class VerifyAccount extends StatefulWidget {
  final String email;
  final String password;
  const VerifyAccount({super.key, required this.email, required this.password});

  @override
  State<VerifyAccount> createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  String? errorMessage = '';
  final TextEditingController _verificationCodeController =
      TextEditingController();

  Future<void> verifyOtpAndRegister() async {
    String verificationCode = _verificationCodeController.text;
    if (_verificationCodeController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all the fields';
      });
      return;
    }

    try {
      await Auth().verifyOtpAndRegister(
          verificationCode, widget.email, widget.password);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LogIn()),
      );
      // Registration with OTP verification successful
      // Navigate to the next page or perform any necessary actions
    } on FirebaseAuthException catch (e) {
      // Handle OTP verification error
      print('error ${e}');
      // Display an error message to the user
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
                    'REGISTER',
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
                    'We have sent an email to your email account with a verification code!',
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
                  autovalidateMode: AutovalidateMode.always,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                        TextFormField(
                          controller: _verificationCodeController,
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
                              contentPadding:
                                  EdgeInsets.fromLTRB(15, 25, 25, 0),
                              // labelText: 'Enter Name',
                              hintText: 'Please enter Name',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter verification code';
                            }

                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 30, 0, 30),
                                  child: SizedBox(
                                    height: 30,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        verifyOtpAndRegister();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFFF39D23),
                                          // side: BorderSide(
                                          //     width: 1.0, color: Color(0xFFFF5C00)),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      child: Text(
                                        'Register',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Already have an account? '),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LogIn()),
                                );
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
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
