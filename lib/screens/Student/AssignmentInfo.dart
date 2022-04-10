import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../Providers/User.dart';

class AssignmentInfo extends StatefulWidget {
  var asgi;
  var coursei;
  AssignmentInfo({required this.asgi, required this.coursei});

  @override
  State<AssignmentInfo> createState() => _AssignmentInfoState();
}

class _AssignmentInfoState extends State<AssignmentInfo> {
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
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          user.courses[widget.coursei].assignments[widget.asgi].title,
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
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            height: Media.size.height * .8,
            width: Media.size.width * .8,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(242, 250, 255, .63),
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Date:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user.courses[widget.coursei]
                                .assignments[widget.asgi].date
                                .toString(),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Percentage:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user.courses[widget.coursei]
                                .assignments[widget.asgi].Mark
                                .toString(),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Status:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          user.courses[widget.coursei].assignments[widget.asgi]
                                  .status
                              ? const Text("Done")
                              : const Text("Undone"),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(user.courses[widget.coursei]
                      .assignments[widget.asgi].Content),
                ),
                Checkbox(
                  value: user
                      .courses[widget.coursei].assignments[widget.asgi].status,
                  onChanged: (bool? newValue) {
                    setState(() {
                      user.updateAssignmentStatus(
                          assignmentIndex: widget.asgi,
                          courseIndex: widget.coursei,
                          newStatus: newValue ?? false);
                      user.notifystatus(widget.coursei, widget.asgi, newValue);

                      user.updateCourseProgress(widget.coursei);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
