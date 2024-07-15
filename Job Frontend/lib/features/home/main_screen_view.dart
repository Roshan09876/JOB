import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_finder/config/router/app_routes.dart';
import 'package:job_finder/config/constant/app_constants.dart';
import 'package:job_finder/config/constant/height_spacer.dart';
import 'package:job_finder/config/constant/reusable_text.dart';
import 'package:job_finder/features/home/search_widget.dart';
import 'package:job_finder/features/pagination/presentation/view/jobs_view.dart';
import 'package:job_finder/features/pagination/presentation/view_model/job_view_model.dart';
import 'package:job_finder/features/search/presentation/view/search_page_view.dart';

class MainScreenView extends ConsumerStatefulWidget {
  const MainScreenView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainScreenViewState();
}

class _MainScreenViewState extends ConsumerState<MainScreenView> {
  late bool isDark;

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
      // Assuming this case handles local file paths.
      return FileImage(File(imageUrl));
    } else {
      // Use a default image for invalid URLs
      return AssetImage('assets/images/logo.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(jobViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Job Portal',
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
        ),
        backgroundColor: Color(kDark.value),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Find \nYour Dream Job',
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoute.profileviewRoute);
                      },
                      child: ClipOval(
                        child: Container(
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/image3.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                HeightSpacer(size: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: 'Jobs',
                      fontSize: 20.sp,
                      color: Colors.black,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JobsView()),
                        );
                      },
                      child: ReusableText(
                        text: 'View All (Only View)',
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                HeightSpacer(size: 20.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 4 : 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: 0.7,
                  ),
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
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: _getImageProvider("${job.image}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(10.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: ReusableText(
                                        text: job.title.toString(),
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Flexible(
                                      child: Text(
                                        job.description!.length > 100
                                            ? '${job.description!.substring(0, 100)}...'
                                            : job.description.toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    ReusableText(
                                      text: job.salary.toString(),
                                      fontSize: 14.sp,
                                      color: Color(kOrange.value),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(kDark.value),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoute.jobsviewDetail,
                                          arguments: job,
                                        );
                                      },
                                      child: Text(
                                        'View Details',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
