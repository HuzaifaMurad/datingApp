import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextHeader extends StatelessWidget {
  final TabController tabController;
  final String title;
  const CustomTextHeader(
      {Key? key, required this.tabController, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.lato(
        fontWeight: FontWeight.normal,
        fontSize: 30,
      ),
    );
  }
}
