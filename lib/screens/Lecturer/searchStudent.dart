import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'GradeStudentProfile.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../Providers/User.dart';
import '../../../models/Course.dart';

class SearchS extends StatefulWidget {
  const SearchS({Key? key}) : super(key: key);

  @override
  State<SearchS> createState() => _SearchSState();
}

class _SearchSState extends State<SearchS> {
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
        leading: IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          },
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
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
                    await user.searchStudents(value).then((value) {
                      setState(() {
                        isLoading = false;
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
              const SizedBox(
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
                                // users should be changed to user.suggestions[index][type] later;

                                final url =
                                    'https://class-note-collector-6bbcd-default-rtdb.firebaseio.com/users/Student/${user.suggestions[index]['id']}.json';

                                final response = await http.get(
                                  Uri.parse(url),
                                );
                                var wantedCourse;

                                var data = json.decode(response.body)
                                    as Map<dynamic, dynamic>;
                                print(data);
                                var cd = data['courses'];
                                cd.forEach((id, value) {
                                  user.courses.forEach((element) {
                                    if (id == element.id) {
                                      wantedCourse = {
                                        'owner': user.suggestions[index]['id'],
                                        'id': id,
                                        'mark': value['mark'],
                                        'name': value['name'],
                                      };
                                    }
                                  });
                                });

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditUser(
                                      data: data,
                                      wantedCourse: wantedCourse,
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
    );
  }
}
