// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dating_app/firebase/databaseRep.dart';
import 'package:dating_app/modal/user.dart';
import 'package:dating_app/onBoarding/screens/onboarding_screen.dart';

import 'package:dating_app/provider/AuthServices.dart';
import 'package:dating_app/screen/login_screen.dart';

import 'package:dating_app/widgets/customAppbar.dart';
import 'package:dating_app/widgets/customTextChoice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../modal/user_modal.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile-screen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allUsers = Provider.of<Users>(context);
    final user = allUsers.users;
    final auth = Provider.of<AuthServies>(context);
    final logged = Provider.of<DataBaseRepository>(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'PROFILE'),
      body: SingleChildScrollView(
        child: StreamBuilder<AuthUser?>(
          stream: auth.user,
          builder: (context, AsyncSnapshot<AuthUser?> snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder(
                  future: logged.fetchLoggedUser(snapshot.data!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final logUser = logged.nuser;
                    if (logUser?.age == 0) {
                      return Center(
                        child: TextButton(
                          onPressed: () {
                            auth.signOut();

                            Navigator.of(context).pushNamedAndRemoveUntil(
                                OnBoardingScreen.routeName,
                                ModalRoute.withName('/bording-screen'));
                          },
                          child: Text('Sign Out'),
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(3, 3),
                                        blurRadius: 3,
                                        spreadRadius: 3)
                                  ],
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      logUser!.imageUrls![0],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height / 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.1),
                                      Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.9),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 35),
                                    child: Text(
                                      logUser.name!,
                                      style: GoogleFonts.ubuntuCondensed(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleWithIcon(
                                  title: 'Biography',
                                  icon: Icons.edit,
                                ),
                                Text(
                                  logUser.bio!,
                                  style: GoogleFonts.ubuntuCondensed(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText1,
                                      fontSize: 12,
                                      height: 1.7),
                                ),
                                TitleWithIcon(
                                  title: 'Pictures',
                                  icon: Icons.edit,
                                ),
                                SizedBox(
                                  height: 125,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) => Padding(
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
                                      child: Container(
                                        height: 125,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                logUser.imageUrls![index]),
                                          ),
                                        ),
                                      ),
                                    ),
                                    shrinkWrap: true,
                                    itemCount: logUser.imageUrls!.length,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                                TitleWithIcon(
                                  title: 'Location',
                                  icon: Icons.edit,
                                ),
                                Text(
                                  logUser.location!,
                                  style: GoogleFonts.ubuntuCondensed(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText1,
                                      fontSize: 15,
                                      height: 1.7),
                                ),
                                TitleWithIcon(
                                  title: 'Interest',
                                  icon: Icons.edit,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => Container(
                                      height: 50,
                                      width: 100,
                                      child: CustomTextChoice(
                                          title: logUser.interests![index]),
                                    ),
                                    itemCount: logUser.interests!.length,
                                  ),
                                ),
                                // Row(
                                //   children: [
                                //     // CustomTextChoice(title: logUser.interests![0]),
                                //     CustomTextChoice(title: 'Economics'),
                                //     CustomTextChoice(title: 'football'),
                                //   ],
                                // ),
                                TextButton(
                                  onPressed: () {
                                    auth.signOut();
                                    Navigator.of(context)
                                        .pushNamed(LoginScreen.routeName);
                                  },
                                  child: Text('Sign Out'),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                  });
            }
            return Center(
              child: Text(auth.userUid.toString()),
            );
          },
        ),
      ),
    );
  }
}

class TitleWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  const TitleWithIcon({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.ubuntuCondensed(
            fontSize: 22,
          ),
        ),
        IconButton(onPressed: () {}, icon: Icon(icon))
      ],
    );
  }
}
