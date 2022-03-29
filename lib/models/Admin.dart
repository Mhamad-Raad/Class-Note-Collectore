import './Person.dart';

class Admin extends Person {
  editUsers() {}

  Login() {}

  addClasses() {}

  addGroups() {}

  logout() {}

  Admin(
      {required String Name,
      required String Email,
      required String Password,
      required int Id,
      required String Type})
      : super(Name: Name, Email: Email, Password: Password, Id: Id, Type: Type);
}
