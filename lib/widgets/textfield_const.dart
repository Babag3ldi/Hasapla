import 'package:flutter/material.dart';

class PhoneTextfieldWidget extends StatelessWidget {
  const PhoneTextfieldWidget({required this.controller, required this.text, required this.textInputType});

  final TextEditingController controller;
  final String text;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4), topRight: Radius.circular(4)),
            border: Border(bottom: BorderSide(color: Colors.black)),
            color: const Color(0xfff8f8f8)),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              labelText: text,
              labelStyle: const TextStyle(color: Colors.black),
              isDense: true,
              border: InputBorder.none),
          keyboardType: textInputType,
        ));
  }
}