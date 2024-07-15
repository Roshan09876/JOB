import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/constant/api_endpoints.dart';
import 'package:job_finder/core/network/dio_erro_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final httpServiceProvider =
    Provider.autoDispose((ref) => HttpService(Dio())._dio);

class HttpService {
  final Dio _dio;

  Dio get dio => _dio;

  HttpService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.recieveTimeout
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true))
      ..options.headers = {
        'Accept': 'application/json',
        'Content-type': 'application/json',
      };
  }
}
