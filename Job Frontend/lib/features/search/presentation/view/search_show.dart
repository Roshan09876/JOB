import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/constant/app_constants.dart';
import 'package:job_finder/config/constant/reusable_text.dart';
import 'package:job_finder/features/pagination/presentation/view_model/job_view_model.dart';
import 'package:job_finder/features/search/data/model/search_api_model.dart';
import 'package:job_finder/features/search/presentation/view_model/search_view_model.dart';

class SearchShowScreen extends ConsumerStatefulWidget {
  final SearchApiModel jobs;
  const SearchShowScreen({Key? key, required this.jobs}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      SearchShowScreenState();
}

class SearchShowScreenState extends ConsumerState<SearchShowScreen> {
  ImageProvider _getImageProvider(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return NetworkImage(imageUrl);
    } else if (imageUrl.startsWith('data:image')) {
      return MemoryImage(base64Decode(imageUrl.split(',').last));
    } else if (imageUrl.isNotEmpty) {
      return FileImage(File(imageUrl));
    } else {
      return AssetImage('assets/images/logo.png');
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(searchViewModelProvider.notifier).resetState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(jobViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
          text: 'Details of the Job',
          fontSize: 20,
          color: Color(kLight.value),
        ),
        backgroundColor: Color(kDark.value),
        elevation: 0, // Remove app bar elevation
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.bookmark),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReusableText(
              text: '${widget.jobs.title}',
              fontSize: 36,
              color: Color(kDark.value),
              // fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 10),
            ReusableText(
              text: 'Job Description',
              fontSize: 24,
              color: Color(kDark.value),
              // fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 5),
            ReusableText(
              text: '${widget.jobs.description}',
              fontSize: 16,
              color: Color(kDark.value),
            ),
            SizedBox(height: 20),
            ReusableText(
              text: 'Salary',
              fontSize: 24,
              color: Color(kDark.value),
              // fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 5),
            ReusableText(
              text: '${widget.jobs.salary}',
              fontSize: 16,
              color: Color(kOrange.value),
            ),
            SizedBox(height: 20),
            Image(
              image: _getImageProvider("${widget.jobs.image}"),
              height: 200, // Adjust the height as needed
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/logo.png', // Placeholder image for errors
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Apply Now',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
