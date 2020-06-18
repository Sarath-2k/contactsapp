import 'package:contactsapp/loginState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: DatabaseService().contactssnap,
      child: MaterialApp(
        home: First(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
