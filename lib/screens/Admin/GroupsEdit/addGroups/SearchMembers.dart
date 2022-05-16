import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/User.dart';
import '../../Profile.dart';

class AddMemebers extends StatefulWidget {
  var courseData;

  AddMemebers({Key? key, required this.courseData}) : super(key: key);

  @override
  State<AddMemebers> createState() => _AddMemebersState();
}

class _AddMemebersState extends State<AddMemebers> {
  Map lecturerData = {};
  bool studentSelected = false;
  bool lecturerSelected = false;
  List<Map> studentData = [];
  var isLoading = false;
  var searchController = TextEditingController();
  int lecturerCount = 0;
  List<bool> selectedUsers = [];
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
        leading: IconButton(
          onPressed: () {
            user.suggestions = [];
            Navigator.pop(context);
          },
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
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
        height: Media.size.height,
        width: Media.size.width,
        child: Column(
          children: [
            SizedBox(
              height: Media.size.height * .05,
            ),
            SizedBox(
              // color: Colors.amber,
              height: Media.size.height * .1,
              width: Media.size.width * .85,
              child: TextField(
                onChanged: (value) async {
                  setState(() {
                    isLoading = true;
                  });
                  await user.searchUsers(value).then((value) {
                    setState(() {
                      isLoading = false;
                    });
                    setState(() {
                      selectedUsers =
                          List.filled(user.suggestions.length, false);
                    });
                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await user
                          .searchUsers(searchController.text)
                          .then((value) {
                        setState(() {
                          isLoading = false;
                        });
                        setState(() {
                          selectedUsers =
                              List.filled(user.suggestions.length, false);
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.search_rounded,
                      size: 32,
                      color: Color.fromARGB(255, 111, 112, 153),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(124, 131, 253, 1), width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 111, 112, 153), width: 2.0),
                  ),
                  hintText: 'Search',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            isLoading
                ? const CircularProgressIndicator()
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      itemCount: user.suggestions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            user.suggestions[index]['name'] ?? 'user',
                          ),
                          subtitle: Text(
                            user.suggestions[index]['type'] ?? "User",
                          ),
                          trailing: Checkbox(
                            onChanged: (value) {
                              if (user.suggestions[index]['type'] ==
                                  'Lecturer') {
                                if (lecturerCount >= 1 &&
                                    selectedUsers[index] == false) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'you can only select one Lecturer'),
                                    ),
                                  );
                                } else {
                                  lecturerData = {
                                    'name': user.suggestions[index]['name'],
                                    'id': user.suggestions[index]['id'],
                                  };
                                  setState(() {
                                    selectedUsers[index] =
                                        !selectedUsers[index];
                                  });
                                  if (selectedUsers[index] == false) {
                                    setState(() {
                                      lecturerSelected = false;
                                      lecturerData = {};
                                      lecturerCount--;
                                    });
                                  } else {
                                    setState(() {
                                      lecturerCount++;
                                      lecturerSelected = true;
                                    });
                                  }
                                }
                              } else {
                                setState(() {
                                  selectedUsers[index] = !selectedUsers[index];
                                });
                                if (selectedUsers[index] == true) {
                                  setState(() {
                                    studentSelected = true;
                                    studentData.add({
                                      'name': user.suggestions[index]['name'],
                                      'id': user.suggestions[index]['id'],
                                    });
                                  });
                                } else {
                                  setState(() {
                                    studentSelected = false;
                                    studentData.removeWhere((element) =>
                                        user.suggestions[index]['id'] ==
                                        element['id']);
                                  });
                                }
                              }
                            },
                            value: selectedUsers[index],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lecturerSelected && studentSelected
            ? const Color.fromRGBO(124, 131, 253, 1)
            : const Color.fromARGB(255, 134, 135, 155),
        onPressed: lecturerSelected && studentSelected
            ? () async {
                user.suggestions = [];
                await user.addGroups(
                    widget.courseData, lecturerData, studentData);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AProfile()),
                );
              }
            : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Must Contain one lecturer and at least one student'),
                  ),
                );
              },
        child: const Icon(Icons.add),
      ),
    );
  }
}
