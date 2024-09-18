import 'package:flutter/material.dart';
import '../assets/widgets/screen_title.dart';

class FeelPage extends StatefulWidget {
  const FeelPage({super.key});

  @override
  State<FeelPage> createState() => _FeelPage();
}

class _FeelPage extends State<FeelPage> {
  final List<TextEditingController> _titleControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  static const dividerColor = Color(0xFF423e3d);
  static const scaffoldBackgroundColor = Color(0xFFF1F3F4);

  final List<TextEditingController> _descriptionControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  bool _isEditable = false;

  String _selectedNotificationTime = 'Never';

  @override
  void initState() {
    super.initState();
    for (var controller in _titleControllers) {
      controller.addListener(_updateWinCount);
    }
    for (var controller in _descriptionControllers) {
      controller.addListener(_updateWinCount);
    }
  }

  @override
  void dispose() {
    for (var controller in _titleControllers) {
      controller.removeListener(_updateWinCount);
      controller.dispose();
    }
    for (var controller in _descriptionControllers) {
      controller.removeListener(_updateWinCount);
      controller.dispose();
    }
    super.dispose();
  }

  void _toggleEditable() {
    setState(() {
      _isEditable = !_isEditable;
    });
  }

  int _calculateWinCount() {
    int count = 0;
    for (int i = 0; i < _titleControllers.length; i++) {
      if (_titleControllers[i].text.isNotEmpty ||
          _descriptionControllers[i].text.isNotEmpty) {
        count++;
      }
    }
    return count;
  }

  void _updateWinCount() {
    setState(() {});
  }

  void _showNotificationOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: scaffoldBackgroundColor,
          title: Text(
            'Get notifications of your win.',
            style: TextStyle(fontSize: 14),
          ),
          children: <Widget>[
            RadioListTile<String>(
              title: Text('24 hours', style: TextStyle(fontSize: 12)),
              value: '24 hours',
              groupValue: _selectedNotificationTime,
              onChanged: (value) {
                setState(() {
                  _selectedNotificationTime = value!;
                });
                Navigator.of(context).pop();
              },
            ),
            RadioListTile<String>(
              title: Text('48 hours', style: TextStyle(fontSize: 12)),
              value: '48 hours',
              groupValue: _selectedNotificationTime,
              onChanged: (value) {
                setState(() {
                  _selectedNotificationTime = value!;
                });
                Navigator.of(context).pop();
              },
            ),
            RadioListTile<String>(
              title: Text('1 week', style: TextStyle(fontSize: 12)),
              value: '1 week',
              groupValue: _selectedNotificationTime,
              onChanged: (value) {
                setState(() {
                  _selectedNotificationTime = value!;
                });
                Navigator.of(context).pop();
              },
            ),
            RadioListTile<String>(
              title: Text('2 weeks', style: TextStyle(fontSize: 12)),
              value: '2 weeks',
              groupValue: _selectedNotificationTime,
              onChanged: (value) {
                setState(() {
                  _selectedNotificationTime = value!;
                });
                Navigator.of(context).pop();
              },
            ),
            RadioListTile<String>(
              title: Text('Never', style: TextStyle(fontSize: 12)),
              value: 'Never',
              groupValue: _selectedNotificationTime,
              onChanged: (value) {
                setState(() {
                  _selectedNotificationTime = value!;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int winCount = _calculateWinCount();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScreenTitle(title: "FULFEELMENT"),
              Container(
                padding: EdgeInsets.all(8.0), //From 2, to 8
                margin: EdgeInsets.symmetric(vertical: 5.0),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: dividerColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Remind yourself of your achievements.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        IconButton(
                          icon: Icon(
                            Icons.notifications,
                            size: 20,
                            color: Colors.black,
                          ),
                          onPressed: _showNotificationOptions,
                        ),
                        SizedBox(width: 6),
                        IconButton(
                          icon: Icon(
                            _isEditable ? Icons.check : Icons.edit,
                            color: Colors.black,
                            size: 20,
                          ),
                          onPressed: _toggleEditable,
                        ),
                      ],
                    ),
                    Text(
                      'Win Count: $winCount',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 3),
                    Column(
                      children: List.generate(6, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // CIRCLE AND NUMBER
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      controller: _titleControllers[index],
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            'Title for reminder ${index + 1}',
                                        hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: 20,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: 10.0,
                                        ),
                                      ),
                                      readOnly: !_isEditable,
                                    ),
                                    SizedBox(
                                      height: 20,
                                      child: TextField(
                                        controller:
                                            _descriptionControllers[index],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              'Description for reminder ${index + 1}',
                                          hintStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontSize: 12,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: -30,
                                            horizontal: 12.0,
                                          ),
                                        ),
                                        readOnly: !_isEditable,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
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
