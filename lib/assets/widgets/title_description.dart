import 'package:flutter/material.dart';

class TitleDescription extends StatelessWidget {
  final String title;
  final String description;
  const TitleDescription(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            description,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
          )
        ],
      ),
    );
  }
}
