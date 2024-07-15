import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:job_finder/config/constant/api_endpoints.dart';
import 'package:job_finder/config/constant/flutter_secure_storage_provider.dart';
import 'package:job_finder/core/common/Failure.dart';
import 'package:job_finder/core/network/http_service.dart';
import 'package:job_finder/core/shared_pref/user_shared_pref.dart';
import 'package:job_finder/features/pagination/data/model/job_api_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

final jobRemoteDataSourceProvider = Provider((ref) {
  final _dio = ref.read(httpServiceProvider);
  final userSharedPref = ref.read(userSharedPrefsProvider);
  final flutterSecureStorage = ref.read(flutterSecureStorageProvider);
  return JobRemoteDataSource(_dio, userSharedPref, flutterSecureStorage);
});

class JobRemoteDataSource {
  final Dio _dio;
  final UserSharedPref userSharedPref;
  final FlutterSecureStorage flutterSecureStorage;

  JobRemoteDataSource(
      this._dio, this.userSharedPref, this.flutterSecureStorage);

  // Making GET request to fetch paginated job data from backend
  Future<Either<Failure, List<JobApiModel>>> getJobs(int page) async {
    print("GETTING JOBS");
    try {
      final response = await _dio.get(ApiEndpoints.getJob, queryParameters: {
        'page': page,
      });

      final List<dynamic> data = response.data['showJob'];
      final jobList = data.map((json) => JobApiModel.fromJson(json)).toList();
      return Right(jobList);
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }

  Future<Either<Failure, bool>> applyJob(
      String userId, JobApiModel jobApiModel) async {
    print("APPLYING JOB");
    try {
      final token = await flutterSecureStorage.read(key: 'token');
      if (token == null) {
        return Left(Failure(error: 'Token not found'));
      }

      final response = await _dio.post(
        ApiEndpoints.applyJobs,
        data: {
          'userId': userId,
          'job': jobApiModel.toJson(),
        },
        // options: Options(
        //   headers: {
        //     'Authorization': 'Bearer $token',
        //     'Content-Type': 'application/json',
        //   },
        // ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(Failure(
          error: response.data['message'] ?? 'Unknown error',
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }

  Future<Either<Failure, List<JobApiModel>>> searchJobs(String keyword) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.searchJob,
        queryParameters: {'title': keyword},
      );
      print(response.data);
      print(response);
      final List<dynamic> data = response.data['jobs'];
      final jobs = data.map((json) => JobApiModel.fromJson(json)).toList();
      return Right(jobs);
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }
}
