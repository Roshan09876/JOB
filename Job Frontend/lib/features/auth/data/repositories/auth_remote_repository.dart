import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/common/Failure.dart';
import 'package:job_finder/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:job_finder/features/auth/domain/entity/auth_entity.dart';
import 'package:job_finder/features/auth/domain/repository/auth_repository.dart';

final authRemoteRepositoryProvider = Provider<AuthRepository>(
    (ref) => AuthRemoteRepository(ref.read(authRemoteDataSourceProvider)));

// Provides an implementation for the signUpFreelancer method, forwarding the call to the data source.

class AuthRemoteRepository implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRemoteRepository(this.authRemoteDataSource);

  @override
  Future<Either<Failure, bool>> signUpFreelancer(AuthEntity freelancer) async {
    return await authRemoteDataSource.signUpFreelancer(freelancer);
  }
  
  @override
  Future<Either<Failure, bool>> signInFreelancer(String email, String password) async {
    return await authRemoteDataSource.signInFreelancer(email, password);
  }
  
  @override
  Future<Either<Failure, AuthEntity>> getUser(String email) {
    return authRemoteDataSource.getUser(email);
  }
}
