import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp/models/Course.dart';
import 'package:provider/provider.dart';

import '../../../Providers/User.dart';

class EditUser extends StatefulWidget {
  var data;
  List courses;
  var userid;
  var userType;
  EditUser({
    Key? key,
    required this.data,
    required this.courses,
    required this.userid,
    required this.userType,
  }) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  var addLoading = false;
  var loading = false;
  late Map data;
  late List<Map> dataname;
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var cgpaController = TextEditingController();

  @override
  void initState() {
    cgpaController.text = widget.data['cgpa'].toString();
    passwordController.text = widget.data['password'];
    nameController.text = widget.data['name'];
    // TODO: implement initState
    super.initState();
  }

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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Colors.black,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 10,
            ),
            child: IconButton(
              onPressed: () async {
                try {
                  await user.updateUsernameAndCgpaAndPassword(
                      type: widget.userType,
                      name: nameController.text,
                      passowrd: passwordController.text,
                      cgpa: cgpaController.text,
                      userid: widget.userid);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      onVisible: () {
                        setState(() {
                          loading = false;
                        });
                      },
                      content: const Text('Upated'),
                      duration: const Duration(seconds: 1),
                      action: SnackBarAction(
                        label: 'ok',
                        onPressed: () {
                          setState(() {
                            loading = false;
                          });
                          ScaffoldMessenger.of(context).clearSnackBars();
                        },
                      ),
                    ),
                  );
                } catch (e) {
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      onVisible: () {
                        setState(() {
                          loading = false;
                        });
                      },
                      content: const Text(
                          'Something went wrong please try again later'),
                      duration: const Duration(seconds: 1),
                      action: SnackBarAction(
                        label: 'ok',
                        onPressed: () {
                          setState(() {
                            loading = false;
                          });
                          ScaffoldMessenger.of(context).clearSnackBars();
                        },
                      ),
                    ),
                  );
                }
              },
              icon: const Icon(
                FontAwesomeIcons.floppyDisk,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: Media.size.height * 2,
        width: Media.size.width,
        child: SingleChildScrollView(
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
                      height: 10,
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        label: const Text("Password"),
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
                    widget.userType == 'Lecturer'
                        ? Container()
                        : TextField(
                            keyboardType: TextInputType.number,
                            controller: cgpaController,
                            decoration: InputDecoration(
                              label: const Text("CGPA"),
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
                          addLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () async {
                                    dataname = [];
                                    data = {};
                                    setState(() {
                                      addLoading = true;
                                    });
                                    Object? chosen = "Courses";
                                    var te = await user.getAllCourses();
                                    setState(() {
                                      try {
                                        bool Have = false;
                                        data = te;
                                        if (data.isNotEmpty) {
                                          data.forEach((key, value) {
                                            Have = false;
                                            String temp = value['name'];
                                            for (int index = 0;
                                                index < widget.courses.length;
                                                index++) {
                                              if (temp ==
                                                  widget.courses[index].Name) {
                                                Have = true;
                                              }
                                            }
                                            if (!Have) {
                                              dataname.add({
                                                'id': key,
                                                'name': value["name"],
                                                'credits': value['credits'],
                                                'progress': value['progress'],
                                                'mark': value['mark'],
                                                'weeks': value['weeks'],
                                                'chosen': false
                                              });
                                            }
                                          });
                                        }
                                        addLoading = false;
                                        if (dataname.isNotEmpty) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return StatefulBuilder(
                                                builder: (context, setState) {
                                                  return AlertDialog(
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          for (int i = 0;
                                                              i <
                                                                  dataname
                                                                      .length;
                                                              i++) {
                                                            if (dataname[i][
                                                                    'chosen'] ==
                                                                true) {
                                                              await user
                                                                  .addCourseToUser(
                                                                widget.userid
                                                                    .toString(),
                                                                dataname[i],
                                                                widget.userType,
                                                              );
                                                              super
                                                                  .setState(() {
                                                                widget.courses
                                                                    .add(
                                                                  Course(
                                                                    Name: dataname[
                                                                            i][
                                                                        'name'],
                                                                    Credit: int.parse(
                                                                        dataname[i]
                                                                            [
                                                                            'credits']),
                                                                    Mark: dataname[i]
                                                                            [
                                                                            'mark'] +
                                                                        0.0,
                                                                    id: dataname[
                                                                            i]
                                                                        ['id'],
                                                                  ),
                                                                );
                                                              });
                                                            }
                                                          }
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          "Confirm",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                      )
                                                    ],
                                                    title: const Text(
                                                      "Courses",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    content: SizedBox(
                                                      width: 100,
                                                      height: 100,
                                                      child: ListView.builder(
                                                        itemCount:
                                                            dataname.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                index) {
                                                          return ListTile(
                                                            leading: Text(
                                                              dataname[index]
                                                                  ['name'],
                                                            ),
                                                            trailing: Checkbox(
                                                              onChanged: (bool?
                                                                  value) {
                                                                setState(() {
                                                                  dataname[
                                                                          index]
                                                                      [
                                                                      'chosen'] = !dataname[
                                                                          index]
                                                                      [
                                                                      'chosen'];
                                                                });
                                                              },
                                                              value: dataname[
                                                                      index]
                                                                  ['chosen'],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        } else {
                                          addLoading = false;
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text("Confirm"),
                                                  )
                                                ],
                                                title:
                                                    const Text('Not available'),
                                                content: const SizedBox(
                                                  height: 100,
                                                  width: 100,
                                                  child: Text(
                                                      'The user already has all the courses'),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      } catch (e) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Confirm"),
                                                )
                                              ],
                                              title: const Text('Failed'),
                                              content: const SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Text(
                                                    'something went wrong'),
                                              ),
                                            );
                                          },
                                        );

                                        setState(() {
                                          addLoading = false;
                                        });
                                        print(e);
                                      }
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                      height: Media.size.height * .15,
                      child: ListView.builder(
                        itemCount: widget.courses.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Text("${widget.courses[index].Name}"),
                            trailing: loading
                                ? const CircularProgressIndicator()
                                : IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      try {
                                        await user.deleteuserCourse(
                                          widget.userType,
                                          widget.courses[index].id,
                                          index,
                                          widget.userid,
                                        );
                                        setState(() {
                                          loading = false;
                                          widget.courses.removeAt(index);
                                        });

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            onVisible: () {
                                              setState(() {
                                                loading = false;
                                              });
                                            },
                                            content: const Text(
                                                'Deleted successfuly'),
                                            action: SnackBarAction(
                                              label: 'ok',
                                              onPressed: () {
                                                setState(() {
                                                  loading = false;
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .clearSnackBars();
                                              },
                                            ),
                                          ),
                                        );
                                      } catch (error) {
                                        // print(error);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            onVisible: () {
                                              setState(() {
                                                loading = false;
                                              });
                                            },
                                            content: const Text(
                                                'Failed to delete the course'),
                                            action: SnackBarAction(
                                              label: 'ok',
                                              onPressed: () {
                                                setState(() {
                                                  loading = false;
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .clearSnackBars();
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
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
      ),
    );
  }
}
