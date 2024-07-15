import 'package:job_finder/features/jobHistory/data/model/job_history_model.dart';
import 'package:job_finder/features/pagination/data/model/job_api_model.dart';

class JobHistoryState {
  final List<JobHistoryModel> jobHistoryModel;
  final bool hasReachedmax;
  final int page;
  final bool isLoading;
  final bool applyLoading;

  JobHistoryState({
    required this.jobHistoryModel,
    required this.hasReachedmax,
    required this.page,
    required this.isLoading,
    required this.applyLoading,
  });

  factory JobHistoryState.initial() {
    return JobHistoryState(
        jobHistoryModel: [],
        hasReachedmax: false,
        page: 0,
        isLoading: false,
        applyLoading: false);
  }

  JobHistoryState copyWith({
    List<JobHistoryModel>? jobHistoryModel,
    bool? hasReachedmax,
    int? page,
    bool? isLoading,
    bool? applyLoading,
  }) {
    return JobHistoryState(
      jobHistoryModel: jobHistoryModel ?? this.jobHistoryModel,
      hasReachedmax: hasReachedmax ?? this.hasReachedmax,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      applyLoading: applyLoading ?? this.applyLoading,
    );
  }
}
