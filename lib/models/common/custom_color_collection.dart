import 'dart:collection';

import 'package:flutter/material.dart';

import 'custom_color.dart';

class CustomColorCollection {
  final List<CustomColor> _colors = [
    CustomColor(
      id: 'blueAccent',
      color: Colors.blueAccent,
    ),
    CustomColor(
      id: 'orange',
      color: Colors.orange,
    ),
    CustomColor(
      id: 'redAccent',
      color: Colors.redAccent,
    ),
    CustomColor(
      id: 'lightGreen',
      color: Colors.lightGreen,
    ),
    CustomColor(
      id: 'deepOrange',
      color: Colors.deepOrange,
    ),
    CustomColor(
      id: 'yellowAccent',
      color: Colors.yellowAccent,
    ),
  ];

  UnmodifiableListView<CustomColor> get colors => UnmodifiableListView(_colors);

  CustomColor findColorById(id) {
    return _colors.firstWhere((customColor) => customColor.id == id);
  }
}
