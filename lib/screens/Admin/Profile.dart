import 'package:flutter/material.dart';
import 'package:fyp/models/Admin.dart';

import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Providers/User.dart';
import '../Login.dart';
import 'editCourses.dart';
import 'editUser/searchUser.dart';

class AProfile extends StatefulWidget {
  AProfile({Key? key}) : super(key: key);

  @override
  State<AProfile> createState() => _ProfileState();
}

class _ProfileState extends State<AProfile> {
  Admin a = Admin(
      Name: 'Name', Email: 'Email', Password: 'Password', Id: 0, Type: 'Type');
  @override
  Widget build(BuildContext context) {
    final Media = MediaQuery.of(context);
    final user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 231, 244, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(124, 131, 253, 1),
        centerTitle: true,
        title: const Text(
          "PROFILE",
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
            child: IconButton(
              onPressed: () {
                user.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              icon: const Icon(
                FontAwesomeIcons.arrowRightFromBracket,
                color: Color.fromARGB(255, 194, 58, 58),
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: Media.size.width,
        height: Media.size.height,
        child: Column(
          children: [
            SizedBox(
              height: Media.size.height * .02,
            ),
            SizedBox(
              width: Media.size.width,
              height: Media.size.height * .27,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(157, 163, 255, 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(200),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "Name: ${user.Name}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        "ID: ${user.id}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Media.size.height * .02,
            ),
            SizedBox(
              height: Media.size.height * .2,
              width: Media.size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: Media.size.height * .2 * .9,
                    width: Media.size.width * .4,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(FontAwesomeIcons.graduationCap),
                        Text(user.numberofCourses.toString()),
                        const Text("Credits")
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Search(),
                        ),
                      );
                    },
                    child: Container(
                      height: Media.size.height * .2 * .9,
                      width: Media.size.width * .4,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.timeline),
                          Text(user.numberofStudents.toString()),
                          const Text("Students")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Media.size.height * .03,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(124, 131, 253, 1),
        selectedItemColor: Colors.amber,
        currentIndex: 0,
        onTap: (val) async {
          if (val == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EditCourses(),
              ),
            );
          }
          if (val == 2) {}
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
