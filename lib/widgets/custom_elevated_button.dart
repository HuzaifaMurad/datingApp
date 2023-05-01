import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  const CustomElevatedButton(
      {Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withAlpha(50),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(2, 2),
            )
          ]),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            elevation: 0,
            fixedSize: const Size(200, 40)),
        onPressed: onPressed,
        child: Container(
          width: double.infinity,
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.robotoMono(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
