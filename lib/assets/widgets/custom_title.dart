import 'package:flutter/material.dart';
import 'customThemes.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  const CustomTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
            fontSize: AppThemes.getResponsiveFontSize(context, 12),
            fontFamily: "RethinkSans",
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
