import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/modal/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserChat _user(User user) {

    if (user != null) {
      return UserChat(userId: user.uid);
    } else {
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User firebaseUser = result.user;
      return _user(firebaseUser);
    }
    catch(e){
      print(e.toString());
    }
  }

  Future signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User firebaseUser = result.user;
      return _user(firebaseUser);
    }
    catch(e) {
      print(e.toString());
    }
  }

  Future logOut() async {
    try {
      return await _auth.signOut();
    }
    catch (e) {

    }
  }
}