import 'package:flutter/material.dart';

final boldstyle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w900,
    color: Colors.black,
    fontSize: 15);
final opacityStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    color: Color.fromARGB(255, 193, 193, 193),
    fontSize: 12);
final btntext = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontSize: 14);
final contTextMain = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: 13);
final contText = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    color: Color(0xffFF9500),
    fontSize: 14);

final txtFieldStyle = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
  hintStyle: opacityStyle.copyWith(color: Color(0xffC1C1C1)),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(width: 1, color: Color(0xffF1F1F1)),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(width: 1, color: Color(0xffF1F1F1)),
  ),
);
