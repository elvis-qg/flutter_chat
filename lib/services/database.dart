import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String username)  async {
    return FirebaseFirestore.instance.collection("users")
        .where("username", isEqualTo: username)
        .get();
  }

  getUserByEmail(String email)  async {
    return FirebaseFirestore.instance.collection("users")
        .where("email", isEqualTo: email)
        .get();
  }

  uploadUserInfo(userData) {
    FirebaseFirestore.instance.collection("users").add(userData);
  }
  
  createChatRoom(String chatRoomId, users) {
    FirebaseFirestore.instance.collection("chatRooms")
        .doc(chatRoomId).set(users);
  }

  addMessages(String chatRoomId, message) {
    FirebaseFirestore.instance.collection("chatRooms")
        .doc(chatRoomId)
        .collection("chats")
        .add(message);
  }

  getMessages (String chatRoomId) async{
    return  await FirebaseFirestore.instance.collection("chatRooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }
}