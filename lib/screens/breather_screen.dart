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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16, bottom: 8),
                                child: Text(
                                  "Highlight:",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          UnorderedList(texts: [
                            "Sample 1",
                            "Sample 2",
                            "Sample 3",
                          ]),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 2,
                      color: dividerColor,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16, bottom: 8),
                                child: Text(
                                  "Notes:",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          UnorderedList(texts: [
                            "Sample 1",
                            "Sample 2",
                            "Sample 3",
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width * .9, // 90% width
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: dividerColor)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 16, right: 4),
                        child: const Text("How do you feel right now?",
                            style: TextStyle(fontSize: 12)),
                      ),
                      const Divider(
                        height: 2,
                        color: dividerColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, left: 8, right: 8, bottom: 8),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          "lib/assets/images/emotions-happy.png",
                                          fit: BoxFit.cover),
                                      const Text(
                                        "YAY",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const Text(
                                        "(happy)",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                        child: Radio(
                                          value: 10,
                                          groupValue: Icons.currency_yen_sharp,
                                          onChanged: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          "lib/assets/images/emotions-sad.png",
                                          fit: BoxFit.cover),
                                      const Text(
                                        "HUHU",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const Text(
                                        "(sad)",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                        child: Radio(
                                          value: 10,
                                          groupValue: Icons.currency_yen_sharp,
                                          onChanged: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          "lib/assets/images/emotions-angry.png",
                                          fit: BoxFit.cover),
                                      const Text(
                                        "GRAH",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const Text(
                                        "(angry)",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                        child: Radio(
                                          value: 10,
                                          groupValue: Icons.currency_yen_sharp,
                                          onChanged: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          "lib/assets/images/emotions-neutral.png",
                                          fit: BoxFit.cover),
                                      const Text(
                                        "MEH",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const Text(
                                        "(neutral)",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                        child: Radio(
                                          value: 10,
                                          groupValue: Icons.currency_yen_sharp,
                                          onChanged: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          "lib/assets/images/emotions-love.png",
                                          fit: BoxFit.cover),
                                      const Text(
                                        "YIE",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const Text(
                                        "(in love)",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                        child: Radio(
                                          value: 10,
                                          groupValue: Icons.currency_yen_sharp,
                                          onChanged: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              // 2nd Row
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          "lib/assets/images/emotions-tired.png",
                                          fit: BoxFit.cover),
                                      const Text(
                                        "SIGH",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const Text(
                                        "(tired)",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                        child: Radio(
                                          value: 10,
                                          groupValue: Icons.currency_yen_sharp,
                                          onChanged: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          "lib/assets/images/emotions-energetic.png",
                                          fit: BoxFit.cover),
                                      const Text(
                                        "WOAH",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const Text(
                                        "(energetic)",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                        child: Radio(
                                          value: 10,
                                          groupValue: Icons.currency_yen_sharp,
                                          onChanged: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          "lib/assets/images/emotions-curious.png",
                                          fit: BoxFit.cover),
                                      const Text(
                                        "UHM",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const Text(
                                        "(curious)",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                        child: Radio(
                                          value: 10,
                                          groupValue: Icons.currency_yen_sharp,
                                          onChanged: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          "lib/assets/images/emotions-embarrassed.png",
                                          fit: BoxFit.cover),
                                      const Text(
                                        "WOMP",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const Text(
                                        "(embarrassed)",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                        child: Radio(
                                          value: 10,
                                          groupValue: Icons.currency_yen_sharp,
                                          onChanged: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          "lib/assets/images/emotions-scared.png",
                                          fit: BoxFit.cover),
                                      const Text(
                                        "AAA",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const Text(
                                        "(scared)",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                        child: Radio(
                                          value: 10,
                                          groupValue: Icons.currency_yen_sharp,
                                          onChanged: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        )));
  }
}
