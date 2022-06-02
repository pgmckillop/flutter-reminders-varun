import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(int millisecondsFromEpoch) {
  return DateFormat.yMMMd().format(
    DateTime.fromMicrosecondsSinceEpoch(millisecondsFromEpoch),
  );
}

String formatTime(BuildContext context, int hour, int minute) {
  return TimeOfDay(hour: hour, minute: minute).format(context);
}
