import 'package:flutter/material.dart';
import 'package:reece_project2/HomeScreen.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

// Done by: Bruce Reece
// Topic:   Tic Tac Toe
// Date:    02/16/2022

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reece Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EasySplashScreen(
        logo: Image.asset('assets/images/tic.jpeg'),
        title: const Text(
          'BRUCE REECE\n\n\n\nTIC TAC TOE\n\n\n\n02/21/2022',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        backgroundColor: Colors.blue, //ANY COLOR YOU CHOOSE
        showLoader: true,
        loaderColor: Colors.white, //ANY COLOR YOU CHOOSE
        loadingText: const Text('Starting GAME'),
        navigator: const MyHomePage(),
        durationInSeconds: 4,
      ),
    );
  }
}
