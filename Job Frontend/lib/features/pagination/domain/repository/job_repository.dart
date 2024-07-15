import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/common/Failure.dart';
import 'package:job_finder/features/pagination/data/model/job_api_model.dart';
import 'package:job_finder/features/pagination/data/repository/job_remote_repository.dart';

final jobRepositoryProvider =
    Provider((ref) => ref.read(jobRemoteRepositoryProvider));

abstract class JobRepository {
  Future<Either<Failure, List<JobApiModel>>> getjobs(int page);
  Future<Either<Failure, bool>> applyJobs(String userId, JobApiModel jobApiModel);
  // Future<Either<Failure, List<JobApiModel>>> getuserjobs(String userId);
}
