import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Providers/User.dart';

class ClassMessages extends StatefulWidget {
  var groupTitle, groupId;
  ClassMessages({Key? key, required this.groupTitle, required this.groupId})
      : super(key: key);

  @override
  State<ClassMessages> createState() => _ClassMessagesState();
}

class _ClassMessagesState extends State<ClassMessages> {
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: true);
    final Media = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 231, 244, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(124, 131, 253, 1),
        centerTitle: true,
        title: Text(
          widget.groupTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.angleLeft),
          onPressed: () {
            Navigator.pop(context);
          },
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
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile();
                },
              ),
            ), //fix this

            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              // margin: EdgeInsets.only(bottom: ),
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  suffixIcon: IconTheme(
                    data: const IconThemeData(
                      color: Color.fromARGB(255, 86, 92, 198),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send),
                    ),
                  ),
                  filled: true,
                  hintText: "Message",
                  fillColor: const Color.fromARGB(255, 147, 150, 210),
                  border: const UnderlineInputBorder(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
