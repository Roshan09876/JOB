import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/common/Failure.dart';
import 'package:job_finder/features/auth/domain/repository/auth_repository.dart';

final loginUseCaseProvider = Provider.autoDispose<LoginUseCase>(
    (ref) => LoginUseCase(ref.watch(authRepositoryProvider)));

class LoginUseCase {
  final AuthRepository authRepository;
  LoginUseCase(this.authRepository);

  Future<Either<Failure, bool>> signInFreelancer(
      String email, String password) async {
    return await authRepository.signInFreelancer(email, password);
  }
}
