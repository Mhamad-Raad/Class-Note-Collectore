import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/models/Student.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/User.dart';

class editStudents extends StatefulWidget {
  var gid;
  List<Student> students;
  editStudents({Key? key, required this.gid, required this.students})
      : super(key: key);

  @override
  State<editStudents> createState() => _editStudentsState();
}

class _editStudentsState extends State<editStudents> {
  List<Map> courseStudents = [];
  var isLoading = false;
  List<bool> selectedUsers = [];
  int count = 0;
  var searchController = TextEditingController();
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
            user.suggestions = [];
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
      body: SizedBox(
        height: Media.size.height,
        width: Media.size.width,
        child: Column(
          children: [
            SizedBox(
              height: Media.size.height * .05,
            ),
            SizedBox(
              // color: Colors.amber,
              height: Media.size.height * .1,
              width: Media.size.width * .85,
              child: TextField(
                onChanged: (value) async {
                  setState(() {
                    isLoading = true;
                  });
                  await user.searchUsers(searchController.text).then((value) {
                    setState(() {
                      isLoading = false;
                    });
                  });
                  selectedUsers = List.filled(user.suggestions.length, false);
                  courseStudents = [];
                  count = 0;
                  for (var i = 0; i < widget.students.length; i++) {
                    for (var ii = 0; ii < user.suggestions.length; ii++) {
                      if (user.suggestions[ii]['type'] == 'Student' &&
                          user.suggestions[ii]['id'] == widget.students[i].Id) {
                        count++;
                        selectedUsers[ii] = true;
                        courseStudents.add({
                          'name': user.suggestions[ii]['name'],
                          'id': user.suggestions[ii]['id'],
                        });
                      }
                    }
                  }
                },
                controller: searchController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await user
                          .searchUsers(searchController.text)
                          .then((value) {
                        setState(() {
                          isLoading = false;
                        });
                      });
                      selectedUsers =
                          List.filled(user.suggestions.length, false);
                      courseStudents = [];
                      count = 0;
                      for (var i = 0; i < widget.students.length; i++) {
                        for (var ii = 0; ii < user.suggestions.length; ii++) {
                          if (user.suggestions[ii]['type'] == 'Student' &&
                              user.suggestions[ii]['id'] ==
                                  widget.students[i].Id) {
                            count++;
                            selectedUsers[ii] = true;
                            courseStudents.add({
                              'name': user.suggestions[ii]['name'],
                              'id': user.suggestions[ii]['id'],
                            });
                          }
                        }
                      }
                    },
                    icon: const Icon(
                      Icons.search_rounded,
                      size: 32,
                      color: Color.fromARGB(255, 111, 112, 153),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(124, 131, 253, 1), width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 111, 112, 153), width: 2.0),
                  ),
                  hintText: 'Search',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                        itemCount: user.suggestions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return user.suggestions[index]['type'] == 'Student'
                              ? ListTile(
                                  title: Text(
                                    user.suggestions[index]['name'] ?? 'user',
                                  ),
                                  subtitle: Text(
                                    user.suggestions[index]['type'] ?? "User",
                                  ),
                                  trailing: Checkbox(
                                    onChanged: (value) {
                                      if (value == true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'you must select one or more students'),
                                          ),
                                        );

                                        setState(() {
                                          selectedUsers[index] =
                                              !selectedUsers[index];
                                        });
                                        courseStudents.add({
                                          'name': user.suggestions[index]
                                              ['name'],
                                          'id': user.suggestions[index]['id'],
                                        });

                                        count++;
                                      } else if (value == false) {
                                        setState(() {
                                          selectedUsers[index] =
                                              !selectedUsers[index];
                                        });
                                        courseStudents.removeAt(index);
                                        count--;
                                      }
                                    },
                                    value: selectedUsers == null
                                        ? false
                                        : selectedUsers[index],
                                  ),
                                )
                              : Container();
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: count == 0
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select one or more students'),
                  ),
                );
              }
            : () async {
                await user.updateGroupStudents(widget.gid, courseStudents);
                courseStudents = [];
                selectedUsers = [];
                user.suggestions = [];
                Navigator.pop(context);
              },
        backgroundColor: const Color.fromRGBO(124, 131, 253, 1),
        child: const Icon(Icons.next_plan),
      ),
    );
  }
}
