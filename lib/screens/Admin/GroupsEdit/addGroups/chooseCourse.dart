import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/screens/Admin/GroupsEdit/addGroups/SearchMembers.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/User.dart';

class ChooseCurse extends StatefulWidget {
  final numberOfCourses;
  ChooseCurse({Key? key, required this.numberOfCourses}) : super(key: key);

  @override
  State<ChooseCurse> createState() => _ChooseCurseState();
}

class _ChooseCurseState extends State<ChooseCurse> {
  late List<bool> selectedCourse;
  bool selected = false;
  var courseData;
  int countSelected = 0;
  @override
  void initState() {
    selectedCourse = List.filled(widget.numberOfCourses, false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: true);
    final Media = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 231, 244, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(124, 131, 253, 1),
        centerTitle: true,
        title: const Text(
          "Groups",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          },
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: const IconButton(
              onPressed: null,
              icon: Icon(
                FontAwesomeIcons.graduationCap,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: user.allCourses.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              user.allCourses[index]['name'],
            ),
            trailing: Checkbox(
              onChanged: (value) {
                setState(() {
                  selected = false;

                  selectedCourse[index] = !selectedCourse[index];
                  if (selectedCourse[index] == false) {
                    countSelected--;
                  } else {
                    countSelected++;
                    if (countSelected == 1) {
                      courseData = {
                        "name": user.allCourses[index]['name'],
                        'id': user.allCourses[index]['id'],
                      };
                    }
                  }
                  selectedCourse.forEach((element) {
                    if (element == true) {
                      selected = true;
                    }
                  });
                });
              },
              value: selectedCourse[index],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: selected
            ? const Color.fromRGBO(124, 131, 253, 1)
            : const Color.fromARGB(255, 134, 135, 155),
        onPressed: selected
            ? () {
                if (countSelected > 1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('you can only select one course'),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddMemebers(
                        courseData: courseData,
                      ),
                    ),
                  );
                }
              }
            : null,
        child: const Icon(Icons.add),
      ),
    );
  }
}
