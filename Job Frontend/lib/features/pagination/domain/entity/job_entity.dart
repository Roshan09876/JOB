import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  final String? id;
  final String? title;
  final String? subtitle;
  final String? description;
  final String? salary;
  final String? location;
  final bool? available;
  final String? image;

  JobEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.salary,
    required this.location,
    required this.available,
    required this.image,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, title, subtitle, description, salary, location, available, image];
}
