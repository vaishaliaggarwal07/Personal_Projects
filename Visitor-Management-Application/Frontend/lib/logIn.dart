import 'package:flutter/material.dart';
import 'package:visitor_application/forgotPassword.dart';
// import 'package:visitor_application/hostVisitorForm.dart';
import 'package:visitor_application/main.dart';
import 'package:visitor_application/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visitor_application/auth.dart';

// import 'navbar.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String? errorMessage = '';
  bool isLogin = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SecondRoute()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
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
                    'LOGIN',
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
                    'Login now to track all your Visitor\'s list ',
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
                        'Email',
                        style: TextStyle(
                            color: Color(0xFFF39D23),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
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
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains(RegExp(r'^[a-zA-Z0-9._%+-]+@metaorangedigital\.com$'))) {
                          return 'Please enter valid metaorange email id';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 9, 7, 5),
                      child: Text(
                        'Your Password',
                        style: TextStyle(
                            color: Color(0xFFF39D23),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
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
                          hintText: 'Please enter Password',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 9, 7, 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Color(0xFFF39D23),
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
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
                                    signInWithEmailAndPassword();
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const SecondRoute()),
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
                                    'Login',
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
                        Text('Don\'t have an account? '),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()),
                            );
                          },
                          child: Text(
                            'Register',
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
