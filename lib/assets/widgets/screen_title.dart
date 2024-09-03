import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  const ScreenTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xff2d2d2d);
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(
        top: 16,
      ),
      // 90% of the parent container they say?
      width: MediaQuery.of(context).size.width * .9,
      height: 30,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontFamily: "Inter",
        ),
      ),
    );
  }
}
