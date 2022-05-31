import 'package:fyp/models/Message.dart';

import 'Lecturer.dart';
import 'Student.dart';

class Group {
  var id;

  List<Student> students = [];
  Lecturer lecturer = Lecturer(
      Name: "USER", Email: "Email", Password: "Password", Id: "", Type: "");
  List<Message> messages = [];
  late var title;

  Group({
    required this.id,
  });
}
