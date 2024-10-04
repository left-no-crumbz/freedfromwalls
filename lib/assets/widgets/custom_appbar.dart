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
        children: <Widget>[
          Image.asset("lib/assets/images/logo.png"),
          const SizedBox(width: 16,),
          Text(
            "FreedFromWalls",
            style: TextStyle(
              color: Colors.white,
              fontSize: AppThemes.getResponsiveFontSize(context, 16),
              fontWeight: FontWeight.bold,
              fontFamily: "Inter",
            ),
          ),
        ],
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
