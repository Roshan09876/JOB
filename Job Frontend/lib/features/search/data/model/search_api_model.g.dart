// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchApiModel _$SearchApiModelFromJson(Map<String, dynamic> json) =>
    SearchApiModel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      description: json['description'] as String?,
      salary: json['salary'] as String?,
      location: json['location'] as String?,
      available: json['available'] as bool?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$SearchApiModelToJson(SearchApiModel instance) =>
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
