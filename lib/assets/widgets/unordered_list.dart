import 'package:flutter/material.dart';

class UnorderedList extends StatelessWidget {
  final List<String> texts;
  const UnorderedList({super.key, required this.texts});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    for (var text in texts) {
      widgetList.add(UnorderedListItem(text: text));
      widgetList.add(const SizedBox(
        height: 4,
      ));
    }
    return Column(children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  const UnorderedListItem({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.only(left: 32),
            child: Text("•", style: TextStyle(fontSize: 12))),
        const SizedBox(width: 8),
        Expanded(
            child: Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        )),
      ],
    );
  }
}
