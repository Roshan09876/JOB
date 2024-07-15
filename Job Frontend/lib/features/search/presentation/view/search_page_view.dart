import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/constant/app_constants.dart';
import 'package:job_finder/config/constant/reusable_text.dart';
import 'package:job_finder/config/router/app_routes.dart';
import 'package:job_finder/features/pagination/presentation/view_model/job_view_model.dart';
import 'package:job_finder/features/search/presentation/view/search_show.dart';
import 'package:job_finder/features/search/presentation/view_model/search_view_model.dart';

class SearcPageView extends ConsumerStatefulWidget {
  const SearcPageView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearcPageViewState();
}

class _SearcPageViewState extends ConsumerState<SearcPageView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(jobViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
          text: 'Search Books',
          fontSize: 20,
          color: Colors.white,
        ),
        backgroundColor: Color(kDark.value),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            TextField(
              controller: searchController,
              onChanged: (value) {
                ref.read(jobViewModelProvider.notifier).getSearchJobs(value);
              },
              decoration: InputDecoration(
                hintText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    ref
                        .read(jobViewModelProvider.notifier)
                        .getSearchJobs(searchController.text);
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Expanded(
              child: state.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : state.jobApiModel.isEmpty
                      ? Center(child: Text('No results found.'))
                      : ListView.builder(
                          itemCount: state.jobApiModel.length,
                          itemBuilder: (context, index) {
                            final job = state.jobApiModel[index];
                            return ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoute.jobsviewDetail,
                                  arguments: job,
                                );
                              },
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: _getImageProvider(job.image ?? ''),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              trailing: ReusableText(
                                text: job.title ?? '',
                                fontSize: 18,
                                color: Color(kDark.value),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
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
}
