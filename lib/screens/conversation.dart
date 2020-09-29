import 'package:chat_app/helper/helper_functions.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Conversation extends StatefulWidget {
  final String friendUsername;
  final String chatRoomId;
  const Conversation({
    Key, key,
    this.friendUsername,
    this.chatRoomId,
  }) : super(key: key);
  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();
  Stream messagesStream;

  Widget messagesList() {
    return StreamBuilder(
        stream: messagesStream,
        builder: (context,snapshot) {
          return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              print(snapshot.data.docs[index].data()["message"]);
              return MessageContainer(snapshot.data.documents[index].data()["message"],
              snapshot.data.documents[index].data()["sentBy"] != widget.friendUsername,
              );
            },
          ) : Container();
    });
  }

  sendMessage() async {
    if(messageController.text.isNotEmpty) {
      String author = await HelperFunctions.getUsernameKey();
      Map<String, dynamic> message = {
        "message": messageController.text,
        "sentBy": author,
        "time": DateTime.now().microsecondsSinceEpoch,
      };
      databaseMethods.addMessages(widget.chatRoomId, message);
      messageController.text = "";
    }
  }

  @override
  void initState() {
    databaseMethods.getMessages(widget.chatRoomId).then((data){
     setState(() {
       messagesStream = data;
     });
    }).catchError((e){print(e.text);});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          widget.friendUsername,
          style: TextStyle(
              fontSize: 22,
              color: Colors.white
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                            controller: messageController,
                            decoration: InputDecoration(
                              hintText: "Type a message",
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none
                            ),
                            style: TextStyle(color: Colors.white),
                          )
                      ),
                      GestureDetector(
                        onTap: () {
                          sendMessage();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                              child: Icon(Icons.send)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          margin: EdgeInsets.only(left: 5),
                        ),
                      ),
                    ],
                  ),
              ),
            ),
            messagesList(),
          ],
        ),
      ),
    );
  }
}

class MessageContainer extends StatelessWidget {
  final String message;
  final bool isSentByMe;
  MessageContainer(this.message, this.isSentByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
           color: isSentByMe ? Colors.blueAccent : Colors.amber,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17
          ),
        ),
      ),
    );
  }
}
