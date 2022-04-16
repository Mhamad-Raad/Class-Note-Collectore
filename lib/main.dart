import 'package:flutter/material.dart';
import 'package:fyp/Providers/User.dart';
import 'package:fyp/screens/Admin/Admin_Add_User.dart';
import 'package:fyp/screens/Admin/searchUser.dart';
import 'package:fyp/screens/Student/profile.dart';
import 'package:provider/provider.dart';

import './screens/Login.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(
    const MyAPP(),
  );
}

class MyAPP extends StatefulWidget {
  const MyAPP({Key? key}) : super(key: key);

  @override
  State<MyAPP> createState() => _MyAPPState();
}

class _MyAPPState extends State<MyAPP> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<User>(
          create: (_) => User(Name: "", id: "0", type: "", Email: ""),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );
  }
}
