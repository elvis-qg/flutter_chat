import 'package:chat_app/screens/chatroom.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/helper/helper_functions.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  AuthMethods authMethods = new AuthMethods();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  QuerySnapshot snapshotUserData;

  signIn() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authMethods.signIn(emailController.text, passwordController.text).then((val){
        if (val !=  null) {
          databaseMethods.getUserByEmail(emailController.text).then((val) {
            snapshotUserData = val;
            HelperFunctions.saveUsermameKey(snapshotUserData.docs[0].data()["username"]);
          });
          HelperFunctions.saveEmailKey(emailController.text);
          HelperFunctions.saveLoggedInKey(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
          ));
        }

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarMain(context),
      body: isLoading ? Container(
          child: Center(child: CircularProgressIndicator())
      ) :
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 100),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: inputDecoration("Insert your email"),
                  style: inputTextStyle(),
                ),
                SizedBox(height: 25),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: inputDecoration("Insert your password"),
                  style: inputTextStyle(),
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    signIn();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 25),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.indigo,
                    ),
                    child: Text("Sing In", style: regularTextStyle()),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?", style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14
                    )),
                    GestureDetector(
                      onTap: () {
                        widget.toggle();
                      },
                      child: Text(" Sign Up", style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
