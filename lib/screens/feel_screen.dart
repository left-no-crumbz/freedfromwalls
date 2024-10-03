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
                  decoration: const InputDecoration(
                    hintText: 'Title of Achievement',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12.0),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12.0),
                  ),
                ),
                const SizedBox(height: 16),
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
                          icon: const Icon(Icons.send,
                              color: Colors.white, size: 23),
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Get notifications of your wins.",
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                "Please select one option below.",
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              RadioListTile<String>(
                title: const Text('24 hours',
                    style: const TextStyle(fontSize: 12)),
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
                title: const Text('48 hours',
                    style: const TextStyle(fontSize: 12)),
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
                title:
                    const Text('1 week', style: const TextStyle(fontSize: 12)),
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
                title:
                    const Text('2 weeks', style: const TextStyle(fontSize: 12)),
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
                title:
                    const Text('Never', style: const TextStyle(fontSize: 12)),
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
                child: const Text('Schedule Notification',
                    style: const TextStyle(fontSize: 14)),
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "FULLFEELMENT",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jua',
                      ),
                    ),
                    const Text(
                      'Remind yourself of your achievements.',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'RethinkSans',
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 55.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF56537C),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          child: Text(
                            'WIN COUNT: ${_titleControllers.length}',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: _showNotificationBottomSheet,
                          child: SizedBox(
                            width: 58,
                            height: 48,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFD7D5EE),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Icon(
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
                      const Divider(),
                      const Text(
                        "Click the add button below to add achievements.",
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
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
                            child: const Text(
                              "No items here yet.\nShare the things you want to do!",
                              style: const TextStyle(
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _titleControllers.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const Divider(color: Colors.grey),
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
                                      padding: const EdgeInsets.all(1),
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
                                            offset: const Offset(0,
                                                2), // Changes the position of the shadow
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: const TextStyle(
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
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText:
                                                          'Title for reminder ${index + 1}',
                                                      hintStyle: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.6),
                                                          fontSize: 18),
                                                    ),
                                                    readOnly:
                                                        !_isEditableList[index],
                                                  ),
                                                ),
                                                const SizedBox(width: 2),
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
                                                    icon: const Icon(
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
                                              style: const TextStyle(
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
                            const Divider(height: 0, color: Colors.grey),
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
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 26,
        ),
      ),
    );
  }
}
