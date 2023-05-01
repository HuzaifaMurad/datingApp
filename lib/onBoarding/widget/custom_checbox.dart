import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCheckBox extends StatelessWidget {
  final TabController tabController;
  final String title;
  final bool value;
  final Function(bool?)? onchanged;
  const CustomCheckBox({
    Key? key,
    required this.tabController,
    required this.title,
    required this.onchanged,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onchanged),
        Text(
          title,
          style: GoogleFonts.lato(fontWeight: FontWeight.normal, fontSize: 15),
        ),
      ],
    );
  }
}
