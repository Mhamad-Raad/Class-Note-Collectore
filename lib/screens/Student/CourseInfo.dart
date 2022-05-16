import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/screens/Student/AssignmentInfo.dart';
import 'package:fyp/screens/Student/CourseDetails.dart';
import 'package:provider/provider.dart';

import '../../Providers/User.dart';
import 'profile.dart';

class CourseInfo extends StatefulWidget {
  late int index;
  CourseInfo({Key? key, required this.index}) : super(key: key);

  @override
  State<CourseInfo> createState() => _CourseInfoState();
}

class _CourseInfoState extends State<CourseInfo> {
  List v = List.generate(10, (index) => false);
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CoursesDetails(),
              ),
            );
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
                height: Media.size.height * .1,
                width: Media.size.width * .5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Mark: "),
                    Text(
                      user.courses[widget.index].Mark.toString(),
                    ),
                  ],
                ),
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
                                              ),
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
                                    itemCount: user.courses[widget.index]
                                        .assignments.length,
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
                                              onPressed: () {},
                                              child: const Text("View Course"),
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
              ),
            ],
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
                builder: (context) => const Profile(),
              ),
            );
          } else if (val == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CoursesDetails(),
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
