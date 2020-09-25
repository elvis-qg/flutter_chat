import 'dart:convert';

import 'package:chat_app/screens/chatroom.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstnameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();

  signUp() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authMethods.signUp(emailController.text, passwordController.text).then((val){
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => ChatRoom()
        ));
      });
      http.post(
        'https://apiflutterchat.herokuapp.com/users',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'first_name': firstnameController.text,
          'last_name' : lastnameController.text,
          'email' : emailController.text,
          'age': ageController.text
        }),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarMain(context),
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator())
      ) : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 35),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) {
                        if(val.length > 20) return "Insert a valid name";
                        return null;
                      },
                      controller: firstnameController,
                      decoration: inputDecoration("Insert your first name"),
                      style: inputTextStyle(),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (val) {
                        if(val.length > 20) return "Insert a valid last name";
                        return null;
                      },
                      controller: lastnameController,
                      decoration: inputDecoration("Insert your last name"),
                      style: inputTextStyle(),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (val) {
                        if(int.parse(val) > 120) return("Insert a valid number");
                        return null;
                      },
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      decoration: inputDecoration("Insert your age"),
                      style: inputTextStyle(),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (val){
                        if(val.isEmpty || val.length < 5) return "Must have at least 5 characters";
                        return null;
                      },
                      controller: usernameController,
                      decoration: inputDecoration("Insert your username"),
                      style: inputTextStyle(),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (val) {
                        if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)) {
                          return "Inset a valid email";
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: inputDecoration("Insert your email"),
                      style: inputTextStyle(),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (val) {
                        if(val.isEmpty || val.length < 8) return "Must have at least 8 characters";
                        return null;
                      },
                      obscureText: true,
                      controller: passwordController,
                      decoration: inputDecoration("Insert your password"),
                      style: inputTextStyle(),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (val) {
                        //if(val != emailController.toString()) return "Passwords don't match";
                        return null;
                      },
                      obscureText: true,
                      decoration: inputDecoration("Confirm your password"),
                      style: inputTextStyle(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35),
              GestureDetector(
                onTap: (){
                  signUp();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.indigo,
                  ),
                  child: Text("Register", style: regularTextStyle()),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?", style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14
                  )),
                  GestureDetector(
                    onTap: () {
                      widget.toggle();
                    },
                    child: Text(" Sign In", style: TextStyle(
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
    );
  }
}
