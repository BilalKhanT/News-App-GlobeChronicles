import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/saved_provider.dart';
import '../utils/images.dart';
import '../widgets/applogo.dart';
import 'home.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return  Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFB81736),
            Color(0xff281537),
            // Add more colors if needed
          ],
        ),
      ),
      child: AnimatedSplashScreen(
        splash: Column(
          children: <Widget>[
            AppLogo(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              'GlobeChronicles',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent, // Set to transparent
        nextScreen: LoginScreen(),
        splashIconSize: 250,
        splashTransition: SplashTransition.slideTransition,
      ),
    );
  }
}

