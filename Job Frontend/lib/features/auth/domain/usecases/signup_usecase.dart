import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/common/Failure.dart';
import 'package:job_finder/features/auth/domain/entity/auth_entity.dart';
import 'package:job_finder/features/auth/domain/repository/auth_repository.dart';

final signUpUseCaseProvider = Provider.autoDispose<SignUpUseCase>(
    (ref) => SignUpUseCase(ref.read(authRepositoryProvider)));

class SignUpUseCase {
  final AuthRepository authRepository;
  SignUpUseCase(this.authRepository);

  Future<Either<Failure, bool>> signUpFreelancer(AuthEntity entity) async {
    return await authRepository.signUpFreelancer(entity);
  }
}
