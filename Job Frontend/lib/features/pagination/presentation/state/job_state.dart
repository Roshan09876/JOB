import 'package:job_finder/features/pagination/data/model/job_api_model.dart';

class JobState {
  final List<JobApiModel> jobApiModel;
  final bool hasReachedmax;
  final int page;
  final bool isLoading;
  final bool applyLoading;

  JobState(
      {required this.jobApiModel,
      required this.hasReachedmax,
      required this.page,
      required this.isLoading, 
      required this.applyLoading, 
      });

  factory JobState.initial() {
    return JobState(
        jobApiModel: [], hasReachedmax: false, page: 0, isLoading: false, applyLoading: false);
  }

  JobState copyWith({
    List<JobApiModel>? jobApiModel,
    bool? hasReachedmax,
    int? page,
    bool? isLoading,
    bool? applyLoading,
  }) {
    return JobState(
        jobApiModel: jobApiModel ?? this.jobApiModel,
        hasReachedmax: hasReachedmax ?? this.hasReachedmax,
        page: page ?? this.page,
        isLoading: isLoading ?? this.isLoading, 
        applyLoading: applyLoading ?? this.applyLoading, 
        );
  }
}
