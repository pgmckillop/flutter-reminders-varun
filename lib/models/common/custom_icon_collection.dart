import 'dart:collection';
import 'custom_icon.dart';
//import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomIconCollection {
  final List<CustomIcon> _icons = [
    CustomIcon(id: 'bars', icon: CupertinoIcons.bars),
    CustomIcon(id: 'alarm', icon: CupertinoIcons.alarm),
    CustomIcon(id: 'airplane', icon: CupertinoIcons.airplane),
    CustomIcon(id: 'calendar', icon: CupertinoIcons.calendar_today),
    CustomIcon(id: 'waveform', icon: CupertinoIcons.waveform_path),
    CustomIcon(id: 'person', icon: CupertinoIcons.person),
  ];

  UnmodifiableListView<CustomIcon> get icons => UnmodifiableListView(_icons);

  CustomIcon findIconById(id) {
    return _icons.firstWhere((customIcon) => customIcon.id == id);
  }
}
