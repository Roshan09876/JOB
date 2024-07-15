import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_finder/config/constant/app_constants.dart';

ThemeData getApplicationTheme() {

  return ThemeData(
    useMaterial3: false,
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: Color(kLight.value),
    textTheme: GoogleFonts.latoTextTheme(),
  );
}

