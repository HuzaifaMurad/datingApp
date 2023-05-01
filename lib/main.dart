// ignore_for_file: prefer_const_constructors

import 'package:dating_app/firebase/databaseRep.dart';
import 'package:dating_app/modal/modal.dart';
import 'package:dating_app/onBoarding/wrapper.dart';
import 'package:dating_app/provider/AuthServices.dart';
import 'package:dating_app/provider/chat_modal_provider.dart';

import 'package:dating_app/provider/messageModal_provider.dart';
import 'package:dating_app/screen/chat_screen.dart';
import 'package:dating_app/screen/home_screen.dart';
import 'package:dating_app/onBoarding/screens/onboarding_screen.dart';
import 'package:dating_app/screen/login_screen.dart';
import 'package:dating_app/screen/matches_screen.dart';
import 'package:dating_app/screen/profile_screen.dart';
import 'package:dating_app/screen/splash_screen.dart';
import 'package:dating_app/screen/user_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'provider/user_match_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthServies(),
        ),
        ChangeNotifierProvider(
          create: (context) => Users(),
        ),
        ChangeNotifierProvider(
          create: (context) => MessagesModalProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataBaseRepository(),
        ),
        ChangeNotifierProxyProvider<MessagesModalProvider, ChatModalProvider>(
          create: (context) => ChatModalProvider([]),
          update: (_, value, previous) => ChatModalProvider(value.messages),
        ),
        ChangeNotifierProxyProvider2<Users, ChatModalProvider,
                UserMatcheProvider>(
            create: (_) => UserMatcheProvider([], []),
            update: (_, value, value2, previous) =>
                UserMatcheProvider(value.users, value2.chattingChats)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xFF2B2E4A),
          scaffoldBackgroundColor: Colors.white,
          backgroundColor: Color(0xFFF4F4F4),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFE84545)),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          UserScreen.routeName: (context) => UserScreen(),
          MatchesScreen.routeName: (context) => MatchesScreen(),
          OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
          // ChatScreen.routeName: (context) => ChatScreen(),
          Wrapper.routeName: (context) => Wrapper(),
          ProfileScreen.routeName: (context) => ProfileScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
        },
      ),
    );
  }
}
