import 'dart:io';

import 'package:contactsapp/HomeScreen.dart';
import 'package:contactsapp/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  dynamic value;
  //   // int valueTemp;
  //   // final prefs = SharedPreferences.getInstance();
  //   // final key = 'loginState';


  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      final key = 'loginState';
      value = sharedPreferences.getInt(key) ?? 0;
      print(value);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = value;
    if (user == 1) {
      return HomeScreen();
    } else {
      return LoginPage();
    }
  }
}
