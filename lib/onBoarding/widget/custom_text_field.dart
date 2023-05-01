import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final Function(String)? onchanged;
  final TabController tabController;
  final String title;
  final TextEditingController controller;
  const CustomTextField(
      {Key? key,
      required this.tabController,
      required this.controller,
      required this.title,
      this.onchanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: title,
          contentPadding: const EdgeInsets.only(top: 12, bottom: 5),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          )),
      onChanged: onchanged,
    );
  }
}
