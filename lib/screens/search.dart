import 'package:chat_app/helper/helper_functions.dart';
import 'package:chat_app/screens/conversation.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = new TextEditingController();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot searchSnapshot;

  searchUsers() {
    databaseMethods.getUserByUsername(searchController.text)
        .then((val) {
          setState(() {
            searchSnapshot = val;
          });
        });
  }

  Widget resultList() {
    return searchSnapshot != null ? ListView.builder(
        itemCount: searchSnapshot.docs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SearchItem(
           userName: searchSnapshot.docs[index].data()["username"],
          );
        }
    ) : Container();
  }

  @override
  void initState() {
    searchUsers();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          "New Chat",
          style: TextStyle(
          fontSize: 22,
          color: Colors.white
          ),
         ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.black45,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: inputDecoration("Insert username"),
                        style: inputTextStyle(),
                      )
                  ),
                  GestureDetector(
                    onTap: () {
                      searchUsers();
                    },
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                            child: Icon(Icons.search)
                        ),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      margin: EdgeInsets.only(left: 5),
                    ),
                  ),
                ],
              ),
            ),
            resultList(),
          ],
        ),
      ),
    );
  }
}

goToConversationRoom(BuildContext context, String username) async {
  String myName = await HelperFunctions.getUsernameKey();
  List<String> users = [myName, username];
  String chatRoomId = getChatRoomId(myName, username);
  Map<String, dynamic> chatRoomData = {
    "users": users,
    "chatRoom_id": chatRoomId
  };
  DatabaseMethods().createChatRoom(chatRoomId ,chatRoomData);
  Navigator.push(context, MaterialPageRoute(
      builder: (context) => Conversation(friendUsername: username, chatRoomId: chatRoomId,)
  ));
}


class SearchItem extends StatelessWidget {
  final String userName;
  SearchItem({this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            userName,
            style: regularTextStyle(),
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              goToConversationRoom(context, userName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Text(
                "Message",
                style: regularTextStyle(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if(a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  }
  return "$a\_$b";
}