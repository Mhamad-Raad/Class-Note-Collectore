import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fyp/models/Assignment.dart';
import 'package:fyp/models/Group.dart';
import 'package:fyp/models/Message.dart';
import 'package:fyp/models/Student.dart';
import 'package:http/http.dart' as http;
import '../models/Course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User extends ChangeNotifier {
  String Name;
  String Email;
  String id;
  String type;
  List<Course> courses = [];
  List<Map> allCourses = [];
  List<Group> groups = [];
  List<Group> allgroups = [];
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

  logout() {
    Name = '';
    Email = '';
    id = '';
    type = '';
    numberofCourses = 0;
    numberofStudents = 0;
    cgpa = 0;
    credits = 0;
    allCourses = [];
    courses = [];
    suggestions = [];
    groups = [];
    allgroups = [];
  }

  Future<bool> Login(email, password) async {
    bool found = false;

    var url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users.json';
    final response = await http.get(Uri.parse(url));

    var data = json.decode(response.body) as Map<String, dynamic>;

    data.forEach(
      (type, content) {
        var details = content as Map;

        if (type == "Student") {
          numberofStudents++;
        }
        if (type == "Student") {
          details.forEach((id, value) {
            if (email == value['email'] && password == value['password']) {
              var tempcgpa = value['cgpa'] as double;
              this.type = type;
              this.Email = value['email'];
              this.Name = value['name'];
              this.id = id;
              this.cgpa = tempcgpa;
              this.credits = value['credits'];

              found = true;
            }
          });
        }

        if (type == "Lecturer" || type == 'Admin') {
          details.forEach((id, value) {
            if (email == value['email'] && password == value['password']) {
              this.type = type;
              this.Email = value['email'];
              this.Name = value['name'];
              this.id = id;

              found = true;
            }
          });
        }
      },
    );

    return found;
  }

  Future<void> getCourses() async {
    courses = [];
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/${this.type}/${this.id}/courses.json';

    final response = await http.get(Uri.parse(url));

    var data = json.decode(response.body) as Map<String, dynamic>;

    data.forEach((id, structure) async {
      Course course = Course(Name: "Name", Credit: 0, Mark: 0.0, id: "0");

      course.id = id;
      this.courses.add(course);
      course.Name = structure['name'];

      course.Credit = structure['credits'];
      course.Mark = double.parse(structure['mark'].toString()) + 0.0;
      print(structure);
      course.progress = double.parse(structure['progress'].toString());
      course.weeks = structure['weeks'];

      try {
        var assignments = structure['assignments'] as Map<dynamic, dynamic>;

        assignments.forEach((id, structure) {
          var asg = Assignment(
            Mark: 0,
            Content: 'Content',
            Id: 0,
            status: false,
            title: "Assignment",
            date: 0,
          );
          asg.Id = int.parse(id);
          asg.Content = structure['content'];
          asg.Mark = structure['mark'];
          asg.title = structure['title'];
          asg.date = structure['date'] + 0;
          asg.status = structure['status'];
          course.assignments.add(asg);
        });
      } catch (e) {
        courses[courses.length - 1].assignments = [];
        print('no assignments for course ' + id + e.toString());
      }
    });

    notifyListeners();
  }

  addAssignmentToACourse(CourseID, asg) async {
    final myurl =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/Lecturer/${this.id}/courses/$CourseID/assignments/${asg['id']}.json';
    await http.put(
      Uri.parse(myurl),
      body: json.encode(
        {
          'title': asg['title'],
          'content': asg['content'],
          'mark': asg['mark'],
          'date': asg['date'] as int,
          'status': false,
        },
      ),
    );

    var lastLink =
        "https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/Lecturer/${this.id}/courses/$CourseID.json";
    await http.patch(
      Uri.parse(lastLink),
      body: json.encode(
        {
          'weeks': asg['date'] as int,
        },
      ),
    );

    const url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/Student.json';

    final response = await http.get(Uri.parse(url));
    var data = json.decode(response.body) as Map<String, dynamic>;

    data.forEach(
      (id, value) {
        var studentCourses = value['courses'] as Map;
        studentCourses.forEach(
          (key, value) async {
            if (key == CourseID) {
              final uri =
                  'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/Student/$id/courses/$CourseID/assignments/${asg['id']}.json';

              final last = await http.put(
                Uri.parse(uri),
                body: json.encode(
                  {
                    'title': asg['title'],
                    'content': asg['content'],
                    'mark': asg['mark'],
                    'date': asg['date'] as int,
                    'status': false,
                  },
                ),
              );
              var link =
                  "https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/Student/$id/courses/$key.json";
              await http.patch(
                Uri.parse(link),
                body: json.encode(
                  {
                    'weeks': asg['date'] as int,
                  },
                ),
              );
            }
          },
        );
      },
    );
  }

  updateAssignmentStatus(
      {courseIndex, assignmentIndex, required bool newStatus}) async {
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/Student/$id/courses/$courseIndex/assignments/$assignmentIndex.json';
    await http.patch(
      Uri.parse(url),
      body: json.encode({'status': newStatus}),
    );
  }

  notifystatus(courseIndex, assignmentIndex, newval) {
    courses[courseIndex].assignments[assignmentIndex].status = newval;
    notifyListeners();
  }

  updateAssignment({courseIndex, assignmentIndex, data}) async {
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/Lecturer/$id/courses/$courseIndex/assignments/$assignmentIndex.json';
    final a = await http.patch(
      Uri.parse(url),
      body: json.encode(
        {
          'content': data['content'],
          'title': data['title'],
          'mark': data['mark'] + 0,
        },
      ),
    );
    const studenturl =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/Student.json';
    final response = await http.get(
      Uri.parse(studenturl),
    );
    var d = json.decode(response.body) as Map;

    d.forEach(
      (studentID, value) {
        var studentCourse = value['courses'] as Map;
        studentCourse.forEach(
          (cID, value) async {
            if (cID == courseIndex) {
              final temp =
                  'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/Student/$studentID/courses/$cID/assignments/$assignmentIndex.json';
              var a = await http.patch(
                Uri.parse(temp),
                body: json.encode(
                  {
                    'content': data['content'],
                    'title': data['title'],
                    'mark': data['mark'] + 0,
                  },
                ),
              );
            }
          },
        );
      },
    );
  }

  deleteAssignment(courseID, assignmentID, neweek) async {
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/Lecturer/$id/courses/$courseID/assignments/$assignmentID.json';
    await http.delete(
      Uri.parse(url),
    );

    const studenturl =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/Student.json';
    final response = await http.get(
      Uri.parse(studenturl),
    );
    var data = json.decode(response.body) as Map;

    data.forEach(
      (studentID, value) {
        var studentCourse = value['courses'] as Map;
        studentCourse.forEach((cID, value) async {
          if (cID == courseID) {
            final temp =
                'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/Student/$studentID/courses/$cID/assignments/$assignmentID.json';
            var a = await http.delete(
              Uri.parse(temp),
            );
          }
        });
      },
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
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/Student/$id/courses/${courses[courseIndex].id}.json';

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
    numberofStudents++;
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

  Future<bool> searchStudents(String wanted) async {
    if (wanted != '' && wanted != ' ') {
      wanted = wanted.toLowerCase();
      const url =
          'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/Student.json';
      final response = await http.get(
        Uri.parse(url),
      );
      var data = json.decode(response.body) as Map<String, dynamic>;
      // print(data);
      suggestions.clear();
      data.forEach(
        (sID, value) {
          String temp = value['name'];
          temp = temp.toLowerCase();

          if (temp.contains(wanted)) {
            suggestions.add(
              {
                'name': value['name'],
                'id': sID,
                'type': value['type'],
                'credits': value['credits'],
                'cgpa': value['cgpa']
              },
            );

            notifyListeners();
          }
        },
      );
    }

    return false;
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
              if (value['type'] != "Admin") {
                String temp = value['name'].toString();
                temp = temp.toLowerCase();

                if (temp.contains(wanted) && temp != 'null') {
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
              }
            },
          );
        },
      );
    }

    return false;
  }

// users should be changed to value['type'] which you send via parameter later;
  Future<void> deleteuserCourse(usert, courseId, courseIndex, userid) async {
    notifyListeners();
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/$usert/$userid/courses/$courseId.json';

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
    numberofCourses++;
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

  Future addCourseToUser(userid, course, utype) async {
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/$utype/$userid/courses/${course['id']}.json';

    await http.put(
      Uri.parse(url),
      body: json.encode({
        'name': course['name'],
        'mark': course['mark'],
        'weeks': course['weeks'],
        'progress': course['progress'],
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

  UpdateGrade(cID, uID, aMark) async {
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/Student/$uID/courses/$cID.json';
    await http.patch(
      Uri.parse(url),
      body: json.encode(
        {
          'mark': aMark,
        },
      ),
    );
  }

  UpdatecourseNameAndCredits(CourseID, cName, cCredits) async {
    final url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/courses/$CourseID.json';
    await http.patch(
      Uri.parse(url),
      body: json.encode(
        {
          'name': cName,
          'credits': cCredits,
        },
      ),
    );
  }

  addGroups(courseData, courseLecture, courseStudents) async {
    var url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/groups/${courseData['id']}.json';
    await http.put(
      Uri.parse(url),
      body: json.encode(
        {
          'name': courseData['name'],
          'lname': courseLecture['name'],
          'lid': courseLecture['id'],
          'messages': '',
          'students': courseStudents,
        },
      ),
    );
    getallGroups();
  }

  getGroups() async {
    groups = [];
    var url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/groups.json';
    final response = await http.get(
      Uri.parse(url),
    );
    var data = json.decode(response.body) as Map;
    data.forEach(
      (id, content) {
        for (var i = 0; i < courses.length; i++) {
          if (id == courses[i].id) {
            var group = Group(id: id);
            group.lecturer.Name = content['lname'];
            group.lecturer.Id = content['lid'];
            group.title = content['name'];
            var students = content['students'] as List;

            students.forEach(
              (value) {
                var student = Student(
                  Name: value['name'],
                  Email: '',
                  Password: '',
                  Id: value["id"],
                  Type: 'Type',
                  Section: 0,
                  CGPU: 0,
                  Credit: 0,
                  Semester: 0,
                );
                group.students.add(student);
              },
            );
            var messages = content['messages'] as Map;
            messages.forEach((id, m) {
              var message = Message(Content: "", Ownerid: "", MessageId: "");
              message.Content = m['content'];
              message.Ownerid = m['ownerid'];
              message.MessageId = id;
              message.ownerName = m['ownername'];

              group.messages.add(message);
            });

            groups.add(group);
          }
        }
      },
    );
  }

  getallGroups() async {
    allgroups = [];
    var url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/groups.json';
    final response = await http.get(
      Uri.parse(url),
    );
    var data = json.decode(response.body) as Map;
    data.forEach(
      (id, content) {
        var group = Group(id: id);
        group.lecturer.Name = content['lname'];
        group.lecturer.Id = content['lid'];
        group.title = content['name'];
        var students = content['students'] as List;

        students.forEach(
          (value) {
            var student = Student(
              Name: value['name'],
              Email: '',
              Password: '',
              Id: value["id"],
              Type: 'Type',
              Section: 0,
              CGPU: 0,
              Credit: 0,
              Semester: 0,
            );
            group.students.add(student);
          },
        );
        allgroups.add(group);
      },
    );
  }

  updateGroupStudents(gid, gstudents) async {
    var url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/groups/$gid.json';
    final response = await http.patch(
      Uri.parse(url),
      body: json.encode(
        {
          'students': gstudents,
        },
      ),
    );
    getallGroups();
  }

  updateGroupLecturer(gid, cl) async {
    var url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/groups/$gid.json';
    final response = await http.patch(
      Uri.parse(url),
      body: json.encode(
        {
          'lid': cl['id'],
          'lname': cl['name'],
        },
      ),
    );
    getallGroups();
  }

  deleteAgroup(gid) async {
    var url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/groups/$gid.json';
    final response = await http.delete(
      Uri.parse(url),
    );
    allgroups.removeWhere((element) => element.id == gid);
  }

  addMessage(gid, message) async {
    var url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/groups/$gid/messages.json';
    final a = await http.post(
      Uri.parse(url),
      body: json.encode(
        {
          'ownerid': message['ownerid'],
          'ownername': message['ownername'],
          'content': message['content'],
          'time': Timestamp.now().seconds,
        },
      ),
    );
  }
}
