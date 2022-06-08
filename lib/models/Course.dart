import 'package:fyp/models/Assignment.dart';
import 'package:fyp/models/Notes.dart';

class Course {
  List<Assignment> assignments = [];

  String Name;
  int Credit;
  double Mark;
  int id;
  double progress = 0;
  var weeks = 0;
  List<Note> notes = [];

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
