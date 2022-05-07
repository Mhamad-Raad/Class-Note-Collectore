import 'dart:convert';

import './Person.dart';
import 'package:http/http.dart' as http;

class Admin extends Person {
  editUsers(func, user, upuser) async {
    var url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCNEtBHPTTDiMaBx7B35rdmHmY1nVWEccE";

    if (func == "Add") {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'email': 'anyhting@gmail.com',
          'password': 'hamagyanH1231da',
          'returnSecureToken': true,
        }),
      );
      print("hjk");
    } else {
      print("jfsd");
    }
  }

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
      : super(
            Name: Name, Email: Email, Password: Password, Id: "Id", Type: Type);
}
