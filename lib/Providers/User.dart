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

  Future<void> Login(email, password) async {
    var url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users.json';
    final response = await http.get(Uri.parse(url));

    var data = json.decode(response.body) as Map<String, dynamic>;
    print(data);
    data.forEach((id, structure) {
      this.id = id;
      this.Name = structure['email'];
    });
  }
}
