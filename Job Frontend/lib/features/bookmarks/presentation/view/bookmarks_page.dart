import 'package:flutter/material.dart';
import 'package:job_finder/config/constant/app_constants.dart';
import 'package:job_finder/config/constant/reusable_text.dart';

class BookMarksPage extends StatelessWidget {
  const BookMarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kDark.value),
          title: ReusableText(
        text: 'BookMarks',
        fontSize: 20,
        color: Color(kLight.value),
      )),
      body: Center(child: Text('BookMarks Page')),
    );
  }
}
