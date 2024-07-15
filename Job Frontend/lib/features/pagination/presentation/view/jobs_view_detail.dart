import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/constant/app_constants.dart';
import 'package:job_finder/config/constant/reusable_text.dart';
import 'package:job_finder/features/jobHistory/presentation/viewmodel/job_history_view_model.dart';
import 'package:job_finder/features/pagination/data/model/job_api_model.dart';

class JobsViewDetail extends ConsumerStatefulWidget {
  const JobsViewDetail({Key? key}) : super(key: key);

  @override
  ConsumerState<JobsViewDetail> createState() => _JobsViewDetailState();
}

class _JobsViewDetailState extends ConsumerState<JobsViewDetail> {
  bool isApplied = false;

  @override
  Widget build(BuildContext context) {
    final jobViewModel = ref.watch(jobHistoryViewModelProvider.notifier);
    final jobs = ModalRoute.of(context)!.settings.arguments as JobApiModel;

    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
          text: 'Details of the Job',
          fontSize: 20,
          color: Color(kLight.value),
        ),
        backgroundColor: Color(kDark.value),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                // Handle bookmark functionality here
              },
              icon: Icon(Icons.bookmark),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              child: Card(
                elevation: 4,
                child: Center(
                  child: ReusableText(
                    text: '${jobs.title}',
                    fontSize: 36,
                    color: Color(kDark.value),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                  image: _getImageProvider("${jobs.image}"),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ReusableText(
              text: 'Job Description',
              fontSize: 24,
              color: Color(kDark.value),
            ),
            SizedBox(height: 5),
            ReusableText(
              text: '${jobs.description}',
              fontSize: 16,
              color: Color(kDark.value),
            ),
            SizedBox(height: 20),
            ReusableText(
              text: 'Salary',
              fontSize: 24,
              color: Color(kDark.value),
            ),
            SizedBox(height: 5),
            ReusableText(
              text: '${jobs.salary}',
              fontSize: 16,
              color: Color(kOrange.value),
            ),
            SizedBox(height: 20),
            ReusableText(
              text: 'Location',
              fontSize: 24,
              color: Color(kDark.value),
            ),
            SizedBox(height: 5),
            ReusableText(
              text: '${jobs.location}',
              fontSize: 16,
              color: Color(kOrange.value),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: isApplied
                  ? null
                  : () async {
                      setState(() {
                        isApplied = true;
                      });
                      final jobData = {
                        'title': jobs.title,
                        'description': jobs.description,
                        'salary': jobs.salary,
                        'location': jobs.location,
                        'image': jobs.image,
                      };
                      await jobViewModel.applyForJob(
                          jobs.id.toString(), jobData);
                      setState(() {
                        isApplied = false;
                      });
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isApplied ? Colors.green : Color(kOrange.value),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    isApplied ? 'Applied' : 'Apply Now',
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

  ImageProvider _getImageProvider(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return NetworkImage(imageUrl);
    } else if (imageUrl.startsWith('data:image')) {
      return MemoryImage(base64Decode(imageUrl.split(',')[1]));
    } else if (imageUrl.isNotEmpty) {
      return FileImage(File(imageUrl));
    } else {
      return AssetImage('assets/images/logo.png');
    }
  }
}
