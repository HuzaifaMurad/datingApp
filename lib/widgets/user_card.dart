// ignore_for_file: prefer_const_constructors

import 'package:dating_app/widgets/buildstamp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../modal/user_modal.dart';
import 'widget.dart';

class UserCard extends StatelessWidget {
  final User user;

  final bool isChild;
  const UserCard({Key? key, required this.user, this.isChild = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var swapping = Provider.of<Users>(context).isSwapped;
    if (isChild == true) {
      swapping = null;
    }
    return Hero(
      tag: 'user_image',
      child: Padding(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.4,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(user.imageUrls![0]),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 4,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.07,
                left: MediaQuery.of(context).size.width * 0.02,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.name},${user.age}',
                      style: GoogleFonts.ubuntuCondensed(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${user.jobTitle}',
                      style: GoogleFonts.ubuntuCondensed(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        UserImagesSecondry(user: user.imageUrls![0]),
                        UserImagesSecondry(user: user.imageUrls![0]),
                        UserImagesSecondry(user: user.imageUrls![0]),
                        UserImagesSecondry(user: user.imageUrls![0]),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Icon(
                            Icons.info,
                            size: 30,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              if (swapping == true)
                Positioned(
                  top: 30,
                  child: BuildStamp(
                    color: Colors.green,
                    text: 'Liked',
                    angle: -0.5,
                  ),
                ),
              if (swapping == false)
                Positioned(
                  top: 30,
                  child: BuildStamp(
                    color: Colors.red,
                    text: 'Nope',
                    angle: -0.5,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
