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
  List<Course> courses = [];
  List<Map> allCourses = [];
  int credits = 0;
  double cgpa = 0;
  List<Map<dynamic, dynamic>> suggestions = [];
  int numberofStudents = 0;
  int numberofCourses = 0;

  User({
    required this.Name,
    required this.Email,
    required this.id,
    required this.type,
  });

  Future<bool> Login(email, password, type) async {
    bool found = false;

    var url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users.json';
    final response = await http.get(Uri.parse(url));

    var data = json.decode(response.body) as Map<String, dynamic>;

    data.forEach((type, content) {
      var details = content as Map;
      if (type == "Student") {
        numberofStudents++;
      }
      details.forEach((id, value) {
        if (email == value['email'] && password == value['password']) {
          this.type = type;
          this.Email = value['email'];
          this.Name = value['name'];
          this.id = id;
          // this.cgpa = value['cgpa'] + 0.0;
          // this.credits = value['credits'];

          found = true;
        }
      });
    });

    return found;
  }

  Future<void> getCourses() async {
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/${this.type}/${this.id}/courses.json';

    final response = await http.get(Uri.parse(url));

    try {
      var data = json.decode(response.body) as Map<String, dynamic>;

      data.forEach((id, structure) async {
        Course course = Course(Name: "Name", Credit: 0, Mark: 0, id: "0");
        course.id = id;

        course.Name = await structure['name'];
        course.Credit = structure['credits'];
        course.Mark = structure['mark'];
        course.progress = structure['progress'] + 1.0 - 1.0;
        course.weeks = structure['weeks'];
        try {
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
        } catch (e) {
          print(e);
        }

        courses.add(course);
      });
    } catch (e) {
      print(e);
    }

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
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/$type/$id.json';
    await http.put(
      Uri.parse(url),
      body: json.encode(
        {
          'type': type,
          'name': name,
          'password': password,
          'email': email,
          'id': id,
          'credits': 0,
          'cgpa': 0.0
        },
      ),
    );
  }

  Future<void> addLecturer({type, name, course, email, password, id}) async {
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/$type/$id.json';
    await http.put(
      Uri.parse(url),
      body: json.encode(
        {
          'type': type,
          'name': name,
          'password': password,
          'email': email,
          'id': id,
          'courses': {
            course['id']: {
              'name': course['name'],
              'mark': course['mark'],
              'credits': course['credits'],
              'weeks': course['weeks'],
              'progress': course['progress']
            },
          }
        },
      ),
    );
  }

  Future<bool> searchUsers(String wanted) async {
    if (wanted != '' && wanted != ' ') {
      wanted = wanted.toLowerCase();
      const url =
          'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users.json';
      final response = await http.get(
        Uri.parse(url),
      );
      var data = json.decode(response.body) as Map<String, dynamic>;
      // print(data);
      suggestions.clear();
      data.forEach(
        (type, value) {
          var body = value as Map<dynamic, dynamic>;
          body.forEach(
            (key, value) {
              String temp = value['name'];
              temp = temp.toLowerCase();

              if (temp.contains(wanted)) {
                suggestions.add(
                  {
                    'name': value['name'],
                    'id': key,
                    'type': value['type'],
                    'credits': value['credits'],
                    'cgpa': value['cgpa']
                  },
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

// users should be changed to value['type'] which you send via parameter later;
  Future<void> deleteuserCourse(courseId, courseIndex, userid) async {
    notifyListeners();
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/$userid/courses/$courseId.json';

    await http.delete(
      Uri.parse(url),
    );
    // .then((response) => () {
    //       if (response.statusCode >= 400) {
    //         throw httpException("Connection error");
    //       }
    //     })
    // .catchError(
    //   (_) {},
    // );
  }

  Future deleteAcourse(courseid) async {
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/courses/$courseid.json';
    var response = await http.delete(
      Uri.parse(url),
    );
  }

  Future addAcourse(course) async {
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/courses/${course['id']}.json';
    final response = await http.put(
      Uri.parse(url),
      body: json.encode({
        'name': course['name'],
        'mark': course['mark'],
        'weeks': course['weeks'],
        'progree': course['progress'],
        'credits': course['credits'],
      }),
    );
  }

  getAllCourses() async {
    allCourses = [];
    const url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/courses.json';

    final response = await http.get(
      Uri.parse(url),
    );

    try {
      var data = json.decode(response.body) as Map<dynamic, dynamic>;

      data.forEach((key, value) {
        allCourses.add(
          {
            'credits': value['credits'],
            'name': value['name'],
            'progress': value['progress'],
            'weeks': value['weeks'],
            'id': key,
            'mark': value['mark'],
          },
        );

        numberofCourses++;
      });
      return data;
    } catch (e) {
      print(" Courses");
      print(e);
    }
  }

  Future addCourseToUser(userid, course) async {
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/$type/$userid/courses/${course['id']}.json';

    await http.put(
      Uri.parse(url),
      body: json.encode({
        'name': course['name'],
        'mark': course['mark'],
        'weeks': course['weeks'],
        'progree': course['progress'],
        'credits': course['credits']
      }),
    );
  }

  Future updateUsernameAndCgpaAndPassword(
      {name, passowrd, cgpa, userid, type}) async {
    print(userid);
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/$type/$userid.json';
    if (type == 'Lecturer') {
      await http.patch(
        Uri.parse(url),
        body: json.encode(
          {
            'name': name,
            'password': passowrd,
          },
        ),
      );
    } else {
      await http.patch(
        Uri.parse(url),
        body: json.encode(
          {'name': name, 'password': passowrd, 'cgpa': cgpa},
        ),
      );
    }
  }
}
