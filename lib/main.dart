import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:fyp/Providers/User.dart';

import 'package:provider/provider.dart';

import './screens/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await Firebase.initializeApp();

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
          create: (_) => User(Name: "", id: '', type: "", Email: ""),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );
  }
}
