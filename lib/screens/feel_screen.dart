import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:freedfromwalls/controllers/fullfeelment_controller.dart';
import 'package:freedfromwalls/models/fullfeelment.dart';
import 'package:provider/provider.dart';

import '../assets/widgets/customThemes.dart';
import '../assets/widgets/title_description.dart';
import '../models/user.dart';
import '../providers/fullfeelment_provider.dart';
import '../providers/user_provider.dart';

class FeelPage extends StatefulWidget {
  const FeelPage({super.key});

  @override
  State<FeelPage> createState() => _FeelPage();
}

class _FeelPage extends State<FeelPage> {
  final FeelController _feelController = FeelController();
  List<FeelModel> _feels = [];
  String _selectedNotificationTime = 'Never';
  bool _isLoading = true;

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

    _fetchFeels();
  }

  Future<void> _fetchFeels() async {
    setState(() {
      _isLoading = true;
    });

    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      if (user != null) {
        List<FeelModel> fetchedFeels =
            await _feelController.fetchFeels(user.id.toString());

        // You can debug print the fetched list to see the IDs
        fetchedFeels.forEach((item) => debugPrint(
            "Fetched item: ${item.id} - ${item.title} - ${item.description}"));

        Provider.of<FeelProvider>(context, listen: false)
            .setFeels(fetchedFeels);

        setState(() {
          _feels = fetchedFeels;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error encountered while fetching feels: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _editFeelData(FeelModel feel) async {
    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      await _feelController.editFeel(
        feel,
        user!.id.toString(),
        feel.id.toString(),
      );
    } catch (e) {
      debugPrint("Error while editing a feel: $e");
    }
  }

  Future<void> _addFeelData(FeelModel feel) async {
    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      await _feelController.addFeel(feel, user!.id.toString());
    } catch (e) {
      debugPrint("Error while adding a Feel: $e");
    }
  }

  void _showReminderBottomSheet(
      {String? currentTitle, String? currentDesc, int? index, String? action}) {
    final titleController = TextEditingController(text: currentTitle);
    final descriptionController = TextEditingController(text: currentDesc);

    void addFeel(String title, String description) async {
      UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

      await _addFeelData(
          FeelModel(title: title, description: description, userId: user!.id));

      await _fetchFeels();
    }

    void editFeel(String title, String description) async {
      UserModel? user = Provider.of<UserProvider>(context, listen: false).user;
      FeelModel? feel = _feels[index!];

      if (user != null) {
        await _editFeelData(FeelModel(
            id: feel.id,
            title: title,
            description: description,
            userId: user!.id));
      } else {
        print("Error in adding feel: No user found.");
      }

      await _fetchFeels();
    }

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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
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
                          onPressed: () async {
                            if (titleController.text.isNotEmpty &&
                                descriptionController.text.isNotEmpty) {
                              setState(() {
                                if (action == "Editing") {
                                  editFeel(titleController.text,
                                      descriptionController.text);
                                } else {
                                  addFeel(titleController.text,
                                      descriptionController.text);
                                }
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    "Title and description should not be empty."),
                              ));
                            }

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

  void _editItem(int index) {
    FeelModel currentItem = _feels[index];
    String? currentTitle = currentItem.title;
    String? currentDesc = currentItem.description;

    _showReminderBottomSheet(
        currentTitle: currentTitle,
        currentDesc: currentDesc,
        index: index,
        action: "Editing");
  }

  void _deleteFeel(int index) {
    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

    // Show confirmation dialog first
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Dismiss the dialog if user cancels
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Dismiss the dialog
                Navigator.of(context).pop();

                // Call Delete
                try {
                  FeelModel feel = _feels[index];
                  await _feelController.deleteFeel(
                      user!.id.toString(), feel.id.toString());
                } catch (e) {
                  debugPrint("Error: $e");
                }

                await _fetchFeels();
              },
              child: Text('Delete'),
            ),
          ],
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
                style: TextStyle(fontSize: 18),
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
                    style: TextStyle(
                        fontSize:
                            AppThemes.getResponsiveFontSize(context, 12))),
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
                    style: TextStyle(
                        fontSize:
                            AppThemes.getResponsiveFontSize(context, 12))),
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
                title: Text('1 week',
                    style: TextStyle(
                        fontSize:
                            AppThemes.getResponsiveFontSize(context, 12))),
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
                title: Text('2 weeks',
                    style: TextStyle(
                        fontSize:
                            AppThemes.getResponsiveFontSize(context, 12))),
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
                title: Text('Never',
                    style: TextStyle(
                        fontSize:
                            AppThemes.getResponsiveFontSize(context, 12))),
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
                  // Check if the list of feels is not empty before scheduling the notification
                  if (_feels.isNotEmpty) {
                    FeelModel lastFeel = _feels.last;
                    _scheduleNotification(lastFeel.title ?? 'No title',
                        lastFeel.description ?? 'No description');
                  }
                },
                child: Text('Schedule Notification',
                    style: TextStyle(
                        fontSize:
                            AppThemes.getResponsiveFontSize(context, 14))),
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
                child: const TitleDescription(
                    title: "FULLFEELMENT",
                    description: "Remind yourself of your achievements.")),

            // Win count and notification icon
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 55.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black, width: 1.0),
                  ),
                  child: Text(
                    'WIN COUNT: ${_feels.length}',
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
                      color: Theme.of(context).primaryColor,
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
            if (_feels.isEmpty) ...[
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
            for (int index = 0; index < _feels.length; index++) ...[
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
                          fontSize:
                              AppThemes.getResponsiveFontSize(context, 12),
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
                        // Title Text Display
                        Text(
                          _feels[index].title!,
                          style: TextStyle(
                            fontSize:
                                AppThemes.getResponsiveFontSize(context, 18),
                            color: Colors.black,
                          ),
                        ),

                        // Description Text Display
                        Text(
                          _feels[index].description!,
                          style: TextStyle(
                            fontSize:
                                AppThemes.getResponsiveFontSize(context, 12),
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Edit/Check Icon
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 15,
                    ),
                    onPressed: () => _editItem(index),
                  ),

                  // Delete Icon
                  IconButton(
                    icon:
                        const Icon(Icons.delete, color: Colors.black, size: 15),
                    onPressed: () {
                      _deleteFeel(index);
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
        onPressed: _showReminderBottomSheet,
        backgroundColor: Colors.black,
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 26),
      ),
    );
  }
}
