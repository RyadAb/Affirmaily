import 'package:Affirmation/screens/intro_screen.dart';
import 'package:first_time_screen/first_time_screen.dart';
import 'package:flutter/material.dart';
import 'package:Affirmation/screens/categories/categoryAffirmations.dart';
import 'package:Affirmation/screens/categories/chooseCategory.dart';
import 'package:Affirmation/screens/home/home.dart';
import 'package:Affirmation/screens/loading.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      home: FirstTimeScreen(
        loadingScreen: Loading(),
        introScreen: MaterialPageRoute(builder: (context) => IntroScreen()),
        landingScreen: MaterialPageRoute(builder: (context) => Home()),
      ),
      routes: {
        '/loading': (context) => Loading(),
        '/home': (context) => Home(),
        '/chooseCategory': (context) => ChooseCategory(),
        '/categoryAffirmations': (context) => CategoryAffirmations(),
      },
    );
  }
}
