import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/screens/Lecturer/EditCourse.dart';

import 'package:provider/provider.dart';

import '../../Providers/User.dart';
import './profile.dart';

class CoursesDetails extends StatefulWidget {
  const CoursesDetails({Key? key}) : super(key: key);

  @override
  State<CoursesDetails> createState() => _CoursesDetailsState();
}

class _CoursesDetailsState extends State<CoursesDetails> {
  List v = List.generate(10, (index) => false);
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
          "COURSES",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Center(
          child: Text(
            "QIU",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
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
        width: Media.size.width,
        height: Media.size.height,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            height: Media.size.height * .7,
            width: Media.size.width * .9,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(242, 250, 255, .63),
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: ListView.builder(
              itemCount: user.courses.length,
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 7),
                        height: Media.size.height * .7 * .11,
                        width: Media.size.width * .9 * .9,
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: (v[index] == true)
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
                            Text(
                              user.courses[index].Name,
                            ),
                            IconButton(
                              icon: Icon(
                                (v[index] == true)
                                    ? FontAwesomeIcons.angleDown
                                    : FontAwesomeIcons.angleRight,
                              ),
                              onPressed: () {
                                setState(() {
                                  v[index] = !v[index];
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      (v[index] == true)
                          ? Container(
                              height: Media.size.height * .7 * .3,
                              width: Media.size.width * .9 * .9,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 70),
                                height: 200,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Assignments: ",
                                        ),
                                        Text(user
                                            .courses[index].assignments.length
                                            .toString())
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Mark: ",
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          user.courses[index].Mark.toString(),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "progress: ",
                                          textAlign: TextAlign.start,
                                        ),
                                        Consumer<User>(
                                          builder: (BuildContext context, value,
                                              Widget? child) {
                                            return Text(
                                              user.courses[index].progress
                                                      .toString() +
                                                  "%",
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Credit: ",
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          user.courses[index].Credit.toString(),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
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
                                            builder: (context) => EditCourse(
                                              index: index,
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text("View Course"),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(124, 131, 253, 1),
        selectedItemColor: Colors.amber,
        currentIndex: 1,
        onTap: (val) {
          if (val == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LProfile(),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.graduationCap,
            ),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: "Course",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: "Groups",
          )
        ],
      ),
    );
  }
}
