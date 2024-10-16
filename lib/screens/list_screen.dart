import 'package:flutter/material.dart';
import 'package:freedfromwalls/assets/widgets/customThemes.dart';
import 'package:freedfromwalls/controllers/todo_controller.dart';
import 'package:freedfromwalls/models/bucketlist.dart';
import 'package:provider/provider.dart';
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
  bool isBucketListSelected = true;
  String message = "Bucketlisted";

  static const borderColor = Color(0xff423e3d);

  // Separate lists and checkbox statuses for each category
  List<String> _bucketList = [];
  List<bool> _bucketListChecked = [];

  List<String> _blackList = [];
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

          Provider.of<BucketListProvider>(context, listen: false)
              .setBucketLists(fetchedList);

          setState(() {
            _newBucketList = fetchedList;
            _isLoading = false;
            _bucketListChecked = List.filled(fetchedList.length, false);
          });

          _newBucketList.forEach((item) => debugPrint("${item.toJson()}"));

          debugPrint("${_newBucketList.length}");
          debugPrint("${_currentChecked.length}");
          debugPrint("${_currentList.length}");
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
          setState(() {
            _newBlackList = fetchedList;
            _isLoading = false;
            _blackListChecked = List.filled(fetchedList.length, false);
          });

          debugPrint("${_newBlackList.length}");
          debugPrint("${_currentChecked.length}");
          debugPrint("${_currentList.length}");
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
    //   TODO: Add add impl here
    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      await _todoController.addBucketList(bucketlist, user!.id.toString());
    } catch (e) {
      debugPrint("Error while adding a bucketlist: $e");
    }
  }

  Future<void> addBlackList(BlackListModel blacklist) async {
    //   TODO: Add add impl here
    UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      await _todoController.addBlackList(blacklist, user!.id.toString());
    } catch (e) {
      debugPrint("Error while adding a blacklist: $e");
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
              onTap: () {
                setState(() {
                  isBucketListSelected = true;
                  message = "Bucketlisted";
                });
                _fetchLists();
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
              onTap: () {
                setState(() {
                  isBucketListSelected = false;
                  message = "Blacklisted";
                });
                _fetchLists();
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

  void _showAddItemBottomSheet({String? currentItem, int? index}) {
    final TextEditingController _textController =
        TextEditingController(text: currentItem);

    void addToList(String text, String type) {
      UserModel? user = Provider.of<UserProvider>(context, listen: false).user;
      if (type == "Bucketlist") {
        try {
          _bucketList.add(text);
          _bucketListChecked.add(false);
        } catch (e) {
          debugPrint("Error: $e");
        }

        // IMPORTANT: MIGHT BREAK
        addBucketList(BucketListModel(body: text, userId: user!.id));
        // load the list after adding
        _fetchLists();
      } else if (type == "Blacklist") {
        try {
          _blackList.add(text);
          _blackListChecked.add(false);
        } catch (e) {
          debugPrint("$e");
        }

        addBlackList(BlackListModel(body: text, userId: user!.id));
        // load the list after adding
        _fetchLists();
      }
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
              SizedBox(height: 16), // Add space here
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
                                _currentList[index] = _textController.text;
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
    _showAddItemBottomSheet(currentItem: _currentList[index], index: index);
  }

  void _deleteItem(int index) {
    setState(() {
      if (isBucketListSelected) {
        _bucketList.removeAt(index);
        _bucketListChecked.removeAt(index);
      } else {
        _blackList.removeAt(index);
        _blackListChecked.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TitleDescription(
                  title: message,
                  description:
                      "Record the things you want to do over the year."),
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
                                    icon: const Icon(Icons.edit,
                                        color: Colors.black),
                                    onPressed: () => _editItem(index),
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
                                    icon: const Icon(Icons.delete,
                                        color: Colors.black),
                                    onPressed: () => _deleteItem(index),
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
                    isBucketListSelected
                        ? 'lib/assets/images/backgrounds/Default_Bucketlisted.png'
                        : 'lib/assets/images/backgrounds/Default_Blacklisted.png',
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemBottomSheet,
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
