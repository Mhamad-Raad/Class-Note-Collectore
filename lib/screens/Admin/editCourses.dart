import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/screens/Admin/editUser/searchUser.dart';
import 'Profile.dart';
import 'dart:math';

import 'package:provider/provider.dart';

import '../../Providers/User.dart';

class EditCourses extends StatefulWidget {
  const EditCourses({Key? key}) : super(key: key);

  @override
  State<EditCourses> createState() => _EditCoursesState();
}

class _EditCoursesState extends State<EditCourses> {
  bool delete = false;
  final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  final creditsCotnroller = TextEditingController();
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
        child: SingleChildScrollView(
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
                                        color:
                                            Color.fromARGB(255, 220, 84, 59)),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Random random = Random();
                                    int randomNumber = random.nextInt(10000);

                                    var course = {
                                      'name': nameController.text,
                                      'credits':
                                          int.parse(creditsCotnroller.text),
                                      'id': randomNumber,
                                      'weeks': 0,
                                      'progress': 100,
                                      'mark': 0
                                    };
                                    await user.addAcourse(course);
                                    setState(() {
                                      user.allCourses.add(course);
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
                              title: const Text('Add Course'),
                              content: SizedBox(
                                height: Media.size.height * .3,
                                child: Form(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "please insert you email";
                                            } else if (!value.contains('@')) {
                                              return 'Please input a valid email';
                                            }

                                            return null;
                                          },
                                          controller: nameController,
                                          decoration: InputDecoration(
                                            filled: true,
                                            labelText: "Name",
                                            hintText: "Course Name",
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
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "please insert you Password";
                                            }
                                          },
                                          controller: creditsCotnroller,
                                          decoration: InputDecoration(
                                            filled: true,
                                            labelText: "Credits",
                                            hintText: "Course Credits",
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
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        },
                      );
                    },
                    child: const Text("Add Courses"),
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
                    child: delete
                        ? const Text("Done")
                        : const Text("Delete Courses"),
                  ),
                ],
              ),
              SizedBox(
                height: Media.size.height * .07,
              ),
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
                  height: Media.size.height * .5,
                  width: Media.size.width * .9,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(242, 250, 255, .63),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: user.allCourses.length,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    user.allCourses[index]['name'],
                                  ),
                                  delete
                                      ? IconButton(
                                          onPressed: () async {
                                            await user.deleteAcourse(
                                              user.allCourses[index]['id'],
                                            );
                                            setState(() {
                                              user.allCourses.removeAt(index);
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        )
                                      : IconButton(
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
                                    height: Media.size.height * .4 * .3,
                                    width: Media.size.width * .9 * .9,
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
                                                "Credits: ",
                                              ),
                                              Text(user.allCourses[index]
                                                      ['credits']
                                                  .toString())
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "ID: ",
                                              ),
                                              Text(user.allCourses[index]['id']
                                                  .toString())
                                            ],
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
                builder: (context) => AProfile(),
              ),
            );
          }

          if (val == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Search(),
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
