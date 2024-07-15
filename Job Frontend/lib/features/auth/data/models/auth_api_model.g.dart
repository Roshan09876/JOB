// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      freelancerId: json['_id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      location: json['location'] as String?,
      phoneNum: json['phoneNum'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      jobHistory: (json['jobHistory'] as List<dynamic>?)
          ?.map((e) => JobHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.freelancerId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'location': instance.location,
      'phoneNum': instance.phoneNum,
      'email': instance.email,
      'password': instance.password,
      'jobHistory': instance.jobHistory,
    };
