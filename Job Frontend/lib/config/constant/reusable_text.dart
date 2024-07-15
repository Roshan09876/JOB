import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableText extends StatelessWidget {
  const ReusableText(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.color});

  final String text;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        color: color
      ),
    );
  }
}
