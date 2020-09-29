import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.indigo,
    title: const Text(
        "Flutter Chat",
        style: TextStyle(
            fontSize: 22,
            color: Colors.white
        ),
    ),
  );
}

InputDecoration inputDecoration(String placeholder) {
  return InputDecoration(
    hintText: placeholder,
    hintStyle: TextStyle(
      color: Colors.grey,
    ),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.amberAccent)
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide( color: Colors.grey)
    ),
  );
}

TextStyle inputTextStyle() {
  return TextStyle(
      color: Colors.amber
  );
}

TextStyle regularTextStyle() {
  return TextStyle(
    color: Colors.white70,
    fontSize: 18,
  );
}
