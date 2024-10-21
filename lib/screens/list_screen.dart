import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freedfromwalls/assets/widgets/customThemes.dart';
import 'package:freedfromwalls/controllers/todo_controller.dart';
import 'package:freedfromwalls/models/bucketlist.dart';
import 'package:provider/provider.dart';
import '../assets/widgets/theme_provider.dart';
import '../providers/blacklist_provider.dart';
import '../providers/bucketlist_provider.dart';
import '../assets/widgets/title_description.dart';
import '../models/blacklist.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  // Others
  bool isBucketListSelected = true;
  String message = "Bucketlisted";

  static const borderColor = Color(0xff423e3d);

  // Separate lists and checkbox statuses for each category
  List<bool> _bucketListChecked = [];
  List<bool> _blackListChecked = [];
  List<BucketListModel> _newBucketList = [];
  List<BlackListModel> _newBlackList = [];
  bool _isLoading = true;

  // Method to return the current list (Bucketlisted or Blacklisted)
  List<dynamic> get _currentList =>
      isBucketListSelected ? _newBucketList : _newBlackList;

  List<bool> get _currentChecked =>
      isBucketListSelected ? _bucketListChecked : _blackListChecked;

  final TodoController _todoController = TodoController();

  // For multiple selection
  bool _isAnyItemSelected = false;

  @override
  void initState() {
    super.initState();
    _fetchLists();
  }

  Future<void> _fetchLists() async {
    setState(() {
      _isLoading = true;
    });

    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

    if (isBucketListSelected) {
      try {
        if (user != null) {
          List<BucketListModel> fetchedList =
              await _todoController.fetchBucketlists(user.id.toString());

          // You can debug print the fetched list to see the IDs
          fetchedList.forEach(
              (item) => debugPrint("Fetched item: ${item.id} - ${item.body}"));

          Provider.of<BucketListProvider>(context, listen: false)
              .setBucketLists(fetchedList);

          setState(() {
            _newBucketList = fetchedList;
            _isLoading = false;
            _bucketListChecked = List.filled(fetchedList.length, false);
          });
        }
      } catch (e) {
        debugPrint("Error encountered while fetching bucketlists: $e");
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      try {
        if (user != null) {
          List<BlackListModel> fetchedList =
              await _todoController.fetchBlacklists(user.id.toString());

          // You can debug print the fetched list to see the IDs
          fetchedList.forEach(
              (item) => debugPrint("Fetched item: ${item.id} - ${item.body}"));

          Provider.of<BlackListProvider>(context, listen: false)
              .setBlackLists(fetchedList);

          setState(() {
            _newBlackList = fetchedList;
            _isLoading = false;
            _blackListChecked =
                List.filled(fetchedList.length, false, growable: true);
          });
        }
      } catch (e) {
        debugPrint("Error encountered while fetching blacklists: $e");
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> addBucketList(BucketListModel bucketlist) async {
    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      await _todoController.addBucketList(bucketlist, user!.id.toString());
    } catch (e) {
      debugPrint("Error while adding a bucketlist: $e");
    }
  }

  Future<void> addBlackList(BlackListModel blacklist) async {
    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      await _todoController.addBlackList(blacklist, user!.id.toString());
    } catch (e) {
      debugPrint("Error while adding a blacklist: $e");
    }
  }

  Future<void> editBucketList(BucketListModel bucketlist) async {
    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      await _todoController.editBucketList(
        bucketlist,
        user!.id.toString(),
        bucketlist.id.toString(),
      );
    } catch (e) {
      debugPrint("Error while editing a bucket list: $e");
    }
  }

  Future<void> editBlackList(BlackListModel blacklist) async {
    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      await _todoController.editBlackList(
        blacklist,
        user!.id.toString(),
        blacklist.id.toString(),
      );
    } catch (e) {
      debugPrint("Error while editing a black list: $e");
    }
  }

  Widget screenTitle() {
    final selectedColor = Theme.of(context).cardColor;
    final unselectedColor = Theme.of(context).primaryColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: 28,
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  isBucketListSelected = true;
                  message = "Bucketlisted";
                });
                await _fetchLists();
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 2),
                decoration: BoxDecoration(
                  color: isBucketListSelected ? selectedColor : unselectedColor,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: borderColor, width: 1.0),
                  boxShadow: isBucketListSelected
                      ? [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2))
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    'Bucketlisted',
                    style: TextStyle(
                      color: isBucketListSelected
                          ? Colors.white
                          : Color(0xff000000),
                      fontFamily: "Inter",
                      fontSize: AppThemes.getResponsiveFontSize(context, 14),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 28,
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  isBucketListSelected = false;
                  message = "Blacklisted";
                });
                await _fetchLists();
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                margin: const EdgeInsets.only(left: 2),
                decoration: BoxDecoration(
                  color: isBucketListSelected ? unselectedColor : selectedColor,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: borderColor, width: 1.0),
                  boxShadow: !isBucketListSelected
                      ? [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2))
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    'Blacklisted',
                    style: TextStyle(
                      color: isBucketListSelected
                          ? Color(0xff000000)
                          : Colors.white,
                      fontFamily: "Inter",
                      fontSize: AppThemes.getResponsiveFontSize(context, 14),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showItemBottomSheet({String? currentItem, int? index}) {
    final TextEditingController _textController =
        TextEditingController(text: currentItem);

    void addToList(String text, String type) async {
      UserModel? user = Provider.of<UserProvider>(context, listen: false).user;
      if (type == "Bucketlist") {
        try {
          await addBucketList(BucketListModel(body: text, userId: user!.id));
          _bucketListChecked.add(false);
        } catch (e) {
          debugPrint("Error: $e");
        }
      } else if (type == "Blacklist") {
        try {
          await addBlackList(BlackListModel(body: text, userId: user!.id));
          _blackListChecked.add(false);
        } catch (e) {
          debugPrint("$e");
        }
      }
      await _fetchLists();
    }

    void editList(String text, String type) async {
      UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

      if (type == "Bucketlist") {
        try {
          BucketListModel bucketItem = _newBucketList[index!];
          await editBucketList(
              BucketListModel(id: bucketItem.id, body: text, userId: user!.id));
        } catch (e) {
          debugPrint("Error: $e");
        }
      } else if (type == "Blacklist") {
        try {
          BlackListModel blackItem = _newBlackList[index!];
          blackItem.body = text;

          await editBlackList(
              BlackListModel(id: blackItem.id, body: text, userId: user!.id));
        } catch (e) {
          debugPrint("Error: $e");
        }
      }
      await _fetchLists();
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
                    child: Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 25,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_textController.text.isNotEmpty) {
                              if (index != null) {
                                // Edit existing item
                                if (_currentList[index] is BucketListModel) {
                                  (_currentList[index] as BucketListModel)
                                      .body = _textController.text;
                                  editList(_textController.text, "Bucketlist");
                                } else if (_currentList[index]
                                    is BlackListModel) {
                                  (_currentList[index] as BlackListModel).body =
                                      _textController.text;
                                  editList(_textController.text, "Blacklist");
                                }
                              } else {
                                // Add new item
                                if (isBucketListSelected) {
                                  addToList(_textController.text, "Bucketlist");
                                } else {
                                  addToList(_textController.text, "Blacklist");
                                }
                              }
                            }
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
        );
      },
    );
  }

  void _editItem(int index) {
    String? currentItem;
    if (_currentList[index] is BucketListModel) {
      currentItem = (_currentList[index] as BucketListModel).body;
    } else if (_currentList[index] is BlackListModel) {
      currentItem = (_currentList[index] as BlackListModel).body;
    }

    _showItemBottomSheet(currentItem: currentItem, index: index);
  }

  void _showDeleteConfirmationDialog({int? index}) {
    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

    void deleteItem() async {
      // Proceed with deletion
      if (isBucketListSelected) {
        try {
          BucketListModel bucketItem = _newBucketList[index!];
          print(bucketItem.id);

          // Call delete method from your controller
          await _todoController.deleteBucketList(
              user!.id.toString(), bucketItem.id.toString());

          // Remove the item from the local list
          setState(() {
            _newBucketList.removeAt(index);
          });
        } catch (e) {
          debugPrint("Error: $e");
        }
      } else {
        try {
          BlackListModel blackItem = _newBlackList[index!];

          // Call delete method from your controller
          await _todoController.deleteBlackList(
              user!.id.toString(), blackItem.id.toString());

          // Remove the item from the local list
          setState(() {
            _newBlackList.removeAt(index);
          });
        } catch (e) {
          debugPrint("Error: $e");
        }
      }

      await _fetchLists();
    }

    void deleteItems() async {
      // Proceed with deletion
      if (isBucketListSelected) {
        try {
          for (int i = 0; i < _bucketListChecked.length; i++) {
            if (_bucketListChecked[i] == true) {
              BucketListModel bucketItem = _newBucketList[i];

              // Call delete method from your controller
              await _todoController.deleteBucketList(
                  user!.id.toString(), bucketItem.id.toString());
            }
          }
        } catch (e) {
          debugPrint("Error: $e");
        }
      } else {
        try {
          for (int i = 0; i < _blackListChecked.length; i++) {
            if (_blackListChecked[i] == true) {
              BlackListModel blackItem = _newBlackList[i];

              // Call delete method from your controller
              await _todoController.deleteBlackList(
                  user!.id.toString(), blackItem.id.toString());
            }
          }
        } catch (e) {
          debugPrint("Error: $e");
        }
      }

      await _fetchLists();
    }

    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: false,
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  print('Tapped outside the modal');
                },
                child: Container(
                  color: Colors.transparent, // Make the background transparent
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Are you sure you want to delete the selected item(s)?",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Cancel
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the bottom sheet
                        },
                        child: const Text("Cancel"),
                      ),

                      // Delete
                      ElevatedButton(
                        onPressed: () {
                          if (_isAnyItemSelected == false) {
                            deleteItem();
                          } else {
                            deleteItems();
                          }

                          _isAnyItemSelected = false;
                          Navigator.of(context).pop(); // Close the bottom sheet
                        },
                        child: const Text("Delete"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _updateSelectionStatus() {
    _isAnyItemSelected = _currentChecked.contains(true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    var currentTheme = Provider.of<ThemeProvider>(context).theme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TitleDescription(
                  title: message,
                  description: isBucketListSelected
                      ? "Record the things you want to do over the year."
                      : "Record the things you do not want to do over the year."),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: screenTitle(),
            ),

            // Checklist for Bucketlist or Blacklist based on selection
            if (_currentList.isNotEmpty)
              Container(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _currentList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            leading: Checkbox(
                              value: _currentChecked[index],
                              onChanged: (bool? value) {
                                setState(() {
                                  _currentChecked[index] = value ?? false;
                                  _updateSelectionStatus(); // Update if any item is selected
                                });
                              },
                            ),
                            title: Text(_currentList[index].body),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 25, // Adjust maxWidth as needed
                                    maxHeight:
                                        30, // Ensure the buttons are consistent in size
                                  ),
                                  child: IconButton(
                                    iconSize: 20.0,
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.edit,
                                        color: _isAnyItemSelected
                                            ? Colors.grey
                                            : Colors.black),
                                    onPressed: _isAnyItemSelected
                                        ? null
                                        : () => _editItem(index),
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 30, // Same width for consistency
                                    maxHeight: 30,
                                  ),
                                  child: IconButton(
                                    iconSize: 20.0,
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.delete,
                                        color: _isAnyItemSelected
                                            ? Colors.grey
                                            : Colors.black),
                                    onPressed: _isAnyItemSelected
                                        ? null
                                        : () => _showDeleteConfirmationDialog(
                                            index: index),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

            // Display the image and "No items here" text only if the current list is empty
            if (_currentList.isEmpty)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.08,
                  ),
                  Image.asset(
                    AppThemes.getListImages(isBucketListSelected, currentTheme),
                    width: AppThemes.getResponsiveImageSize(context, 250),
                    height: AppThemes.getResponsiveImageSize(context, 250),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No items here yet.\nShare the things you want to do!",
                    style: TextStyle(
                      fontSize: AppThemes.getResponsiveFontSize(context, 16),
                      color: Colors.black,
                      fontFamily: 'Jua',
                    ),
                    textAlign: TextAlign.center, // Already set for centering
                  ),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: _isAnyItemSelected
          ? FloatingActionButton(
              onPressed: _showDeleteConfirmationDialog,
              backgroundColor: Colors.red,
              elevation: 0,
              shape: const CircleBorder(),
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 26,
              ),
            )
          : FloatingActionButton(
              onPressed: _showItemBottomSheet,
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
