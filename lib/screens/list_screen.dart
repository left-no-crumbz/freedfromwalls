import 'package:flutter/material.dart';
import '../assets/widgets/unordered_list.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool isBucketListSelected = true;

  static const scaffoldBackgroundColor = Color(0xFFF1F3F4);
  static const borderColor = Color(0xff423e3d);
  static const borderWidth = 5.0;
  static const containerPadding = EdgeInsets.all(1);
  static const containerMargin = EdgeInsets.only(bottom: 20);

  bool _isEditing = false;
  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
    // TODO: Save data to database when editing is done
  }

  final List<TextEditingController> _endOfDayControllers = [];
  final List<TextEditingController> _endOfMonthControllers = [];
  final List<TextEditingController> _endOfYearControllers = [];

  @override
  void initState() {
    super.initState();
    for (var text in [
      "Sample 1",
      "Sample 2",
      "Sample 3",
      "Sample 4",
      "Sample 5"
    ]) {
      _endOfDayControllers.add(TextEditingController(text: text));
      _endOfMonthControllers.add(TextEditingController(text: text));
      _endOfYearControllers.add(TextEditingController(text: text));
    }
  }

  Widget screenTitle() {
    const backgroundColor = Color(0xff2d2d2d);
    const selectedColor = Color(0xffd9d9d9);
    const unselectedColor = Color(0xffffffff);

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      width: MediaQuery.of(context).size.width * .90,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isBucketListSelected = true;
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isBucketListSelected ? selectedColor : unselectedColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                  border: const Border(
                    right: BorderSide(
                      color: borderColor,
                      width: borderWidth,
                    ),
                  ),
                ),
                child: Text(
                  'BUCKETLIST'.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xff000000),
                    fontFamily: "Inter",
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isBucketListSelected = false;
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isBucketListSelected ? unselectedColor : selectedColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: Text(
                  'BLACKLIST'.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xff000000),
                    fontFamily: "Inter",
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSection(String title, int itemCount, bool isBucketList,
      List<TextEditingController> controller) {
    final backgroundColor =
        isBucketList ? Colors.white : const Color(0xff2d2d2d);
    final textColor = isBucketList ? Colors.black : Colors.white;
    final lineColor = isBucketList ? Colors.grey : Colors.white;
    final iconColor = isBucketList ? Colors.black : Colors.white;

    return Expanded(
      flex: 1,
      child: Container(
        padding: containerPadding,
        margin: containerMargin,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(5),
          color: backgroundColor,
        ),
        width: MediaQuery.of(context).size.width * .90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10, right: 3),
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 12, color: textColor),
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    onPressed: _toggleEditMode,
                    constraints:
                        const BoxConstraints.tightFor(width: 20, height: 20),
                    icon: _isEditing
                        ? Icon(
                            Icons.check,
                            color: iconColor,
                          )
                        : Icon(
                            Icons.edit_note,
                            color: iconColor,
                          ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: lineColor,
            ),
            const SizedBox(height: 10),
            // TODO: Refactor this to use UnorderedList widget
            UnorderedList(
              controllers: controller,
              isEditing: _isEditing,
              textColor: textColor,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String dayTitle = isBucketListSelected
        ? 'By the end of each DAY, I must...'
        : 'By the end of each DAY, I must not...';

    String monthTitle = isBucketListSelected
        ? 'By the end of each MONTH, I must...'
        : 'By the end of each MONTH, I must not...';

    String yearTitle = isBucketListSelected
        ? 'By the end of each YEAR, I must...'
        : 'By the end of each YEAR, I must not...';

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Column(
        children: [
          screenTitle(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  buildSection(
                      dayTitle, 5, isBucketListSelected, _endOfDayControllers),
                  buildSection(monthTitle, 5, isBucketListSelected,
                      _endOfMonthControllers),
                  buildSection(yearTitle, 5, isBucketListSelected,
                      _endOfYearControllers),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
