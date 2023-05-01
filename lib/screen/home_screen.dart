// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_single_cascade_in_expression_statements

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/firebase/databaseRep.dart';
import 'package:dating_app/modal/user_modal.dart';
import 'package:dating_app/provider/user_match_provider.dart';
import 'package:dating_app/screen/user_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../provider/AuthServices.dart';
import '../widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? snakAnimation;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    snakAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!, curve: Curves.bounceInOut));
    animationController!.forward();
    animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController!.reverse(from: 1.0);
      }
    });
    snakAnimation!.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allUsers = Provider.of<Users>(context);
    final logged = Provider.of<DataBaseRepository>(context, listen: false);
    final auth = Provider.of<AuthServies>(context, listen: false);
    final matchuser = Provider.of<UserMatcheProvider>(context);
    final user = allUsers.dbUser;
    final index = allUsers.index;
    bool isMatched = false;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'DISCOVER',
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatsDoc = snapshot.data!.docs;
            for (var chatData in chatsDoc) {
              if (chatData.id == auth.userUid) {
                print('this is me');
              } else {
                allUsers.addUser(chatData, chatData.id);
              }
            }
            if (logged.nuser == null) {
              logged.fetchLoggedUser(auth.userUid!);
            }

            return Column(
              children: [
                InkWell(
                  onTap: () {
                    print(matchuser.matchuser);
                  },
                  onDoubleTap: () {
                    Navigator.of(context).pushNamed(UserScreen.routeName,
                        arguments: user[index]);
                  },
                  child: Draggable(
                    axis: Axis.horizontal,
                    childWhenDragging: UserCard(
                      user: user[index + 1],
                      isChild: true,
                    ),
                    feedback: Material(
                      color: Colors.transparent,
                      child: UserCard(
                        user: user[index],
                      ),
                    ),
                    child: UserCard(
                      user: user[index],
                    ),
                    onDragUpdate: (details) {
                      if (details.delta.dx > 0) {
                        for (var ulike in logged.nuser!.liked!) {
                          if (ulike == user[index].id) {
                            print('logged like $ulike');
                            print('user liked:${logged.nuser!.liked}');
                            isMatched = true;
                          }
                        }
                        if (isMatched == true) {
                          showDialog(
                            context: context,
                            builder: (ctx) => CustomAlertDialog(
                              user,
                              index,
                              (() async {
                                Navigator.of(ctx).pop();
                                await Future.delayed(Duration(seconds: 1));
                                allUsers.swapRight();
                              }),
                            ),
                          );
                        } else {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(user[index].id)
                              .update(
                            {
                              'liked': FieldValue.arrayUnion(
                                [auth.userUid],
                              ),
                            },
                          );
                          allUsers.isSwapped = true;
                        }
                      } else {
                        allUsers.isSwapped = false;

                        print('to left: ${allUsers.isSwapped}');
                      }
                    },
                    onDragEnd: (drag) {
                      if (drag.velocity.pixelsPerSecond.dx < 0) {
                        allUsers.swapLeft();
                      } else if (drag.velocity.pixelsPerSecond.dx > 0) {
                        allUsers.swapRight();
                      }
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(customSnak(context, 'Nope'));

                          await Future.delayed(Duration(seconds: 1));
                          allUsers.swapLeft();
                        },
                        child: const ChoiceButton(
                          color: Colors.red,
                          height: 60,
                          hasGradient: false,
                          icon: Icons.clear_rounded,
                          size: 25,
                          width: 60,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          // swapped = true;
                          for (var ulike in logged.nuser!.liked!) {
                            if (ulike == user[index].id) {
                              print('logged like $ulike');
                              print('user liked:${logged.nuser!.liked}');
                              isMatched = true;
                            }
                          }
                          if (isMatched == true) {
                            matchuser.updateMatchinFirebase(
                                auth.userUid!, user[index].id!, user[index]);
                            showDialog(
                              context: context,
                              builder: (ctx) => CustomAlertDialog(
                                user,
                                index,
                                (() async {
                                  Navigator.of(ctx).pop();
                                  await Future.delayed(Duration(seconds: 1));
                                  allUsers.swapRight();
                                }),
                              ),
                            );
                          } else {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user[index].id)
                                .update(
                              {
                                'liked': FieldValue.arrayUnion(
                                  [auth.userUid],
                                ),
                              },
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(customSnak(context, 'Liked'));
                            await Future.delayed(Duration(seconds: 1));
                            allUsers.swapRight();
                          }
                        },
                        child: const ChoiceButton(
                          hasGradient: true,
                          color: Colors.white,
                          height: 80,
                          icon: Icons.favorite,
                          size: 30,
                          width: 80,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: ChoiceButton(
                          hasGradient: false,
                          color: Colors.red,
                          height: 60,
                          icon: Icons.watch_later,
                          size: 25,
                          width: 60,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  AlertDialog CustomAlertDialog(
      List<User> user, int index, void Function() onpressed) {
    final logUser =
        Provider.of<DataBaseRepository>(context, listen: false).nuser;
    return AlertDialog(
      title: const Text("You Have Matched!"),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AlertBoxPicture(url: user[index].imageUrls![0]),
            AlertBoxPicture(url: logUser!.imageUrls![0]),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onpressed,
          child: Container(
            color: Colors.green,
            padding: const EdgeInsets.all(14),
            child: const Text("okay"),
          ),
        ),
      ],
    );
  }

  SnackBar customSnak(BuildContext context, String title) {
    return SnackBar(
      duration: Duration(milliseconds: 800),
      animation: snakAnimation,
      margin: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.07,
          0,
          MediaQuery.of(context).size.width * 0.6,
          MediaQuery.of(context).size.height - 140),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 6.0,
      backgroundColor: Colors.pink.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.aldrich(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class AlertBoxPicture extends StatelessWidget {
  final String url;

  const AlertBoxPicture({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      height: 70,
      width: 70,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
