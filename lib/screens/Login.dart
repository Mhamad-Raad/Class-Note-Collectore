import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp/Providers/User.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '.././screens/Student/profile.dart';
import 'Admin/CourseEdit/editCourses.dart';
import '.././screens/Lecturer/Profile.dart';
import 'Admin/Profile.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emlController = TextEditingController();

  TextEditingController pssController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  addUser(email, pass) {
    var url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users.json';
    http.post(Uri.parse(url),
        body: json.encode(
            {'email': emlController.text, 'password': pssController.text}));
  }

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 231, 244, 1),
      body: SizedBox(
        height: mediaQuery.size.height,
        width: mediaQuery.size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: mediaQuery.size.height * .2,
                width: mediaQuery.size.width,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(124, 131, 254, 1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Qaiwan International University",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: mediaQuery.size.height * .2 * .05,
                      ),
                      const Text(
                        "Elearning",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: mediaQuery.size.height * .07,
              ),
              SizedBox(
                width: mediaQuery.size.width * .8,
                height: mediaQuery.size.height * .6,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please insert you email";
                            } else if (!value.contains('@')) {
                              return 'Please input a valid email';
                            }

                            return null;
                          },
                          controller: emlController,
                          decoration: InputDecoration(
                            filled: true,
                            labelText: "Email",
                            hintText: "Email",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(124, 131, 254, 1),
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mediaQuery.size.height * .05 * .5,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please insert you Password";
                            }

                            return null;
                          },
                          obscureText: true,
                          controller: pssController,
                          decoration: InputDecoration(
                            filled: true,
                            labelText: "Password",
                            hintText: "Password",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(124, 131, 254, 1),
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mediaQuery.size.height * .1 * .5,
                        ),
                        SizedBox(
                          height: mediaQuery.size.height * .1 * .5,
                        ),
                        isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                child: const Text("Sign in"),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Processing Data'),
                                      ),
                                    );
                                  } else if (!_formKey.currentState!
                                      .validate()) {
                                    return;
                                  }
                                  setState(() {
                                    isLoading = true;
                                  });

                                  bool found = false;
                                  await user.Login(emlController.text,
                                          pssController.text)
                                      .then((value) => {
                                            found = value,
                                          });

                                  if (found) {
                                    await user.getAllCourses();

                                    setState(() {
                                      isLoading = false;
                                    });
                                    if (user.type == 'Admin') {
                                      user.getallGroups();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const EditCourses(),
                                        ),
                                      );
                                    } else if (user.type == 'Student') {
                                      await user.getCourses();
                                      await user.getGroups();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Profile(),
                                        ),
                                      );
                                    } else if (user.type == 'Lecturer') {
                                      await user.getCourses();
                                      await user.getGroups();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LProfile(),
                                        ),
                                      );
                                    } else if (user.type == 'Admin') {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AProfile(),
                                        ),
                                      );
                                    }
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    showDialog(
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Wrong user name or password"),
                                          actions: [
                                            ElevatedButton(
                                              child: const Text("OK"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        );
                                      },
                                      context: context,
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(150, 50),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    const Color.fromRGBO(124, 131, 254, 1),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: mediaQuery.size.width,
                height: mediaQuery.size.height * .139,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(124, 131, 254, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
