import 'package:fyp/models/Assignment.dart';

class Course {
  List<Assignment> assignments = [];

  String Name;
  int Credit;
  int Mark;
  String id;
  int progress = 0;
  var weeks = 0;

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
