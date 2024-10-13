import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'customThemes.dart';

class LastEditedInfo extends StatelessWidget {
  final DateTime creationDate;
  final DateTime editedDate;

  const LastEditedInfo({
    super.key,
    required this.creationDate,
    required this.editedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Last edited",
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: AppThemes.getResponsiveFontSize(context, 12),
              color: const Color(0xff746F6F),
              fontFamily: "RethinkSans"),
        ),
        Text(
          "${DateFormat("yMMMMd").format(editedDate)} | ${DateFormat("jm").format(editedDate)}",
          style: TextStyle(
              fontSize: AppThemes.getResponsiveFontSize(context, 12),
              color: const Color(0xff746F6F),
              fontFamily: "RethinkSans"),
        ),
      ],
    );
  }
}
