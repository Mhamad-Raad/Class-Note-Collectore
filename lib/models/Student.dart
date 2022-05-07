import 'package:flutter/material.dart';
import 'package:fyp/models/Education.dart';

class Student extends Education {
  int Section;
  int Credit;
  int Semester;
  double CGPU;

  addNote() {}

  checkClasses() {}

  logout() {}

  Student(
      {required String Name,
      required String Email,
      required String Password,
      required String Id,
      required String Type,
      required this.Section,
      required this.CGPU,
      required this.Credit,
      required this.Semester})
      : super(Name: Name, Email: Email, Password: Password, Id: Id, Type: Type);
}
