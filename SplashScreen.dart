import 'package:flutter/material.dart';
import 'package:reece_project2/HomeScreen.dart';

// Done by: Bruce Reece
// Topic:   Tic Tac Toe
// Date:    02/16/2022

// ignore: camel_case_types
class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    // _navigatetohomescreen();
  }

  _navigatetohomescreen() async {
    await Future.delayed(
        const Duration(microseconds: 2000), () {}); // 1.5 seconds
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: const Text(
            'Splash Screen',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
