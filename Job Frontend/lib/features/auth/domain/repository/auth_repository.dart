import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/common/Failure.dart';
import 'package:job_finder/features/auth/data/repositories/auth_remote_repository.dart';
import 'package:job_finder/features/auth/domain/entity/auth_entity.dart';

final authRepositoryProvider =
    Provider((ref) => ref.read(authRemoteRepositoryProvider));

abstract class AuthRepository {
  Future<Either<Failure, bool>> signUpFreelancer(AuthEntity authEntity);
  Future<Either<Failure, bool>> signInFreelancer(String email, String password);
  Future<Either<Failure, AuthEntity>> getUser(String email);
}
