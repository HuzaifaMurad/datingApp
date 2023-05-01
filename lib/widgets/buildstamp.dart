import 'package:flutter/material.dart';

class BuildStamp extends StatelessWidget {
  final Color color;
  final String text;
  double angle;
  BuildStamp(
      {Key? key, required this.color, required this.text, this.angle = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color, width: 4),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: color, fontSize: 35, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
