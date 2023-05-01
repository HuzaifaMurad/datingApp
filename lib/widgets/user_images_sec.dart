// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class UserImagesSecondry extends StatelessWidget {
  const UserImagesSecondry({
    Key? key,
    required this.user,
  }) : super(key: key);

  final String user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10),
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
            image: NetworkImage(
              user,
            ),
            fit: BoxFit.cover),
      ),
    );
  }
}
