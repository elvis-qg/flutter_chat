import 'package:chat_app/helper/authenticator.dart';
import 'package:chat_app/screens/profile.dart';
import 'package:chat_app/screens/signin.dart';
import 'package:chat_app/services/auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          "My Chats",
          style: TextStyle(
              fontSize: 22,
              color: Colors.white
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.logOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => Authenticator() ));
            },
            child:
              Container(
                child: Icon(Icons.exit_to_app),
                padding: EdgeInsets.symmetric(horizontal: 20)
              ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.account_circle),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => Profile()
          ));
        },
      ),
    );
  }
}
