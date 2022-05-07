import './Course.dart';
import './Person.dart';

class Education extends Person {
  List<Course> Courses = [];

  Education(
      {required String Name,
      required String Email,
      required String Password,
      required String Id,
      required String Type})
      : super(Name: Name, Email: Email, Password: Password, Id: Id, Type: Type);

  setCours(course) {
    Courses.add(course);
  }
}
