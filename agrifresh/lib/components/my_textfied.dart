import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final controller;
  final String hinText; //textfield chhunga thu inziak
  final bool obscureText; //for password * leh * loh

  const MyTextfield({
    super.key,
    required this.controller,
    required this.hinText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: TextField(
        controller:controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:Colors.white),
          ),
          focusedBorder:OutlineInputBorder(
            borderSide:BorderSide(color:Colors.black),
          ),
          fillColor: Colors.green[100],
          filled:true,
          hintText: hinText,
        ),
      ),
    );  
  }
}