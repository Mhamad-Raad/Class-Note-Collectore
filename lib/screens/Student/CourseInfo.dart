import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/screens/Student/AssignmentInfo.dart';
import 'package:fyp/screens/Student/CourseDetails.dart';
import 'package:provider/provider.dart';

import '../../Providers/User.dart';
import 'profile.dart';

class CourseInfo extends StatelessWidget {
  late int index;
  CourseInfo({Key? key, required this.index}) : super(key: key);

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
          user.courses[index].Name,
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
                      user.courses[index].Mark.toString(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Media.size.height * .9,
                width: Media.size.width,
                child: ListView.builder(
                  itemCount: user.courses[index].weeks,
                  itemBuilder: (BuildContext context, int i) {
                    if (user.courses[index].assignments[i].date == i + 1) {
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
                                  user.courses[index].assignments[i].title,
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
                                          coursei: index,
                                        ),
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
                    return Container();
                  },
                ),
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
