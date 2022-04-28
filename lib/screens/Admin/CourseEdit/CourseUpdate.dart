import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../Providers/User.dart';

class CourseInfoUpdate extends StatefulWidget {
  var course;
  CourseInfoUpdate({Key? key, required this.course}) : super(key: key);

  @override
  State<CourseInfoUpdate> createState() => _CourseInfoUpdateState();
}

class _CourseInfoUpdateState extends State<CourseInfoUpdate> {
  final creditController = TextEditingController();
  final idController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.course['name'];
    creditController.text = widget.course['credits'].toString();
    idController.text = widget.course['id'].toString();

    // TODO: implement initState
    super.initState();
  }

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
          widget.course['name'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(FontAwesomeIcons.arrowLeft),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async {
                await user.UpdatecourseNameAndCredits(
                  widget.course['id'],
                  nameController.text,
                  creditController.text,
                );
                setState(() {
                  widget.course['name'] = nameController.text;
                  widget.course['credit'] = creditController.text;
                  widget.course['id'] = idController.text;
                });
              },
              icon: const Icon(
                FontAwesomeIcons.floppyDisk,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        height: Media.size.height,
        width: Media.size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  label: const Text("Name"),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(124, 131, 254, 1),
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: creditController,
                decoration: InputDecoration(
                  label: const Text("Credits"),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(124, 131, 254, 1),
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
