import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  TextEditingController emlController = TextEditingController();
  TextEditingController pssController = TextEditingController();
  addUser(email, pass) {
    var url =
        'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users.json';
    http.post(Uri.parse(url),
        body: json.encode(
            {'email': emlController.text, 'password': pssController.text}));
  }

  @override
  Widget build(BuildContext context) {
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
                      // SizedBox(
                      //   height: mediaQuery.size.height * .3 * .2,
                      // ),
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
                height: mediaQuery.size.height * .1,
              ),
              SizedBox(
                width: mediaQuery.size.width * .8,
                height: mediaQuery.size.height * .471,
                child: Column(
                  children: [
                    TextField(
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
                    TextField(
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
                      width: mediaQuery.size.width * .4,
                      height: mediaQuery.size.height * .2 * .5,
                      child: dropDown(),
                    ),
                    SizedBox(
                      height: mediaQuery.size.height * .1 * .5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addUser(emlController.text, pssController.text);
                      },
                      child: const Text("Sign in"),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                          const Size(150, 50),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(124, 131, 254, 1),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: mediaQuery.size.height * .09,
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

class dropDown extends StatefulWidget {
  var chosen = "Student";
  dropDown({Key? key}) : super(key: key);

  @override
  State<dropDown> createState() => _dropDownState();
}

class _dropDownState extends State<dropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          ),
        ),
        style: const TextStyle(fontSize: 16, color: Colors.black),
        value: widget.chosen,
        items: <String>["Student", "Admin", "Lecturer"]
            .map<DropdownMenuItem<String>>((String v) {
          return DropdownMenuItem<String>(
            value: v,
            child: Text(v),
          );
        }).toList(),
        onChanged: (String? a) {
          setState(() {
            widget.chosen = a ?? "Student";
          });
        });
  }
}
