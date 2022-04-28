import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/models/Assignment.dart';
import './AssignmentInfo.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../../Providers/User.dart';

class EditCourse extends StatefulWidget {
  var index;
  EditCourse({Key? key, required this.index}) : super(key: key);

  @override
  State<EditCourse> createState() => _EditCourseState();
}

class _EditCourseState extends State<EditCourse> {
  var TitleController = TextEditingController();
  var MarkController = TextEditingController();
  var ContentController = TextEditingController();
  var WeekController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Media = MediaQuery.of(context);
    final user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 231, 244, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(124, 131, 253, 1),
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.angleLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          user.courses[widget.index].Name,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: const Icon(
              FontAwesomeIcons.graduationCap,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: Media.size.height,
        width: Media.size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Media.size.height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            scrollable: true,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 220, 84, 59)),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Random random = Random();
                                  int randomNumber = random.nextInt(10000);
                                  user.addAssignmentToACourse(
                                    user.courses[widget.index].id,
                                    {
                                      'title': TitleController.text,
                                      'mark': double.parse(MarkController.text),
                                      'date': int.parse(WeekController.text),
                                      'content': ContentController.text,
                                      'id': randomNumber,
                                    },
                                  );
                                  setState(() {
                                    user.courses[widget.index].assignments
                                        .insert(
                                      int.parse(WeekController.text),
                                      Assignment(
                                        Mark: double.parse(MarkController.text),
                                        Content: ContentController.text,
                                        Id: randomNumber,
                                        title: TitleController.text,
                                        date:
                                            int.parse(WeekController.text) - 1,
                                        status: false,
                                      ),
                                    );
                                    user.courses[widget.index].weeks =
                                        int.parse(WeekController.text);
                                  });

                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "ADD",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 51, 194, 170),
                                  ),
                                ),
                              ),
                            ],
                            title: const Text('Add Assignment'),
                            content: SizedBox(
                              height: Media.size.height * .5,
                              child: Form(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: TitleController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "please insert you title";
                                          }

                                          return null;
                                        },
                                        // controller: nameController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          labelText: "Title",
                                          hintText: "Assignment Title",
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromRGBO(
                                                124,
                                                131,
                                                254,
                                                1,
                                              ),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        controller: MarkController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "please insert you Mark";
                                          }
                                        },
                                        // controller: creditsCotnroller,
                                        decoration: InputDecoration(
                                          filled: true,
                                          labelText: "Marks",
                                          hintText: "Assignment Mark",
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromRGBO(
                                                  124, 131, 254, 1),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        controller: WeekController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "please insert Assignment Week";
                                          }
                                        },
                                        // controller: creditsCotnroller,
                                        decoration: InputDecoration(
                                          filled: true,
                                          labelText: "Week",
                                          hintText: "Assignment Week",
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromRGBO(
                                                  124, 131, 254, 1),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        controller: ContentController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "please insert Assignment Description";
                                          }
                                        },
                                        // controller: creditsCotnroller,
                                        decoration: InputDecoration(
                                          filled: true,
                                          labelText: "Description",
                                          hintText: "Assignment Description",
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromRGBO(
                                                  124, 131, 254, 1),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text("Add Assignments"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Open note Session"),
                  ),
                ],
              ),
              SizedBox(
                height: Media.size.height * .8,
                child: ListView.builder(
                  itemCount: user.courses[widget.index].assignments.isNotEmpty
                      ? user.courses[widget.index].weeks
                      : 0,
                  itemBuilder: (BuildContext context, int i) {
                    if (user.courses[widget.index].assignments[i].date ==
                        i + 1) {
                      return Container(
                        margin: const EdgeInsets.only(top: 30),
                        height: 150,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Week ${i + 1}",
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              color: Colors.grey[300],
                              width: Media.size.width,
                              height: 2,
                            ),
                            const Text(
                              "Assignments",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  user.courses[widget.index].assignments[i]
                                      .title,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromRGBO(124, 131, 253, 1),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AssignmentInfo(
                                            asgi: i,
                                            coursei: widget.index,
                                            asgContent: user
                                                .courses[widget.index]
                                                .assignments[i]
                                                .Content,
                                            asgMark: user.courses[widget.index]
                                                    .assignments[i].Mark +
                                                0.0,
                                            asgTitle: user.courses[widget.index]
                                                .assignments[i].title),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "view assignment",
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }
                    return Container(
                      child: Text("No content to be shown "),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
