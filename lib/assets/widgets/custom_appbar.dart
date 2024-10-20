import 'package:flutter/material.dart';
import 'customThemes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Colors.black;
    return AppBar(
      backgroundColor: backgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "FreedFromWalls",
            style: TextStyle(
              color: Colors.white,
              fontSize: AppThemes.getResponsiveFontSize(context, 16),
              fontWeight: FontWeight.bold,
              fontFamily: "Jua",
            ),
          ),
        ],
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
