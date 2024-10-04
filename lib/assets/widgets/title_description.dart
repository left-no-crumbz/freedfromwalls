import 'package:flutter/material.dart';
import 'customThemes.dart';

class TitleDescription extends StatelessWidget {
  final String title;
  final String description;
  const TitleDescription(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 16.0, left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize:  AppThemes.getResponsiveFontSize(context, 20),
              fontWeight: FontWeight.bold,
              fontFamily: 'Jua',
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize:  AppThemes.getResponsiveFontSize(context, 12),
              fontWeight: FontWeight.w300,
              fontFamily: 'RethinkSans',
            ),
          )
        ],
      ),
    );
  }
}
