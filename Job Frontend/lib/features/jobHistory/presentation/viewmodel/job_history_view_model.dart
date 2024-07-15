import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/features/jobHistory/data/datasource/job_history_datasource.dart';
import 'package:job_finder/features/jobHistory/presentation/state/job_history_state.dart';

final jobHistoryViewModelProvider =
    StateNotifierProvider<JobHistoryViewModel, JobHistoryState>((ref) {
  final jobHistoryDatasource = ref.read(jobHistoryDatasourceProvider);
  return JobHistoryViewModel(jobHistoryDatasource);
});

class JobHistoryViewModel extends StateNotifier<JobHistoryState> {
  final JobHistoryDatasource jobHistoryDatasource;

  JobHistoryViewModel(this.jobHistoryDatasource)
      : super(JobHistoryState.initial());

  Future<void> applyForJob(String userId, Map<String, dynamic> jobData) async {
    state = state.copyWith(isLoading: true);
    final result = await jobHistoryDatasource.applyForJob(userId, jobData);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false);
        EasyLoading.showError('Job already applied');
      },
      (success) {
        state = state.copyWith(isLoading: false);
        // EasyLoading.show(status: 'Job applied Success', dismissOnTap: true);
        EasyLoading.showSuccess('Job applied Success');
      },
    );
  }

  Future<void> getAppliedJobs() async {
    state = state.copyWith(isLoading: true);
    final result = await jobHistoryDatasource.getAppliedJobs();

    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, hasReachedmax: false),
      (data) {
        if (data.isEmpty) {
          state = state.copyWith(hasReachedmax: true);
        } else {
          state = state.copyWith(
            jobHistoryModel: data,
            isLoading: false,
          );
        }
      },
    );
  }
}
