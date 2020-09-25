import 'package:chat_app/screens/chatroom.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          "My profile",
          style: TextStyle(
              fontSize: 22,
              color: Colors.white
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => ChatRoom()
              ));
            },
            child:
            Container(
                child: Icon(Icons.arrow_back),
                padding: EdgeInsets.symmetric(horizontal: 20)
            )
            ,
          ),
        ],
      ),
      body: Container(

      ),
    );
  }
}
