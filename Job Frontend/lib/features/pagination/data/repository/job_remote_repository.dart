import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/common/Failure.dart';
import 'package:job_finder/features/pagination/data/datasource/job_remote_datasource.dart';
import 'package:job_finder/features/pagination/data/model/job_api_model.dart';
import 'package:job_finder/features/pagination/domain/repository/job_repository.dart';

final jobRemoteRepositoryProvider = Provider<JobRepository>((ref) => JobremoteRepository(ref.read(jobRemoteDataSourceProvider)));

class JobremoteRepository implements JobRepository{
  final JobRemoteDataSource jobRemoteDataSource;

  JobremoteRepository(this.jobRemoteDataSource);

  @override
  Future<Either<Failure, List<JobApiModel>>> getjobs(int page) async{
    return await jobRemoteDataSource.getJobs(page);
  }
  
  // @override
  // Future<Either<Failure, List<JobApiModel>>> getuserjobs(String userId)  async{
  //   return await jobRemoteDataSource.getAppliedJobs(userId);
  // }
  
  @override
  Future<Either<Failure, bool>> applyJobs(String userId, JobApiModel jobApiModel) {
    return jobRemoteDataSource.applyJob(userId, jobApiModel);
  }

}