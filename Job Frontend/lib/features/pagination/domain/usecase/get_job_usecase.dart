import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/common/Failure.dart';
import 'package:job_finder/features/pagination/data/model/job_api_model.dart';
import 'package:job_finder/features/pagination/domain/repository/job_repository.dart';

final getJobUseCaseProvider = Provider.autoDispose<GetJobuseCase>(
    (ref) => GetJobuseCase(ref.watch(jobRepositoryProvider)));

class GetJobuseCase {
  final JobRepository jobRepository;
  GetJobuseCase(this.jobRepository);

  Future<Either<Failure, List<JobApiModel>>> getJobs(int page) async {
    return await jobRepository.getjobs(page);
  }
}
