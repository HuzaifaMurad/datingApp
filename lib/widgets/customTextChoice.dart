import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextChoice extends StatelessWidget {
  final String title;
  const CustomTextChoice({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.lato(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
