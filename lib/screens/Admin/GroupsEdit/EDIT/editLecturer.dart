import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/User.dart';

class editLecturer extends StatefulWidget {
  var gid;
  editLecturer({Key? key, required this.gid}) : super(key: key);

  @override
  State<editLecturer> createState() => _editLecturerState();
}

class _editLecturerState extends State<editLecturer> {
  var courseLecturer;
  var isLoading = false;
  List<bool> selectedUsers = [];
  int count = 0;
  var searchController = TextEditingController();
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
                    selectedUsers = List.filled(user.suggestions.length, false);
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
                      });
                      selectedUsers =
                          List.filled(user.suggestions.length, false);
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
                : Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                        itemCount: user.suggestions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return user.suggestions[index]['type'] == 'Lecturer'
                              ? ListTile(
                                  title: Text(
                                    user.suggestions[index]['name'] ?? 'user',
                                  ),
                                  subtitle: Text(
                                    user.suggestions[index]['type'] ?? "User",
                                  ),
                                  trailing: Checkbox(
                                    onChanged: (value) {
                                      if (value == true) {
                                        if (count > 0) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'you can only select one Lecturer'),
                                            ),
                                          );
                                        } else {
                                          setState(() {
                                            selectedUsers[index] =
                                                !selectedUsers[index];
                                          });
                                          courseLecturer = {
                                            'name': user.suggestions[index]
                                                ['name'],
                                            'id': user.suggestions[index]['id'],
                                          };

                                          count++;
                                        }
                                      } else if (value == false) {
                                        setState(() {
                                          selectedUsers[index] =
                                              !selectedUsers[index];
                                        });
                                        count--;
                                      }
                                   
                                    },
                                    value: selectedUsers[index],
                                  ),
                                )
                              : Container();
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: count == 0
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select one Lecturer'),
                  ),
                );
              }
            : () async {
                await user.updateGroupLecturer(widget.gid, courseLecturer);
                Navigator.pop(context);
              },
        backgroundColor: const Color.fromRGBO(124, 131, 253, 1),
        child: const Icon(Icons.next_plan),
      ),
    );
  }
}
