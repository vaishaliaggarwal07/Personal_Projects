import 'dart:convert';
// import 'dart:html';
import 'dart:math';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:visitor_application/signUp.dart';
import 'package:http/http.dart' as http;

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification(String recipientEmail) async {
    const apiUrl = 'http://20.55.109.32:80/send-verification-email';
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'recipientEmail': recipientEmail}));
      if (response.statusCode == 200) {
        print('Email sent successfully');
      } else {
        print('failed to send email');
      }
    } catch (error) {
      throw Exception('error sending email:$error');
    }
  }

  String _generateRandomOTP() {
    return Random().nextInt(1000000).toString().padLeft(6, '0');
  }

  Future<void> verifyOtpAndRegister(
    String enteredOTP,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('http://20.55.109.32:80/verify-otp'),
      body: jsonEncode({'enteredOTP': enteredOTP, 'email': email}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final verificationResult = jsonDecode(response.body)['verified'];

      if (verificationResult) {
        await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print('User verified and registered successfully');
      } else {
        print('OTP verification failed');
      }
    } else {
      print('Error verifying OTP');
    }
    // String generatedOTP = await sendEmailVerification(email);
    // if (enteredOTP == generatedOTP) {
    //   await _firebaseAuth.createUserWithEmailAndPassword(
    //       email: email, password: password);

    //   print('user verified and added sucessfully');
    // }
  }
}
