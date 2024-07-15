import 'package:equatable/equatable.dart';

class SearchEntity extends Equatable{
  final String id;
  final String title;
  final String description;
  final String salary;
  final String location;
  final bool availabe;
  final String jobType;

  SearchEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.salary,
      required this.location,
      required this.availabe,
      required this.jobType});
      
        @override
        // TODO: implement props
        List<Object?> get props => [
          id, title, description, salary, location, availabe, jobType
        ];
}
