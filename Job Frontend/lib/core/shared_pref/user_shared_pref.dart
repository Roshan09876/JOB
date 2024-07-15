import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/core/common/Failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userSharedPrefsProvider = Provider<UserSharedPref>((ref) {
  return UserSharedPref();
});

class UserSharedPref {
  late SharedPreferences sharedPreferences;

//Setting Up Token (Save token in SharedPreference)
  Future<Either<Failure, bool>> setUserToken(String token) async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('token', token);
      return right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  //Getting Token (Retrieve user token from shared preference)
  Future<Either<Failure, String?>> getUserToken() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      final token = sharedPreferences.getString('token');
      return right(token);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  //Removing token from Sharedpreference
  Future<Either<Failure, bool>> deleteUserToken() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.remove('token');
      return Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

    Future<Either<Failure, String?>> getUserId() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      final token = sharedPreferences.getString('userId');
      return right(token);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> setUserId(String userId) async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('userId', userId);
      return Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
