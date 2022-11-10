import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_system/Register.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Register(),
    theme: ThemeData(fontFamily: 'Poppins'),
  ));
}
