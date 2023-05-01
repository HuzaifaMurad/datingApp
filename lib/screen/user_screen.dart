// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../modal/user_modal.dart';
import '../widgets/widget.dart';

class UserScreen extends StatelessWidget {
  static const routeName = '/user-screen';

  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final oUser = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Hero(
                    tag: 'user_image',
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                            oUser.imageUrls![0],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 80, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChoiceButton(
                          color: Colors.red,
                          height: 60,
                          hasGradient: false,
                          icon: Icons.clear_rounded,
                          size: 25,
                          width: 60,
                        ),
                        ChoiceButton(
                          hasGradient: true,
                          color: Colors.white,
                          height: 80,
                          icon: Icons.favorite,
                          size: 30,
                          width: 80,
                        ),
                        ChoiceButton(
                          hasGradient: false,
                          color: Colors.red,
                          height: 60,
                          icon: Icons.watch_later,
                          size: 25,
                          width: 60,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${oUser.name},${oUser.age}',
                  style: GoogleFonts.ubuntuCondensed(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${oUser.jobTitle},',
                  style: GoogleFonts.ubuntuCondensed(
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'About',
                  style: GoogleFonts.ubuntuCondensed(
                      fontSize: 27, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  oUser.bio!,
                  style: GoogleFonts.ubuntuCondensed(
                    textStyle: Theme.of(context).textTheme.bodyText1,
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Interest',
                  style: GoogleFonts.ubuntuCondensed(
                      fontSize: 27, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: oUser.interests!
                      .map(
                        (interest) => Container(
                          padding: EdgeInsets.all(6),
                          margin: EdgeInsets.only(top: 5, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).colorScheme.secondary,
                              ],
                            ),
                          ),
                          child: Text(
                            interest,
                            style: GoogleFonts.ubuntuCondensed(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
