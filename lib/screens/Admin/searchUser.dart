import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/screens/Admin/Admin_Add_User.dart';
import 'package:fyp/screens/Admin/edit_user.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../Providers/User.dart';
import '../../models/Course.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var isLoading = false;
  var searchController = TextEditingController();
  var amb = false;
  @override
  Widget build(BuildContext context) {
    amb = false;
    final Media = MediaQuery.of(context);
    final user = Provider.of<User>(context, listen: true);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 231, 244, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(124, 131, 253, 1),
        centerTitle: true,
        title: const Text(
          "Edit/Remove Users",
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
                    });

                    print(user.suggestions);
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
                          color: Color.fromARGB(255, 111, 112, 153),
                          width: 2.0),
                    ),
                    hintText: 'Search',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        height: Media.size.height * .8,
                        width: Media.size.width * .8,
                        child: ListView.builder(
                          itemCount: user.suggestions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(
                                user.suggestions[index]['name'],
                              ),
                              trailing: Text(
                                user.suggestions[index]['type'],
                              ),
                              onTap: () async {
                                List courses = [];
                                // users should be changed to user.suggestions[index][type] later;
                                final url =
                                    'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/${user.suggestions[index]['id']}.json';
                                final response = await http.get(Uri.parse(url));

                                var data = json.decode(response.body)
                                    as Map<dynamic, dynamic>;

                                var coursesdata =
                                    data['courses'] as Map<dynamic, dynamic>;
                                coursesdata.forEach((key, value) {
                                  var course = Course(
                                    Credit: value['credits'],
                                    Name: value['name'],
                                    id: key,
                                    Mark: value['mark'],
                                  );

                                  courses.add(course);
                                });
                                print(data);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditUser(
                                      data: data,
                                      courses: courses,
                                      userid: user.suggestions[index]['id'],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(124, 131, 253, 1),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddUser(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
