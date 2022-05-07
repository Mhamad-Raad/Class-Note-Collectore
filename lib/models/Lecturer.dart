import 'package:fyp/models/Education.dart';

class Lecturer extends Education {
  login() {}

  addAssignment() {}

  groupCall() {}

  openNoteSession() {}

  checkClasses() {}

  logout() {}

  Lecturer(
      {required String Name,
      required String Email,
      required String Password,
      required String Id,
      required String Type})
      : super(Name: Name, Email: Email, Password: Password, Id: Id, Type: Type);
}
