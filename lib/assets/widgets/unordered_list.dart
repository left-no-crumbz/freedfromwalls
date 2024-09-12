import 'package:flutter/material.dart';

class UnorderedList extends StatelessWidget {
  final List<TextEditingController> controllers;
  final bool isEditing;
  final Color textColor;

  const UnorderedList({
    Key? key,
    required this.controllers,
    required this.isEditing,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: controllers
          .map((controller) => UnorderedListItem(
                controller: controller,
                isEditing: isEditing,
                textColor: textColor,
              ))
          .toList(),
    );
  }
}

class UnorderedListItem extends StatelessWidget {
  final TextEditingController controller;
  final bool isEditing;
  final Color textColor;

  const UnorderedListItem({
    Key? key,
    required this.controller,
    required this.isEditing,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Text("•", style: TextStyle(fontSize: 12, color: textColor)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: 20,
            child: isEditing
                ? TextField(
                    controller: controller,
                    style: TextStyle(fontSize: 12, color: textColor),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 12, color: textColor),
                      hintText: "Enter text here",
                    ))
                : Text(
                    controller.text,
                    style: TextStyle(fontSize: 12, color: textColor),
                  ),
          ),
        ),
      ],
    );
  }
}
