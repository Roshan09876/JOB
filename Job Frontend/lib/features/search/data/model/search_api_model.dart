import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_api_model.g.dart';

@JsonSerializable()
class SearchApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final String? subtitle;
  final String? description;
  final String? salary;
  final String? location;
  final bool? available;
  final String? image;

  SearchApiModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.salary,
    required this.location,
    required this.available,
    this.image,
  });

  // From JSON
  factory SearchApiModel.fromJson(Map<String, dynamic> json) =>
      _$SearchApiModelFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$SearchApiModelToJson(this);

  @override
  List<Object?> get props =>
      [id, title, subtitle, description, salary, location, available, image];
}
