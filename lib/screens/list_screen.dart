import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool isBucketListSelected = true; // To toggle between Bucketlisted and Blacklisted
  String message = "Bucketlisted";

  static const borderColor = Color(0xff423e3d);

  // Separate lists and checkbox statuses for each category
  List<String> _bucketList = [];
  List<bool> _bucketListChecked = [];

  List<String> _blackList = [];
  List<bool> _blackListChecked = [];

  // Method to return the current list (Bucketlisted or Blacklisted)
  List<String> get _currentList => isBucketListSelected ? _bucketList : _blackList;
  List<bool> get _currentChecked => isBucketListSelected ? _bucketListChecked : _blackListChecked;

  Widget screenTitle() {
    const selectedColor = Color(0xFF56537C);
    const unselectedColor = Color(0xFFD7D5EE);

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
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 2),
                decoration: BoxDecoration(
                  color: isBucketListSelected ? selectedColor : unselectedColor,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: borderColor, width: 1.0),
                  boxShadow: isBucketListSelected
                      ? [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))]
                      : null,
                ),
                child: Center(
                  child: Text(
                    'Bucketlisted',
                    style: TextStyle(
                      color: isBucketListSelected ? Colors.white : Color(0xff000000),
                      fontFamily: "Inter",
                      fontSize: 14,
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
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                margin: const EdgeInsets.only(left: 2),
                decoration: BoxDecoration(
                  color: isBucketListSelected ? unselectedColor : selectedColor,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: borderColor, width: 1.0),
                  boxShadow: !isBucketListSelected
                      ? [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))]
                      : null,
                ),
                child: Center(
                  child: Text(
                    'Blacklisted',
                    style: TextStyle(
                      color: isBucketListSelected ? Color(0xff000000) : Colors.white,
                      fontFamily: "Inter",
                      fontSize: 14,
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
    final TextEditingController _textController = TextEditingController(text: currentItem);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
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
                                  _bucketList.add(_textController.text);
                                  _bucketListChecked.add(false);
                                } else {
                                  _blackList.add(_textController.text);
                                  _blackListChecked.add(false);
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Jua',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Record the things you want to do over the year.",
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: screenTitle(),
            ),
            // Checklist for Bucketlist or Blacklist based on selection
            if (_currentList.isNotEmpty)
              Container(
                padding: EdgeInsets.only(left: 0.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _currentList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Card(
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
                              title: Text(_currentList[index]),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: 25, // Adjust maxWidth as needed
                                      maxHeight: 30, // Ensure the buttons are consistent in size
                                    ),
                                    child: IconButton(
                                      iconSize: 20.0,
                                      padding: EdgeInsets.zero,
                                      icon: Icon(Icons.edit, color: Colors.black),
                                      onPressed: () => _editItem(index),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: 30, // Same width for consistency
                                      maxHeight: 30,
                                    ),
                                    child: IconButton(
                                      iconSize: 20.0,
                                      padding: EdgeInsets.zero,
                                      icon: Icon(Icons.delete, color: Colors.black),
                                      onPressed: () => _deleteItem(index),
                                    ),
                                  ),
                                ],
                              ),
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
                children: [
                  Transform.translate(
                    offset: Offset(0, 50), // Adjust x and y values to move the image
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(isBucketListSelected
                              ? 'lib/assets/images/backgrounds/Default_Bucketlisted.png'
                              : 'lib/assets/images/backgrounds/Default_Blacklisted.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Transform.translate(
                    offset: Offset(0, 30), // Adjust x and y values to move the text
                    child: Text(
                      "No items here yet.\nShare the things you want to do!",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: 'Jua',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: FloatingActionButton(
            onPressed: _showAddItemBottomSheet,
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }
}
