import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:job_finder/features/pagination/domain/entity/job_entity.dart';

part 'job_api_model.g.dart';

@JsonSerializable()
class JobApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final String? subtitle;
  final String? description;
  final String? salary;
  final String? location;
  final bool? available;
  final String? image;

  JobApiModel({
    this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.salary,
    required this.location,
    required this.available,
    this.image,
  });

  // Convert JobApiModel to JobEntity
  JobEntity toEntity() {
    return JobEntity(
      id: this.id,
      title: this.title,
      subtitle: this.subtitle,
      description: this.description,
      salary: this.salary,
      location: this.location,
      available: this.available ?? false, image: '', 
    );
  }

  // Convert JobEntity to JobApiModel
  factory JobApiModel.fromEntity(JobEntity jobEntity) {
    return JobApiModel(
      id: jobEntity.id,
      title: jobEntity.title,
      subtitle: jobEntity.subtitle,
      description: jobEntity.description,
      salary: jobEntity.salary,
      location: jobEntity.location,
      available: jobEntity.available,
      image: null, // Image may not be part of JobEntity
    );
  }

  factory JobApiModel.fromJson(Map<String, dynamic> json) =>
      _$JobApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobApiModelToJson(this);

  @override
  List<Object?> get props =>
      [id, title, subtitle, description, salary, location, available, image];
}
