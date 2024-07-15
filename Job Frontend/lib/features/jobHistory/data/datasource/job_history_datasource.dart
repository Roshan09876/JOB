import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:job_finder/config/constant/api_endpoints.dart';
import 'package:job_finder/config/constant/flutter_secure_storage_provider.dart';
import 'package:job_finder/core/common/Failure.dart';
import 'package:job_finder/core/network/http_service.dart';
import 'package:job_finder/core/shared_pref/user_shared_pref.dart';
import 'package:job_finder/features/jobHistory/data/model/job_history_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

final jobHistoryDatasourceProvider = Provider((ref) {
  final _dio = ref.read(httpServiceProvider);
  final userSharedPref = ref.read(userSharedPrefsProvider);
  final flutterSecureStorage = ref.read(flutterSecureStorageProvider);
  return JobHistoryDatasource(_dio, userSharedPref, flutterSecureStorage);
});

class JobHistoryDatasource {
  final Dio _dio;
  final UserSharedPref userSharedPref;
  final FlutterSecureStorage flutterSecureStorage;
  JobHistoryDatasource(
    this._dio,
    this.userSharedPref,
    this.flutterSecureStorage,
  );

  //Apply For Jobs
  // Apply For Jobs
  Future<Either<Failure, bool>> applyForJob(
      String userId, Map<String, dynamic> jobData) async {
    try {
      final token = await flutterSecureStorage.read(key: 'token');
      if (token == null) {
        return Left(
            Failure(error: 'An Unexpected Error occurred token missing'));
      }

      final decodedToken = JwtDecoder.decode(token);
      final userId = decodedToken['id'];
      if (userId == null) {
        return Left(Failure(error: 'User not found from token'));
      }

      final url = "${ApiEndpoints.applyJobs}/$userId";
      final response = await _dio.post(url, data: jobData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(true);
      } else {
        return Left(Failure(error: 'Failed to apply for job'));
      }
    } on DioException catch (e) {
      print('Exception: ${e.toString()}');
      return Left(Failure(error: e.toString()));
    }
  }

//Get Applied JObs
  Future<Either<Failure, List<JobHistoryModel>>> getAppliedJobs() async {
    print("GETTING APPLIED JOBS");
    try {
      final token = await flutterSecureStorage.read(key: 'token');
      if (token == null) {
        return Left(Failure(error: 'Token not found'));
      }

      final decodedToken = JwtDecoder.decode(token);
      final userID = decodedToken['id'];
      if (userID == null) {
        return Left(Failure(error: 'User ID not found in token'));
      }

      final url = '${ApiEndpoints.getuserjobs}/$userID';
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final responseData = response.data;
        print(
            'Response data: $responseData'); // Debug print to see the response data

        if (responseData['success'] == true &&
            responseData.containsKey('jobHistory')) {
          var jobsHistory = responseData['jobHistory'] as List<dynamic>;

          final jobList = jobsHistory
              .map((json) => JobHistoryModel.fromJson(json))
              .toList();
          return Right(jobList);
        } else {
          print('Failed to fetch jobs, response data: $responseData');
          return Left(Failure(error: 'Failed to fetch jobs'));
        }
      } else {
        print('Failed to fetch jobs, status code: ${response.statusCode}');
        return Left(Failure(error: 'Failed to fetch jobs'));
      }
    } on DioException catch (e) {
      print(
          'DioException: ${e.message}'); // Debug print to see DioException details
      return Left(Failure(error: e.message.toString()));
    } catch (e) {
      print(
          'Exception: ${e.toString()}'); // Debug print to see other exceptions
      return Left(Failure(error: e.toString()));
    }
  }
}
