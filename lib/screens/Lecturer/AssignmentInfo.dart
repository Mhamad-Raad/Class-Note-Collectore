import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/screens/Lecturer/Courses.dart';
import 'package:fyp/screens/Lecturer/EditCourse.dart';
import 'package:provider/provider.dart';

import '../../Providers/User.dart';

class AssignmentInfo extends StatefulWidget {
  var asgi;
  var coursei;
  var asgTitle;
  var asgContent;
  double asgMark;
  AssignmentInfo({
    required this.asgi,
    required this.coursei,
    required this.asgContent,
    required this.asgMark,
    required this.asgTitle,
  });

  @override
  State<AssignmentInfo> createState() => _AssignmentInfoState();
}

class _AssignmentInfoState extends State<AssignmentInfo> {
  var titleController = TextEditingController();
  var markController = TextEditingController();
  var contentController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.asgTitle;
    markController.text = widget.asgMark.toString();
    contentController.text = widget.asgContent;
    // TODO: implement initState
    super.initState();
  }

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
          user.courses[widget.coursei].assignments[widget.asgi].title,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(
                FontAwesomeIcons.trash,
                color: Colors.red,
              ),
              onPressed: () async {
                await user.deleteAssignment(
                    user.courses[widget.coursei].id,
                    user.courses[widget.coursei].assignments[widget.asgi].Id,
                    user.courses[widget.coursei].weeks - 1);
                
                  user.courses[widget.coursei].assignments
                      .removeAt(widget.asgi);
                  user.courses[widget.coursei].weeks--;
           

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => CoursesDetails()),
                );
              },
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: Media.size.height,
        width: Media.size.width,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            height: Media.size.height * .8,
            width: Media.size.width * .8,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(242, 250, 255, .63),
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Title: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              height: 30,
                              child: TextField(
                                controller: titleController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(124, 131, 254, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Percentage: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              height: 30,
                              child: TextField(
                                controller: markController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(124, 131, 254, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Content: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextField(
                    controller: contentController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(124, 131, 254, 1),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await user.updateAssignment(
                        assignmentIndex: user.courses[widget.coursei]
                            .assignments[widget.asgi].Id,
                        courseIndex: user.courses[widget.coursei].id,
                        data: {
                          'title': titleController.text,
                          'mark': double.parse(markController.text),
                          'content': contentController.text,
                        },
                      );
                      setState(() {
                        user.courses[widget.coursei].assignments[widget.asgi]
                            .title = titleController.text;
                        user.courses[widget.coursei].assignments[widget.asgi]
                            .Mark = markController.text;
                        user.courses[widget.coursei].assignments[widget.asgi]
                            .Content = contentController.text;
                      });
                    },
                    child: const Text("Update"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
