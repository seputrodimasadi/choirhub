import "package:flutter/material.dart";
import "package:intl/intl.dart";

class DateFormatted extends StatelessWidget {
  final String timestamp;
  DateFormatted(this.timestamp);

  @override
  Widget build(BuildContext context) {
    return Text(
        DateFormat('d MMMM yyy').format(DateTime.parse(timestamp))
    );
  }
}

class TimeDateFormatted extends StatelessWidget {
  final String timestamp;
  TimeDateFormatted(this.timestamp);

  @override
  Widget build(BuildContext context) {
    return Text(
        DateFormat('KK:mma, d MMMM yyy').format(DateTime.parse(timestamp))
    );
  }
}