import 'package:flutter/material.dart';

class Subject{
  String ? image;
  String ? text;

  Subject(this.image, this.text);
}
List<Subject>grid=[
  Subject("assets/grid/math.png", "Mathematics"),
  Subject("assets/grid/english.png", "English"),
  Subject("assets/grid/computer.png", "Computer"),
  Subject("assets/grid/science.png", "Science"),
  Subject("assets/grid/art.png", "Drawing"),
  Subject("assets/grid/iq.png", "IQ"),
];