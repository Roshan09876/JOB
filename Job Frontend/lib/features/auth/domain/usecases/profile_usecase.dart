import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/common/Failure.dart';
import 'package:job_finder/features/auth/domain/entity/auth_entity.dart';
import 'package:job_finder/features/auth/domain/repository/auth_repository.dart';

final profileUseCaseProvider = Provider.autoDispose<ProfileUseCase>(
    (ref) => ProfileUseCase(ref.read(authRepositoryProvider)));

class ProfileUseCase {
  final AuthRepository authRepository;
  ProfileUseCase(this.authRepository);

  Future<Either<Failure,AuthEntity>> getUser(String email) async {
    return await authRepository.getUser(email);
  }
}
