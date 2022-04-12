import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fyp/models/Assignment.dart';
import 'package:http/http.dart' as http;

import '../models/Course.dart';

class User extends ChangeNotifier {
  String Name;
  String Email;
  String id;
  String type;
  String courseId = '';
  List<Course> courses = [];
  int credits = 0;
  double cgpa = 0;
  List<Map<dynamic, dynamic>> suggestions = [];

  User({
    required this.Name,
    required this.Email,
    required this.id,
    required this.type,
  });

  Future<bool> Login(email, password, type) async {
    bool found = false;

    var url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/$type.json';
    final response = await http.get(Uri.parse(url));

    var data = json.decode(response.body) as Map<String, dynamic>;

    data.forEach(
      (id, structure) {
        if (email == structure['email'] && password == structure['password']) {
          this.id = id;
          this.Email = structure['email'];
          this.Name = structure['name'];
          this.credits = structure['credits'];
          this.cgpa = structure['cgpa'];

          found = true;
        }
      },
    );

    return found;
  }

  Future<void> getCourses() async {
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/${this.type}/${this.id}/courses.json';

    final response = await http.get(Uri.parse(url));

    var data = json.decode(response.body) as Map<String, dynamic>;

    data.forEach((id, structure) async {
      Course course = Course(Name: "Name", Credit: 0, Mark: 0, id: "0");
      course.id = id;

      course.Name = await structure['name'];
      course.Credit = structure['credits'];
      course.Mark = structure['mark'];
      course.progress = structure['progress'] + 0.0;
      course.weeks = structure['weeks'];

      var assignments = structure['assignments'] as Map<String, dynamic>;

      assignments.forEach((id, structure) {
        var asg = Assignment(Mark: 0, Content: 'Content', Id: "0");
        asg.Id = id;
        asg.Content = structure['content'];
        asg.Mark = structure['mark'];
        asg.title = structure['title'];
        asg.date = structure['date'];
        asg.status = structure['status'];
        course.assignments.add(asg);
      });

      courses.add(course);
    });

    notifyListeners();
  }

  notifystatus(courseIndex, assignmentIndex, newval) {
    courses[courseIndex].assignments[assignmentIndex].status = newval;
    notifyListeners();
  }

  updateAssignmentStatus(
      {courseIndex, assignmentIndex, required bool newStatus}) async {
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/$type/$id/courses/"$courseIndex"/assignments/"$assignmentIndex".json';
    await http.patch(
      Uri.parse(url),
      body: json.encode({'status': newStatus}),
    );
  }

  updateCourseProgress(courseIndex) async {
    var percentage = 100 / courses[courseIndex].assignments.length;

    double total = 0;

    for (int i = 0; i < courses[courseIndex].assignments.length; i++) {
      if (courses[courseIndex].assignments[i].status == true) {
        total += percentage;
      }
    }

    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/$type/$id/courses/"$courseIndex".json';

    await http.patch(
      Uri.parse(url),
      body: json.encode({'progress': total}),
    );

    courses[courseIndex].progress = total;
    notifyListeners();
  }

  Future<void> addStudent({name, password, email, type, id}) async {
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/$type/$id.json';
    await http.put(
      Uri.parse(url),
      body: json.encode(
        {
          'type': type,
          'name': name,
          'password': password,
          'email': email,
          'id': id,
        },
      ),
    );
  }

  Future<void> addLecturer({type, name, course, email, password, id}) async {
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/$type/$id.json';
    await http.put(
      Uri.parse(url),
      body: json.encode(
        {
          'type': type,
          'name': name,
          'password': password,
          'email': email,
          'id': id,
          'course': course
        },
      ),
    );
  }

  Future<bool> searchUsers(String wanted) async {
    if (wanted != '' || wanted != ' ') {
      final url =
          'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/.json';
      final response = await http.get(
        Uri.parse(url),
      );
      var data = json.decode(response.body) as Map<String, dynamic>;
      // print(data);
      suggestions.clear();
      data.forEach(
        (a, value) {
          var body = value as Map<dynamic, dynamic>;
          body.forEach(
            (key, value) {
              String temp = value['name'];
              temp.toLowerCase();
              wanted.toLowerCase();
              if (temp.contains(wanted)) {
                suggestions.add(
                  {'name': temp, 'id': key, 'type': value['type']},
                );

                notifyListeners();
              }
            },
          );
        },
      );
    }

    return false;
  }
}
