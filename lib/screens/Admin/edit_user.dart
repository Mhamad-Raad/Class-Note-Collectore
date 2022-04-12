import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../Providers/User.dart';

class EditUser extends StatefulWidget {
  var data;
  var courses;
  EditUser({Key? key, required this.data, required this.courses})
      : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
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
        height: Media.size.height * 2,
        width: Media.size.width,
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
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please insert you Password";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(124, 131, 254, 1),
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please insert you Password";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(124, 131, 254, 1),
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please insert you Password";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(124, 131, 254, 1),
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: Media.size.width * .7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Courses"),
                        ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Icon(Icons.add),
                              Text("ADD"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Media.size.width,
                    height: 2,
                    color: Colors.grey[400],
                  ),
                  SizedBox(
                    height: Media.size.height * .1,
                    child: ListView.builder(
                      itemCount: widget.courses.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Text("${widget.courses[index].Name}"),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
