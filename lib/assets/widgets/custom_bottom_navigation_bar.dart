import 'package:flutter/material.dart';

//ignore: must_be_immutable
class CustomBottomNavigationBar extends StatefulWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;

  const CustomBottomNavigationBar({
    super.key,
    required this.onItemSelected,
    required this.selectedIndex,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5), // Shadow color
            spreadRadius: 3,
            blurRadius: 15,
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: NavigationBarTheme(
        data: const NavigationBarThemeData(
            labelTextStyle: WidgetStatePropertyAll(TextStyle(
          fontSize: 10,
        ))),
        child: NavigationBar(
          onDestinationSelected: (int idx) {
            widget.onItemSelected(idx);
          },
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          backgroundColor: Colors.white,
          indicatorColor: Colors.black87,
          selectedIndex: widget.selectedIndex,
          destinations: <Widget>[
            NavigationDestination(
              icon: Icon(
                Icons.home,
                color:
                    widget.selectedIndex == 0 ? Colors.white : Colors.black87,
              ),
              label: 'HOME',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.format_list_bulleted,
                color:
                    widget.selectedIndex == 1 ? Colors.white : Colors.black87,
              ),
              label: 'LIST',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.add_circle,
                color:
                    widget.selectedIndex == 2 ? Colors.white : Colors.black87,
              ),
              label: 'JOURNAL',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.emoji_events,
                color:
                    widget.selectedIndex == 3 ? Colors.white : Colors.black87,
              ),
              label: 'REMINDERS',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.people,
                color:
                    widget.selectedIndex == 4 ? Colors.white : Colors.black87,
              ),
              label: "PROFILE",
            ),
          ],
        ),
      ),
    );
  }
}
