import 'package:flutter/material.dart';

class UnorderedList extends StatelessWidget {
  final List<TextEditingController> controllers;
  final bool isEditing;

  const UnorderedList({
    Key? key,
    required this.controllers,
    required this.isEditing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: controllers
          .map((controller) => UnorderedListItem(
                controller: controller,
                isEditing: isEditing,
              ))
          .toList(),
    );
  }
}

class UnorderedListItem extends StatelessWidget {
  final TextEditingController controller;
  final bool isEditing;

  const UnorderedListItem({
    Key? key,
    required this.controller,
    required this.isEditing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 32),
          child: Text("•", style: TextStyle(fontSize: 12)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: 20,
            child: isEditing
                ? TextField(
                    controller: controller,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:
                            "Sample ${controller.text[controller.text.length - 1]}"),
                  )
                : Text(
                    controller.text,
                    style: TextStyle(fontSize: 12),
                  ),
          ),
        ),
      ],
    );
  }
}
