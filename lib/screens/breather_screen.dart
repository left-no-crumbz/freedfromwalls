import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../assets/widgets/screen_title.dart';
import '../assets/widgets/unordered_list.dart';

class BreatherPage extends StatefulWidget {
  const BreatherPage({super.key});

  @override
  State<BreatherPage> createState() => _BreatherPageState();
}

void main() => runApp(const BreatherPage());

class _BreatherPageState extends State<BreatherPage> {
  static const dividerColor = Color(0xFF423e3d);
  static const scaffoldBackgroundColor = Color(0xFFF1F3F4);

  final date = DateFormat("yMMMMd").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter",
        scaffoldBackgroundColor: scaffoldBackgroundColor,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              const ScreenTitle(
                title: "BREATHER",
              ),
              Container(
                width: MediaQuery.of(context).size.width * .9, // 90% width
                height: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: dividerColor)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // A container was needed to reduce the margin
                    // of the IconButton (i h8 flutter)
                    Container(
                      height: 30,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 16, right: 4),
                      child: Row(
                        children: [
                          Text(
                            date,
                            style: const TextStyle(fontSize: 12),
                          ),
                          const Expanded(child: SizedBox()),
                          IconButton(
                            iconSize: 20,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              setState(() {
                                //   TODO: Add functionality here
                              });
                            },
                            constraints: const BoxConstraints.tightFor(
                                width: 20, height: 20),
                            icon: const Icon(Icons.edit_note),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 2,
                      color: dividerColor,
                    ),
                    const Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                "Highlight:",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(),
                            ),
                          ],
                        ),
                        UnorderedList(texts: [
                          "Sample 1",
                          "Sample 2",
                          "Sample 3",
                          "Sample 4",
                          "Sample 5",
                        ])
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
