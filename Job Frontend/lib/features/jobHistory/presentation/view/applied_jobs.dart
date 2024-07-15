import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:job_finder/config/constant/app_constants.dart';
import 'package:job_finder/config/constant/reusable_text.dart';
import 'package:job_finder/core/shared_pref/user_shared_pref.dart';
import 'package:job_finder/features/jobHistory/presentation/viewmodel/job_history_view_model.dart';
import 'package:job_finder/features/pagination/presentation/state/job_state.dart';
import 'package:job_finder/features/pagination/presentation/view_model/job_view_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AppliesJobs extends ConsumerStatefulWidget {
  const AppliesJobs({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppliesJobsState();
}

final FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();

class _AppliesJobsState extends ConsumerState<AppliesJobs> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final token = await flutterSecureStorage.read(key: 'token');
      final decodedToken = JwtDecoder.decode(token!);
      final userId = decodedToken['id'];
      await ref.read(jobHistoryViewModelProvider.notifier).getAppliedJobs();
    });
  }

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

  Color _getStatusColor(String status) {
    if (status.toLowerCase() == 'applied') {
      return Colors.green; // Example color for 'applied' status
    } else {
      return Colors.red; // Default color for other statuses
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kDark.value),
        title: Text('Applied Jobs'),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final state = ref.watch(jobHistoryViewModelProvider);
          if (state.isLoading) {
            // return Center(child: CircularProgressIndicator());
            return Center(
              child: Text('No applied jobs found.'),
            );
          } else if (state.jobHistoryModel.isEmpty) {
            return Center(
              child: Text('No applied jobs found.'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: state.jobHistoryModel.length,
                itemBuilder: (context, index) {
                  final job = state.jobHistoryModel[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.black,
                          backgroundImage: _getImageProvider("${job.image}"),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${job.title}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${job.location}",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Rs. ${job.salary}",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: _getStatusColor(
                                job.applicationStatus.toString()),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "${job.applicationStatus}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
