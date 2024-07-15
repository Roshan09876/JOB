import 'dart:async';

import 'package:flutter/material.dart';
import 'package:job_finder/config/router/app_routes.dart';
import 'package:job_finder/config/constant/app_constants.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushNamed(context, AppRoute.firstpageRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kDarkPurple.value),
      body: SafeArea(
        child: Column(children: [
          Image.asset('assets/images/logo.png'),
          Lottie.asset(
            'assets/images/splashScreen.json',
          ),
          CircularProgressIndicator(
            color: Color(kLight.value),
          )
        ]),
      ),
    );
  }
}
