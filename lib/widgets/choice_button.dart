// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final double width;
  final double height;
  final double size;
  final Color color;
  final bool hasGradient;
  final IconData icon;
  const ChoiceButton(
      {Key? key,
      required this.width,
      required this.color,
      required this.height,
      required this.hasGradient,
      required this.icon,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          gradient: hasGradient
              ? LinearGradient(
                  colors: [
                    Colors.red,
                    Color.fromARGB(255, 27, 46, 56),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                )
              : LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                ),
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withAlpha(50),
                spreadRadius: 4,
                blurRadius: 4,
                offset: Offset(3, 3))
          ]),
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}
