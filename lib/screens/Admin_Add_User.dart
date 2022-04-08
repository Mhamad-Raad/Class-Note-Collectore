import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Providers/User.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _formKey = GlobalKey<FormState>();
  var emlController = TextEditingController();
  final passController = TextEditingController();
  var nameController = TextEditingController();
  final idController = TextEditingController();
  var isLoadingStudent = false;
  var isLoadingLecturer = false;
  var chosen = 'Student';
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
          "ADD User",
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
            margin: const EdgeInsets.only(
              right: 10,
            ),
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
        height: Media.size.height,
        width: Media.size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: Media.size.height * .15,
                width: Media.size.width,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: const Color.fromRGBO(124, 131, 253, 1),
                      ),
                      child: DropdownButton(
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                        value: chosen,
                        items: <String>["Student", "Lecturer"]
                            .map<DropdownMenuItem<String>>((String v) {
                          return DropdownMenuItem<String>(
                            value: v,
                            child: Text(v),
                          );
                        }).toList(),
                        onChanged: (String? a) {
                          setState(
                            () {
                              chosen = a.toString();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              chosen == 'Student'
                  ? Form(
                      key: _formKey,
                      child: SizedBox(
                        width: Media.size.width * .8,
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
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "please insert you Password";
                                  }
                                },
                                controller: passController,
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
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "please insert you Password";
                                  }
                                },
                                controller: nameController,
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: "Name",
                                  hintText: "Name",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(124, 131, 254, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "please insert you Password";
                                  }
                                },
                                controller: idController,
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: "ID",
                                  hintText: "ID",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(124, 131, 254, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text("Submit"),
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Form(
                      key: _formKey,
                      child: SizedBox(
                        width: Media.size.width * .8,
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
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "please insert you Password";
                                  }
                                },
                                controller: passController,
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
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "please insert you Password";
                                  }
                                },
                                controller: nameController,
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: "Name",
                                  hintText: "Name",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(124, 131, 254, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "please insert you Password";
                                  }
                                },
                                controller: idController,
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: "ID",
                                  hintText: "ID",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(124, 131, 254, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "please insert you Password";
                                  }
                                },
                                controller: idController,
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: "Course",
                                  hintText: "Course",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(124, 131, 254, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              isLoadingStudent
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            isLoadingStudent = true;
                                          });

                                          user.addStudent().then((value) => {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content:
                                                        Text('Processing Data'),
                                                  ),
                                                )
                                              });
                                        } else if (!_formKey.currentState!
                                            .validate()) {
                                          return;
                                        }
                                      },
                                      child: const Text("Submit"),
                                      style: ButtonStyle(
                                        minimumSize:
                                            MaterialStateProperty.all<Size>(
                                          const Size(150, 50),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          const Color.fromRGBO(
                                              124, 131, 254, 1),
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                        ),
                                      ),
                                    ),
                              const SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
