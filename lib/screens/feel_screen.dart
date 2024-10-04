import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import '../assets/widgets/customThemes.dart';
import '../assets/widgets/title_description.dart';

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
          EdgeInsets.only(bottom: MediaQuery
              .of(context)
              .viewInsets
              .bottom),
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
              Text(
                "Please select one option below.",
                style: TextStyle(
                    fontSize: AppThemes.getResponsiveFontSize(context, 12),
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              RadioListTile<String>(
                title: Text('24 hours',
                    style: TextStyle(fontSize: AppThemes.getResponsiveFontSize(context, 12))),
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
                title: Text('48 hours',
                    style: TextStyle(fontSize: AppThemes.getResponsiveFontSize(context, 12)
                    )
                ),
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
                Text('1 week', style: TextStyle(
                    fontSize: AppThemes.getResponsiveFontSize(context, 12))),
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
                Text('2 weeks', style: TextStyle(
                    fontSize: AppThemes.getResponsiveFontSize(context, 12))),
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
                Text('Never', style: TextStyle(
                    fontSize: AppThemes.getResponsiveFontSize(context, 12))),
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
                    style: TextStyle(fontSize: AppThemes.getResponsiveFontSize(
                        context, 14))),
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
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        // Unique ID
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: const TitleDescription(title: "FULLFEELMENT", description: "Remind yourself of your achievements.")
            ),

            // Win count and notification icon
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16),
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 55.0),
                  decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .cardColor,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black, width: 1.0),
                  ),
                  child: Text(
                    'WIN COUNT: ${_titleControllers.length}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: AppThemes.getResponsiveFontSize(context, 18),
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: _showNotificationBottomSheet,
                  child: Container(
                    width: 58,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Icon(
                      Icons.notifications,
                      color: Colors.black,
                      size: 23,
                    ),
                  ),
                ),
              ],
            ),

            // Empty state message when no items are present
            if (_titleControllers.isEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Divider(),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Click the add button below to add achievements.",
                    style: TextStyle(
                      fontSize: AppThemes.getResponsiveFontSize(context, 10),
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Divider(),
              ),

              //Image and text when empty
              Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'lib/assets/images/backgrounds/Default_Fullfeelment.png',
                      width: AppThemes.getResponsiveImageSize(context, 320),
                      height: AppThemes.getResponsiveImageSize(context, 320),
                    ),
                  ),
                  Text(
                    "No items here yet.\nShare the things you want to do!",
                    style: TextStyle(
                      fontSize: AppThemes.getResponsiveFontSize(context, 16),
                      color: Colors.black,
                      fontFamily: 'Jua',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],

            // List of reminders
            for (int index = 0; index < _titleControllers.length; index++) ...[
              const Divider(color: Colors.grey),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Circle with numbers
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 10),
                    width: 30,
                    height: 30,
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                      border: Border.all(color: Colors.black, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: AppThemes.getResponsiveFontSize(context, 12),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Title and Description Fields
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title TextField
                        TextField(
                          controller: _titleControllers[index],
                          style: TextStyle(
                            fontSize: AppThemes.getResponsiveFontSize(context, 18),
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Title for reminder ${index + 1}',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: AppThemes.getResponsiveFontSize(context, 18),
                            ),
                          ),
                          readOnly: !_isEditableList[index],
                        ),

                        // Description TextField
                        TextField(
                          controller: _descriptionControllers[index],
                          style: TextStyle(
                            fontSize: AppThemes.getResponsiveFontSize(context, 12),
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Description for reminder ${index + 1}',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: AppThemes.getResponsiveFontSize(context, 12),
                            ),
                            isDense: true, // Reduces the padding within the input field
                          ),
                          readOnly: !_isEditableList[index],
                        ),
                      ],
                    ),
                  ),

                  // Edit/Check Icon
                  IconButton(
                    icon: Icon(
                      _isEditableList[index] ? Icons.check : Icons.edit,
                      color: Colors.black,
                      size: 15,
                    ),
                    onPressed: () {
                      setState(() {
                        _isEditableList[index] = !_isEditableList[index];
                      });
                    },
                  ),

                  // Delete Icon
                  IconButton(
                    icon: const Icon(
                        Icons.delete,
                        color: Colors.black,
                        size: 15
                    ),
                    onPressed: () {
                      _deleteReminder(index);
                    },
                  ),
                ],
              ),
              const Divider(color: Colors.grey),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddReminderBottomSheet,
        backgroundColor: Colors.black,
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 26),
      ),
    );
  }
}