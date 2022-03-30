import 'package:flutter/material.dart';
import 'package:fyp/models/Admin.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Providers/User.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Admin a = Admin(
      Name: 'Name', Email: 'Email', Password: 'Password', Id: 0, Type: 'Type');
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
          "PROFILE",
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
        width: Media.size.width,
        height: Media.size.height,
        child: Column(
          children: [
            SizedBox(
              height: Media.size.height * .02,
            ),
            SizedBox(
              width: Media.size.width,
              height: Media.size.height * .25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(157, 163, 255, 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(200),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "Name: ${user.Name}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        "ID:",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Media.size.height * .02,
            ),
            SizedBox(
              height: Media.size.height * .2,
              width: Media.size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: Media.size.height * .2 * .9,
                    width: Media.size.width * .4,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [],
                    ),
                  ),
                  Container(
                    height: Media.size.height * .2 * .9,
                    width: Media.size.width * .4,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Media.size.height * .03,
            ),
            Container(
              height: Media.size.height * .2,
              width: Media.size.width * .8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text("C++"),
                  Slider(
                    min: 0,
                    max: 100,
                    value: 50,
                    onChanged: null,
                    inactiveColor: Colors.purple,
                    thumbColor: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(124, 131, 253, 1),
        selectedItemColor: Colors.amber,
        currentIndex: 0,
        onTap: (val) {},
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.person,
            ),
            label: "haa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: "haa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "haa",
          )
        ],
      ),
    );
  }
}
