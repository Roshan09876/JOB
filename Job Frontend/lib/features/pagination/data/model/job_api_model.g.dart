// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobApiModel _$JobApiModelFromJson(Map<String, dynamic> json) => JobApiModel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      description: json['description'] as String?,
      salary: json['salary'] as String?,
      location: json['location'] as String?,
      available: json['available'] as bool?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$JobApiModelToJson(JobApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'description': instance.description,
      'salary': instance.salary,
      'location': instance.location,
      'available': instance.available,
      'image': instance.image,
    };
