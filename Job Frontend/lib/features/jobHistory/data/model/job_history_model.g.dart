// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobHistoryModel _$JobHistoryModelFromJson(Map<String, dynamic> json) =>
    JobHistoryModel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      salary: json['salary'] as String?,
      location: json['location'] as String?,
      applicationStatus: json['applicationStatus'] as String?,
      user: json['user'] as String?,
      image: json['image'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$JobHistoryModelToJson(JobHistoryModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'salary': instance.salary,
      'location': instance.location,
      'applicationStatus': instance.applicationStatus,
      'user': instance.user,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
