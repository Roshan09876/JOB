import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/common/Failure.dart';
import 'package:job_finder/features/auth/domain/entity/auth_entity.dart';
import 'package:job_finder/features/auth/domain/usecases/login_usecase.dart';
import 'package:job_finder/features/auth/domain/usecases/profile_usecase.dart';
import 'package:job_finder/features/auth/domain/usecases/signup_usecase.dart';
import 'package:job_finder/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'auth_unit_test.mocks.dart';

//flutter packages pub run build_runner build

@GenerateNiceMocks([
  MockSpec<SignUpUseCase>(),
  MockSpec<LoginUseCase>(),
  MockSpec<ProfileUseCase>(),
  MockSpec<BuildContext>(),
])

//We use providercontainer instead of providerscope because it do not accept providerScope
void main() {
  late SignUpUseCase mockSignUpUseCase;
  late LoginUseCase mockLoginUseCase;
  late ProfileUseCase mockProfileUseCase;
  late ProviderContainer container;
  late BuildContext context;

  setUpAll(() {
    mockSignUpUseCase = MockSignUpUseCase();
    mockLoginUseCase = MockLoginUseCase();
    mockProfileUseCase = MockProfileUseCase();
    context = MockBuildContext();
    container = ProviderContainer(overrides: [
      authViewModelProvider.overrideWith(
          (ref) => AuthViewModel(mockSignUpUseCase, mockLoginUseCase, mockProfileUseCase,))
    ]);
  });

  test('Check for initial test', () async {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.showMessage, false);
  });


    //Testing Login (yo code aaile API samma pugexaina just yele check matrea gareko xa frontend ma matra)
  test('Login test with valid email and password', () async {
    when(mockLoginUseCase.signInFreelancer('user@gmail.com', 'user123'))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container
        .read(authViewModelProvider.notifier)
        .signInFreelancer(context, 'user@gmail.com', 'user123');

    final authState = container.read(authViewModelProvider);

    expect(authState.error, isNull);
  });


  test('test signup with no credentials', () async {
      /// Creating a proper mock failure for failed login with invalid email
      final mockErrorModel = Failure(
        error: 'Please enter email',
      );

      /// if provided certain credential returen the mockErrorModel
      when(
        mockSignUpUseCase.signUpFreelancer(AuthEntity(
            firstName: null.toString(),
            lastName: null.toString(),
            location: null.toString(),
            phoneNum: null.toString(),
            email: null.toString(),
            password: null.toString(),
      )
      ));
      // Call the login method
      final result = await mockSignUpUseCase.signUpFreelancer(AuthEntity(
          firstName: null.toString(),
            lastName: null.toString(),
            location: null.toString(),
            phoneNum: null.toString(),
            email: null.toString(),
            password: null.toString(),));

      // Verify the expected result
      expect(
        result,
        Left(mockErrorModel),
      );
    });

  tearDownAll(() {
    container.dispose();
  });

  
}