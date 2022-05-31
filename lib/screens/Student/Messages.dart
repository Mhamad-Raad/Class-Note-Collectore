import 'dart:async';
import 'dart:collection';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../Providers/User.dart';

class ClassMessages extends StatefulWidget {
  var groupTitle, groupId;
  ClassMessages({Key? key, required this.groupTitle, required this.groupId})
      : super(key: key);

  @override
  State<ClassMessages> createState() => _ClassMessagesState();
}

class _ClassMessagesState extends State<ClassMessages> {
  late var messages;
  var _controller;
  var max = 0;

  @override
  void initState() {
    messages = FirebaseDatabase.instance
        .ref()
        .child('groups/${widget.groupId}/messages')
        .onValue;
    // TODO: implement initState
    super.initState();
  }

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
              child: StreamBuilder<DatabaseEvent>(
                stream: messages,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    return FirebaseAnimatedList(
                      query: FirebaseDatabase.instance
                          .ref()
                          .child('groups/${widget.groupId}/messages')
                          .orderByChild("time"),
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        var data = snapshot.value as Map;

                        return Row(
                          mainAxisAlignment: data['ownerid'] == user.id
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: data['ownerid'] == user.id
                                    ? Colors.grey[300]
                                    : const Color.fromRGBO(124, 131, 253, 1),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: data['ownerid'] == user.id
                                      ? Radius.circular(10)
                                      : Radius.circular(1),
                                  bottomRight: data['ownerid'] == user.id
                                      ? Radius.circular(0)
                                      : Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: data['ownerid'] == user.id
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      data['ownername'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    data['content'],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  suffixIcon: IconTheme(
                    data: const IconThemeData(
                      color: Color.fromARGB(255, 86, 92, 198),
                    ),
                    child: IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        user.addMessage(
                          widget.groupId,
                          {
                            "content": messageController.text,
                            'ownerid': user.id,
                            'ownername': user.Name,
                          },
                        );
                        messageController.clear();
                      },
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
