import 'package:json_annotation/json_annotation.dart';

part 'job_history_model.g.dart';


@JsonSerializable()
class JobHistoryModel {
  @JsonKey(name: "_id")
  final String? id;
  final String? title;
  final String? description;
  final String? salary;
  final String? location;
  final String? applicationStatus;
  final String? user;
  final String? image;
  final String? createdAt;
  final String? updatedAt;

  JobHistoryModel({
     this.id,
     this.title,
     this.description,
     this.salary,
     this.location,
     this.applicationStatus,
     this.user,
     this.image,
     this.createdAt,
     this.updatedAt,
  });


  //FromJSON
  factory JobHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$JobHistoryModelFromJson(json);

  //ToJSON
  Map<String, dynamic> toJson() => _$JobHistoryModelToJson(this);
}
