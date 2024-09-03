import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xff2d2d2d);
    return AppBar(
      backgroundColor: backgroundColor,
      title: Row(
        children: <Widget>[
          Image.asset("lib/assets/images/logo.png"),
          const SizedBox(
            width: 16,
          ),
          const Text(
            "FreedFromWalls",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
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
