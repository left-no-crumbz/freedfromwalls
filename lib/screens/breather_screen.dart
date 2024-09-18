import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../assets/widgets/screen_title.dart';
import '../assets/widgets/unordered_list.dart';
import '../assets/widgets/emotion_selector.dart';

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
  bool _isEditing = false;

  final List<TextEditingController> _highlightControllers = [];
  final List<TextEditingController> _noteControllers = [];

  @override
  void initState() {
    super.initState();
    for (var text in [
      // Instantiated empty strings
      "",
      "",
      ""
    ]) {
      _highlightControllers.add(TextEditingController(text: text));
      _noteControllers.add(TextEditingController(text: text));
    }
  }

  @override
  void dispose() {
    for (var controller in _highlightControllers) {
      controller.dispose();
    }
    for (var controller in _noteControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
    // TODO: Save data to database when editing is done
  }

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
          child: ListView(
            padding: const EdgeInsets.only(left: 16, right: 16),
            children: <Widget>[
              const ScreenTitle(
                title: "BREATHER",
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: dividerColor)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // A container was needed to reduce the margin
                    // of the IconButton
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
                            onPressed: _toggleEditMode,
                            constraints: const BoxConstraints.tightFor(
                                width: 20, height: 20),
                            icon: _isEditing
                                ? Icon(Icons.check)
                                : Icon(Icons.edit_note),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 2,
                      color: dividerColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Row(
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
                          UnorderedList(
                            controllers: _highlightControllers,
                            isEditing: _isEditing,
                            textColor: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 2,
                      color: dividerColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Row(
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
                          UnorderedList(
                            controllers: _noteControllers,
                            isEditing: _isEditing,
                            textColor: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              EmotionSelector(),
            ],
          ),
        ),
      ),
    );
  }
}
