import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/common/Failure.dart';
import 'package:job_finder/features/pagination/data/model/job_api_model.dart';
import 'package:job_finder/features/pagination/domain/repository/job_repository.dart';

final getAppliedJobUseCaseProvider = Provider.autoDispose<GetAppliedJobUseCase>(
    (ref) => GetAppliedJobUseCase(ref.watch(jobRepositoryProvider)));

class GetAppliedJobUseCase {
  final JobRepository jobRepository;
  GetAppliedJobUseCase(this.jobRepository);

    Future<Either<Failure, bool>> applyJobs(String userId, JobApiModel jobApiModel) async {
    return await jobRepository.applyJobs(userId, jobApiModel);
  }
}
