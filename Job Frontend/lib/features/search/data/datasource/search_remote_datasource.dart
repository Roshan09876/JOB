import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/constant/api_endpoints.dart';
import 'package:job_finder/core/common/Failure.dart';
import 'package:job_finder/core/network/http_service.dart';
import 'package:job_finder/features/search/data/model/search_api_model.dart';

final searchRemoteDataSourceProvider = Provider<SearchRemoteDataSource>(
  (ref) => SearchRemoteDataSource(ref.read(httpServiceProvider)),
);

class SearchRemoteDataSource {
  final Dio _dio;
  SearchRemoteDataSource(this._dio);

  Future<Either<Failure, List<SearchApiModel>>> searchJobs(
      String keyword) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.searchJob,
        queryParameters: {'title': keyword},
      );
      print(response.data);
      print(response);
      final List<dynamic> data = response.data['jobs'];
      final jobs = data.map((json) => SearchApiModel.fromJson(json)).toList();
      return Right(jobs);
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }
}
