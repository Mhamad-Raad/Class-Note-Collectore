import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/screens/Admin/GroupsEdit/addGroups/chooseCourse.dart';
import 'package:provider/provider.dart';

import '../../../Providers/User.dart';
import '../Profile.dart';

class Groups extends StatefulWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  bool delete = false;
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
        child: Column(
          children: [
            SizedBox(
              height: Media.size.height * .07,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(120, 50),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 51, 194, 170),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChooseCurse(
                          numberOfCourses: user.allCourses.length,
                        ),
                      ),
                    );
                  },
                  child: const Text("Add Groups"),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(120, 50),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 220, 84, 59),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      delete = !delete;
                    });
                  },
                  child:
                      delete ? const Text("Done") : const Text("Delete Groups"),
                ),
              ],
            ),
            SizedBox(
              height: Media.size.height * .07,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: user.allCourses.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(124, 131, 253, 1),
        selectedItemColor: Colors.amber,
        currentIndex: 2,
        onTap: (val) {
          if (val == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AProfile(),
              ),
            );
          }

          if (val == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Groups(),
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
