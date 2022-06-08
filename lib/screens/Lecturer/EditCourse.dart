import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/models/Assignment.dart';
import 'package:fyp/screens/Lecturer/writeNoteL.dart';
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
  List v = List.generate(3, (index) => false);
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
                                    user.courses[widget.index].assignments.add(
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
                                    if (int.parse(WeekController.text) >
                                        user.courses[widget.index].weeks + 1) {
                                      user.courses[widget.index].weeks =
                                          int.parse(WeekController.text);
                                    } else {
                                      user.courses[widget.index].weeks++;
                                    }
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
                    onPressed: () async {
                      await user.createNote(widget.index);
                      setState(() {});
                    },
                    child: const Text("Open note Session"),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    height: Media.size.height * .7 * .11,
                    width: Media.size.width * .95,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: (v[0] == true)
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            )
                          : const BorderRadius.all(
                              Radius.circular(50),
                            ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Assignments"),
                        IconButton(
                          icon: Icon(
                            (v[0] == true)
                                ? FontAwesomeIcons.angleDown
                                : FontAwesomeIcons.angleRight,
                          ),
                          onPressed: () {
                            setState(() {
                              v[0] = !v[0];
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  (v[0] == true)
                      ? Container(
                          height: Media.size.height * .9 * .3,
                          width: Media.size.width * .95,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 70),
                            height: 200,
                            child: ListView.builder(
                              itemCount:
                                  user.courses[widget.index].assignments.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                    top: 20,
                                    bottom: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text("Title"),
                                          Text(
                                            user.courses[widget.index]
                                                .assignments[index].title,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text("Week"),
                                          Text(
                                            user.courses[widget.index]
                                                .assignments[index].date
                                                .toString(),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color.fromRGBO(
                                              124, 131, 253, 1),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AssignmentInfo(
                                                      asgi: index,
                                                      coursei: widget.index,
                                                      asgContent: user
                                                          .courses[widget.index]
                                                          .assignments[index]
                                                          .Content,
                                                      asgMark: user
                                                              .courses[
                                                                  widget.index]
                                                              .assignments[
                                                                  index]
                                                              .Mark +
                                                          0.0,
                                                      asgTitle: user
                                                          .courses[widget.index]
                                                          .assignments[index]
                                                          .title),
                                            ),
                                          );
                                        },
                                        child: const Text("View assignment"),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    width: Media.size.width,
                    height: Media.size.height,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 7),
                          height: Media.size.height * .7 * .11,
                          width: Media.size.width * .95,
                          margin: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: (v[1] == true)
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  )
                                : const BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Notes"),
                              IconButton(
                                icon: Icon(
                                  (v[1] == true)
                                      ? FontAwesomeIcons.angleDown
                                      : FontAwesomeIcons.angleRight,
                                ),
                                onPressed: () {
                                  setState(() {
                                    v[1] = !v[1];
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        v[1]
                            ? Container(
                                height: Media.size.height * .9 * .3,
                                width: Media.size.width * .95,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 70),
                                  height: 200,
                                  child: ListView.builder(
                                    itemCount:
                                        user.courses[widget.index].notes.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        margin: const EdgeInsets.only(
                                          top: 20,
                                          bottom: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                const Text("Title"),
                                                Text(
                                                  user.courses[widget.index]
                                                      .notes[index].noteTitle,
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: const Color.fromRGBO(
                                                    124, 131, 253, 1),
                                              ),
                                              onPressed: () {
                                                if (user.courses[widget.index]
                                                    .notes[index].open) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          WriteNoteL(
                                                        cindex: widget.index,
                                                        note: user
                                                            .courses[
                                                                widget.index]
                                                            .notes[index],
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                              child: user.courses[widget.index]
                                                      .notes[index].open
                                                  ? Text("Write Note")
                                                  : Text("View Note"),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
