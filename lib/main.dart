import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:koha/features/home/screens/home_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFF1E1E1E),
              ],
            ),
          ),
          child: AnimatedSplashScreen(
            duration: 500,
            splash: Image.asset('assets/image/Koha-logo.png'),
            nextScreen: HomeScreen(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.black,
          ),
        )); // Added closing parenthesis here
  }
}
