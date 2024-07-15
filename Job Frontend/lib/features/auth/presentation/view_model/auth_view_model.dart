import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/common/snackbar/my_snackbar.dart';
import 'package:job_finder/config/router/app_routes.dart';
import 'package:job_finder/core/shared_pref/user_shared_pref.dart';
import 'package:job_finder/features/auth/domain/entity/auth_entity.dart';
import 'package:job_finder/features/auth/domain/usecases/login_usecase.dart';
import 'package:job_finder/features/auth/domain/usecases/profile_usecase.dart';
import 'package:job_finder/features/auth/domain/usecases/signup_usecase.dart';
import 'package:job_finder/features/auth/presentation/state/auth_state.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
    (ref) => AuthViewModel(ref.read(signUpUseCaseProvider),
        ref.read(loginUseCaseProvider), ref.read(profileUseCaseProvider)));

class AuthViewModel extends StateNotifier<AuthState> {
  final SignUpUseCase signUpUseCase;
  final LoginUseCase loginUseCase;
  final ProfileUseCase profileUseCase;

  AuthViewModel(
    this.signUpUseCase,
    this.loginUseCase,
    this.profileUseCase,
  ) : super(AuthState.initial());

  Future<void> signUpFreelancer(
      AuthEntity authEntity, BuildContext context) async {
    state = state.copyWith(isLoading: true);

    final result = await signUpUseCase.signUpFreelancer(authEntity);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
          showMessage: true,
        );
        Navigator.pushNamed(context, AppRoute.loginviewRoute);
        EasyLoading.showSuccess('Sign up successful');
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          showMessage: true,
          error: null,
        );
        // Handle success: Navigate to the login view
        EasyLoading.showError('User already exist');
      },
    );
  }

  Future<void> signInFreelancer(
      BuildContext context, String email, String password) async {
    EasyLoading.show(status: 'Loading...');

    final result = await loginUseCase.signInFreelancer(email, password);

    EasyLoading.dismiss();

    result.fold(
      (failure) {
        state = state.copyWith(
          error: failure.error,
          showMessage: true,
        );
        EasyLoading.showError(failure.error);
      },
      (success) {
        state = state.copyWith(
          showMessage: true,
          error: null,
        );
        EasyLoading.showSuccess('Successfully Logged in');
        Navigator.pushReplacementNamed(context, AppRoute.homeViewRoute);
        getUser(context, email);
      },
    );
  }

  void reset() {
    state = state.copyWith(
      isLoading: false,
      error: null,
      imageName: null,
      showMessage: false,
    );
  }

  Future<void> getUser(BuildContext context, String email) async {
    state = state.copyWith(isLoading: true);

    var data = await profileUseCase.getUser(email);

    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
          message: 'Invalid Credentials',
          context: context,
          color: Colors.red,
        );
      },
      (success) {
        state =
            state.copyWith(isLoading: false, error: null, currentUser: success);
      },
    );
  }

  void logout(BuildContext context) async {
    // state = true;

    EasyLoading.show(status: 'Logging Out.....', );
    showSnackBar(
        message: 'Logging out....', context: context, color: Colors.red);
        EasyLoading.dismiss();

    await UserSharedPref().deleteUserToken();

    Future.delayed(const Duration(milliseconds: 2000), () {
      // state = false;

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.loginviewRoute,
        (route) => false,
      );
    });
  }

  void resetMessage() {
    state = state.copyWith(
        showMessage: false, imageName: null, error: null, isLoading: false);
  }
}
