import 'package:chat_app/helper/authenticator.dart';
import 'package:chat_app/helper/helper_functions.dart';
import 'package:chat_app/screens/chatroom.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUserLogged = false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }
  getLoggedInState() async {
    await HelperFunctions.getLoggedInKey().then((val) {
      isUserLogged = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.black54,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: !isUserLogged ? Authenticator() : ChatRoom(),
    );
  }
}

