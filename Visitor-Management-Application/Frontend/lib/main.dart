import 'package:flutter/material.dart';
import 'package:visitor_application/form.dart';
import 'package:visitor_application/navbar.dart';
import 'package:visitor_application/signUp.dart';
import 'widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // options: FirebaseOptions(
  //     apiKey: "AIzaSyDsBBxPVZO8gsYznVnUT0ftKYuSCLN9joM",
  //     appId: "1:989992678108:web:30be8fb8ca684bf2fffa19",
  //     messagingSenderId: "989992678108",
  //     projectId: "visitorapp-561df"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // colorScheme:
        //     ColorScheme.fromSeed(seedColor: Color.fromARGB(1, 255, 246, 229)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: WidgetTree(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF6E5),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          // title: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          title: Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.cover,
              // height: 500,
              width: 200,
            ),
          ),
          //   ],
          // ),
        ),
      ),

      body: Center(
        child: Column(children: [
          SizedBox(
            height: 100,
          ),
          Text(
            'Welcome to Metaorange',
            style: TextStyle(
                color: Color(0xFFFE4C2D),
                fontSize: 25,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 50,
          ),
          IconButton(
            icon: Image.asset(
              'assets/signIn.png',
              height: 100,
            ),
            iconSize: 5,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUp()),
              );
            },
          ),
        ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SecondRoute extends StatefulWidget {
  const SecondRoute({super.key});

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
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
                //   Padding(
                // padding: const EdgeInsets.fromLTRB(85, 20, 0, 0),
                // child: Image.asset(
                Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
                // height: 500,
                width: 200,
              ),
            ),
            // ),
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
                  // SizedBox(
                  //   width: 8,
                  // ),
                  Text(
                    'New Visitor',
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
              MyCustomForm(),
            ]),
          ),
        ),
      ),
    );
  }
}
