import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class FeelPage extends StatefulWidget {
  const FeelPage({super.key});

  @override
  State<FeelPage> createState() => _FeelPage();
}

class _FeelPage extends State<FeelPage> {
  final List<TextEditingController> _titleControllers = [];
  final List<TextEditingController> _descriptionControllers = [];
  final List<bool> _isEditableList = [];
  String _selectedNotificationTime = 'Never';

  @override
  void initState() {
    AwesomeNotifications().initialize(
      'resource_key',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
          icon: 'resource://drawable/res_app_icon',
        ),
      ],
    );

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _titleControllers) {
      controller.dispose();
    }
    for (var controller in _descriptionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _showAddReminderBottomSheet() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Title of Achievement',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.send, color: Colors.white, size: 23),
                          onPressed: () {
                            setState(() {
                              _titleControllers.add(titleController);
                              _descriptionControllers
                                  .add(descriptionController);
                              _isEditableList.add(false);
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showNotificationBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.99,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Get notifications of your wins.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                "Please select one option below.",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
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
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (_titleControllers.isNotEmpty &&
                      _descriptionControllers.isNotEmpty) {
                    _scheduleNotification(_titleControllers.last.text,
                        _descriptionControllers.last.text);
                  }
                },
                child: Text('Schedule Notification',
                    style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _scheduleNotification(String title, String description) {
    DateTime notificationTime;

    switch (_selectedNotificationTime) {
      case '24 hours':
        notificationTime = DateTime.now().add(Duration(hours: 24));
        break;
      case '48 hours':
        notificationTime = DateTime.now().add(Duration(hours: 48));
        break;
      case '1 week':
        notificationTime = DateTime.now().add(Duration(days: 7));
        break;
      case '2 weeks':
        notificationTime = DateTime.now().add(Duration(days: 14));
        break;
      case 'Never':
      default:
        return; // Do not schedule if "Never" is selected
    }

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        channelKey: 'basic_channel',
        id: DateTime.now()
            .millisecondsSinceEpoch
            .remainder(100000), // Unique ID
        title: title,
        body: description,
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar.fromDate(date: notificationTime),
    );
  }

  void _deleteReminder(int index) {
    setState(() {
      _titleControllers.removeAt(index);
      _descriptionControllers.removeAt(index);
      _isEditableList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "FULLFEELMENT",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jua',
                      ),
                    ),
                    Text(
                      'Remind yourself of your achievements.',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 55.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF56537C),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'WIN COUNT: ${_titleControllers.length}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: _showNotificationBottomSheet,
                          child: SizedBox(
                            width: 58,
                            height: 48,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFD7D5EE),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Icon(
                                Icons.notifications,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_titleControllers.isEmpty) ...[
                      Divider(),
                      Text(
                        "Click the add button below to add achievements.",
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      SizedBox(height: 0),
                      Column(
                        children: [
                          Transform.translate(
                            offset: Offset(0,
                                -30), // Adjust x and y values to move the image
                            child: Image.asset(
                              'lib/assets/images/backgrounds/Default_Fullfeelment.png',
                              width: 320,
                              height: 320,
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0,
                                -75), // Adjust the vertical offset to move the text upwards
                            child: Text(
                              "No items here yet.\nShare the things you want to do!",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: 'Jua',
                              ),
                              textAlign:
                                  TextAlign.center, // Center align the text
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _titleControllers.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Divider(color: Colors.grey),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 8),
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      padding: EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(
                                                0.5), // Shadow color
                                            spreadRadius: 1, // Spread radius
                                            blurRadius: 3, // Blur radius
                                            offset: Offset(0,
                                                2), // Changes the position of the shadow
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
// Title Row with Icons
                                          Container(
                                            height:
                                                20, // Set a fixed height for the row
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center, // Center the row items
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    controller:
                                                        _titleControllers[
                                                            index],
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText:
                                                          'Title for reminder ${index + 1}',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.6),
                                                          fontSize: 20),
                                                    ),
                                                    readOnly:
                                                        !_isEditableList[index],
                                                  ),
                                                ),
                                                SizedBox(width: 2),
// Edit/Check Icon
                                                Container(
                                                  child: IconButton(
                                                    icon: Icon(
                                                      _isEditableList[index]
                                                          ? Icons.check
                                                          : Icons.edit,
                                                      color: Colors.black,
                                                      size: 15,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isEditableList[index] =
                                                            !_isEditableList[
                                                                index]; // Toggle edit state
                                                      });
                                                    },
                                                  ),
                                                ),
// Delete Icon
                                                Container(
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.black,
                                                      size: 15,
                                                    ),
                                                    onPressed: () {
                                                      _deleteReminder(
                                                          index); // Call delete function
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
// Description TextField
                                          Container(
                                            height:
                                                30, // Set a fixed height for the description
                                            child: TextField(
                                              controller:
                                                  _descriptionControllers[
                                                      index],
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.black),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    'Description for reminder ${index + 1}',
                                                hintStyle: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                    fontSize: 12),
                                                contentPadding: EdgeInsets
                                                    .zero, // No padding
                                                isDense: true,
                                              ),
                                              readOnly: !_isEditableList[index],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(height: 0, color: Colors.grey),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddReminderBottomSheet,
        backgroundColor: Colors.black,
        elevation: 0,
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 26,
        ),
      ),
    );
  }
}
