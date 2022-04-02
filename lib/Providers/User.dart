import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class User extends ChangeNotifier {
  String Name;
  String Email;
  String id;
  String type;

  User({
    required this.Name,
    required this.Email,
    required this.id,
    required this.type,
  });

  Future<bool> Login(email, password, type) async {
    print(email + password);

    bool found = false;

    var url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/$type.json';
    final response = await http.get(Uri.parse(url));

    var data = json.decode(response.body) as Map<String, dynamic>;

    data.forEach((id, structure) {
      if (email == structure['email'] && password == structure['password']) {
        this.id = id;
        this.Email = structure['email'];
        this.type = structure['type'];
        this.Name = structure['name'];
        found = true;
      }
    });

    return found;
  }
}
