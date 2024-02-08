import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final TextEditingController controller;
  final String label;

  MyTextField(this.label, this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        style: TextStyle(
          color: Colors.white,
        ),
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          // icon: Icon(Icons.person),
          iconColor: Colors.white,
          labelStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}