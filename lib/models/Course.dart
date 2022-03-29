import 'package:fyp/models/Assignment.dart';

class Course {
  List<Assignment> assignments = [];

  String Name;
  int Credit;
  double Mark;
  int id;

  Course({
    required this.Name,
    required this.Credit,
    required this.Mark,
    required this.id,
  });

  addAssignment(assignment) {
    assignments.add(assignment);
  }
}
