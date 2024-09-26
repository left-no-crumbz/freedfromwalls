import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastEditedInfo extends StatelessWidget {
  final DateTime creationDate;
  final DateTime editedDate;

  const LastEditedInfo({
    Key? key,
    required this.creationDate,
    required this.editedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Last edited",
          style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 10,
              color: const Color(0xff746F6F)),
        ),
        Text(
          "${DateFormat("yMMMMd").format(editedDate)} | ${DateFormat("jm").format(editedDate)}",
          style: const TextStyle(fontSize: 10, color: const Color(0xff746F6F)),
        ),
      ],
    );
  }
}
