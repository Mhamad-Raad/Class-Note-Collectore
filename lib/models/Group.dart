import 'package:fyp/models/Message.dart';

import 'Lecturer.dart';
import 'Student.dart';

class Group {
  int id;

  List<Student> students = [];
  late Lecturer lecturer;
  late Message message;

  Group({required this.id});
}
