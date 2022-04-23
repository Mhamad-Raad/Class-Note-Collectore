import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../Providers/User.dart';

class EditUser extends StatefulWidget {
  var data;
  var wantedCourse;

  EditUser({
    Key? key,
    required this.data,
    required this.wantedCourse,
  }) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  var addLoading = false;
  var loading = false;
  late Map data;

  var markController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Media = MediaQuery.of(context);
    final user = Provider.of<User>(context, listen: true);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 231, 244, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(124, 131, 253, 1),
        centerTitle: true,
        title: Text(
          widget.data['name'].toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Colors.black,
          ),
        ),
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
        height: Media.size.height * 2,
        width: Media.size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Media.size.height * .02,
              ),
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(157, 163, 255, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(200),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Media.size.width * .8,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Name:",
                        ),
                        Text(
                          widget.data['name'],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "CGPA:",
                        ),
                        Text(
                          widget.data['cgpa'].toString(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    widget.wantedCourse['mark'] -=
                                        double.parse(markController.text);
                                    user.UpdateGrade(
                                      widget.wantedCourse['id'],
                                      widget.wantedCourse['owner'],
                                      widget.wantedCourse['mark'],
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Substract",
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    widget.wantedCourse['mark'] +=
                                        double.parse(markController.text);
                                    user.UpdateGrade(
                                      widget.wantedCourse['id'],
                                      widget.wantedCourse['owner'],
                                      widget.wantedCourse['mark'],
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Add",
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                              title: const Text('Edit Grade'),
                              content: SizedBox(
                                height: Media.size.height * .3,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Text(
                                          'Current Grade is: ${widget.wantedCourse['mark']}'),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: TextField(
                                        controller: markController,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text("Grade"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
