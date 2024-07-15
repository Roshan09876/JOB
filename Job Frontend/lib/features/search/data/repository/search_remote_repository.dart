import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/common/Failure.dart';
import 'package:job_finder/features/search/data/datasource/search_remote_datasource.dart';
import 'package:job_finder/features/search/data/model/search_api_model.dart';
import 'package:job_finder/features/search/domain/repository/search_repository.dart';

final searchRemoteRepositoryProvider = Provider(
    (ref) => SearchRemoteRepository(ref.read(searchRemoteDataSourceProvider)));

class SearchRemoteRepository implements SearchRepository {
  final SearchRemoteDataSource searchRemoteDataSource;
  SearchRemoteRepository(this.searchRemoteDataSource);

  @override
  Future<Either<Failure, List<SearchApiModel>>> getSearch(
      String keyword) async {
    return await searchRemoteDataSource.searchJobs(keyword);
  }
}
