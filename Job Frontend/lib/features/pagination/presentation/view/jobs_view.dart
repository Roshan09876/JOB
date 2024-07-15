import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/constant/app_constants.dart';
import 'package:job_finder/config/constant/reusable_text.dart';
import 'package:job_finder/config/router/app_routes.dart';
import 'package:job_finder/features/pagination/presentation/view_model/job_view_model.dart';

class JobsView extends ConsumerStatefulWidget {
  const JobsView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _JobsViewState();
}

class _JobsViewState extends ConsumerState<JobsView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(jobViewModelProvider.notifier).resetState();
    });
    super.initState();
  }

  ImageProvider _getImageProvider(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return NetworkImage(imageUrl);
    } else if (imageUrl.startsWith('data:image')) {
      return MemoryImage(base64Decode(imageUrl.split(',').last));
    } else if (imageUrl.isNotEmpty) {
      return FileImage(File(imageUrl));
    } else {
      // Use a default image for invalid URLs
      return AssetImage('assets/images/logo.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(jobViewModelProvider);
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (scrollController.position.extentAfter == 0) {
            ref.read(jobViewModelProvider.notifier).getJobs();
          }
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Jobs'),
          backgroundColor: Color(kDark.value),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            ref.read(jobViewModelProvider.notifier).resetState();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: state.jobApiModel.length,
              itemBuilder: (context, index) {
                final job = state.jobApiModel[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoute.jobsviewDetail,
                      arguments: job,
                    );
                  },
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18.0),
                            child: Image(
                              image: _getImageProvider(job.image ?? ''),
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.infinity,
                            ),
                          ),
                          SizedBox(height: 12),
                          ReusableText(
                            text: job.title ?? '',
                            fontSize: 18,
                            // fontWeight: FontWeight.bold,
                            color: Color(kDark.value),
                          ),
                          SizedBox(height: 8),
                          Text(
                            job.description!.length > 100
                                ? '${job.description!.substring(0, 100)}...'
                                : job.description!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ReusableText(
                                text: job.salary ?? '',
                                fontSize: 16,
                                color: Color(kOrange.value),
                              ),
                              // ElevatedButton(
                              //   onPressed: () {
                              //     Navigator.pushNamed(
                              //       context,
                              //       AppRoute.jobsviewDetail,
                              //       arguments: job,
                              //     );
                              //   },
                              //   style: ElevatedButton.styleFrom(
                              //     backgroundColor: Color(kOrange.value),
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(18.0),
                              //     ),
                              //   ),
                              //   child: Padding(
                              //     padding: const EdgeInsets.symmetric(
                              //         vertical: 8.0, horizontal: 16.0),
                              //     child: Text(
                              //       'View Details',
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: 14,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
