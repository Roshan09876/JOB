import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/features/pagination/data/datasource/job_remote_datasource.dart';
import 'package:job_finder/features/pagination/domain/usecase/get_applied_job_usecase.dart';
import 'package:job_finder/features/pagination/domain/usecase/get_job_usecase.dart';
import 'package:job_finder/features/pagination/domain/usecase/job_usecase.dart';
import 'package:job_finder/features/pagination/presentation/state/job_state.dart';
import 'package:job_finder/features/pagination/data/model/job_api_model.dart';

final jobViewModelProvider =
    StateNotifierProvider<JobViewModel, JobState>((ref) {
  // final jobUseCase = ref.read(jobUseCaseProvider);
  final getJobUseCase = ref.read(getJobUseCaseProvider);
  final getAppliedJobUseCase = ref.read(getAppliedJobUseCaseProvider);
  final jobRemoteDataSource = ref.read(jobRemoteDataSourceProvider);
  return JobViewModel( getJobUseCase, getAppliedJobUseCase, jobRemoteDataSource);
});

class JobViewModel extends StateNotifier<JobState> {
  // final JobUseCase jobUseCase;
  final GetJobuseCase getJobUseCase;
  final GetAppliedJobUseCase getAppliedJobUseCase;
  final JobRemoteDataSource jobRemoteDataSource;

  JobViewModel( this.getJobUseCase, this.getAppliedJobUseCase, this.jobRemoteDataSource)
      : super(JobState.initial());

  Future<void> getJobs() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final jobs = currentState.jobApiModel;
    final hasReachedmax = currentState.hasReachedmax;
    if (!hasReachedmax) {
      final result = await getJobUseCase.getJobs(page);
      result.fold(
        (failure) => state.copyWith(isLoading: false, hasReachedmax: false),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedmax: true);
          } else {
            state = state.copyWith(
              jobApiModel: [...jobs, ...data],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    }
  }

  Future<void> applyJob(String userId, BuildContext context, JobApiModel jobApiModel) async {
    state = state.copyWith(applyLoading: true);
    final result = await getAppliedJobUseCase.applyJobs(userId, jobApiModel);

    result.fold(
      (failure) {
        state = state.copyWith(applyLoading: false);

        // Show SnackBar for failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Failed to apply for the job: ${failure.error}",
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
          ),
        );
      },
      (data) {
        state = state.copyWith(applyLoading: false);

        // Show SnackBar for success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Applied for this job successfully!",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            duration: Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
          ),
        );
      },
    );
  }

  // Future<void> getAppliedJobs(String userId) async {
  //   state = state.copyWith(isLoading: true);
  //   final currentState = state;
  //   final page = currentState.page + 1;
  //   final jobs = currentState.jobApiModel;
  //   final result = await jobUseCase.getAppliedJobs(userId: userId);
  //   result.fold(
  //     (failure) => state.copyWith(isLoading: false, hasReachedmax: false),
  //     (data) {
  //       if (data.isEmpty) {
  //         state = state.copyWith(hasReachedmax: true);
  //       } else {
  //         state = state.copyWith(
  //           jobApiModel: [...jobs, ...data],
  //           page: page,
  //           isLoading: false,
  //         );
  //       }
  //     },
  //   );
  // }
   Future<void> getSearchJobs(String text) async {
    if (text.isEmpty) {
      state = state.copyWith(jobApiModel: [], isLoading: false);
      return;
    }

    state = state.copyWith(isLoading: true);
    final result = await jobRemoteDataSource.searchJobs(text);
    result.fold((failure) {
      state = state.copyWith(isLoading: false,);
    }, (success) {
      state = state.copyWith(isLoading: false, jobApiModel: success);
    });
  }

  Future<void> resetState() async {
    state = JobState.initial();
    getJobs();
  }
}
