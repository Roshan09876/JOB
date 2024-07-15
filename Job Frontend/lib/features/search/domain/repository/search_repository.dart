import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/common/Failure.dart';
import 'package:job_finder/features/search/data/model/search_api_model.dart';
import 'package:job_finder/features/search/data/repository/search_remote_repository.dart';

final searchRepository =
    Provider((ref) => ref.read(searchRemoteRepositoryProvider));

abstract class SearchRepository {
  Future<Either<Failure, List<SearchApiModel>>> getSearch(String keyword);
}
