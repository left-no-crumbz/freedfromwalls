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
        border: Border(
          top: BorderSide(width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5), // Shadow color
            spreadRadius: 3,
            blurRadius: 15,
            offset: const Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: NavigationBar(
        onDestinationSelected: (int idx) {
          widget.onItemSelected(idx);
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: Color(0xFFD9D9D9),
        indicatorColor: Colors.transparent,
        selectedIndex: widget.selectedIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: Icon(
              widget.selectedIndex == 0 ? Icons.home : Icons.home_outlined,
              color: Colors.black87,
            ),
            label: 'HOME',
          ),
          NavigationDestination(
            icon: Icon(
              widget.selectedIndex == 1 ? Icons.list : Icons.list_alt_rounded,
              color: Colors.black87,
            ),
            label: 'LIST',
          ),
          NavigationDestination(
            icon: Icon(
              widget.selectedIndex == 2 ? Icons.add_circle : Icons.add_circle_outline,
              color: Colors.black87,
            ),
            label: 'JOURNAL',
          ),
          NavigationDestination(
            icon: Icon(
              widget.selectedIndex == 3 ? Icons.emoji_events : Icons.emoji_events_outlined,
              color: Colors.black87,
            ),
            label: 'REMINDERS',
          ),
          NavigationDestination(
            icon: Icon(
              widget.selectedIndex == 4 ? Icons.person : Icons.person_outline,
              color: Colors.black87,
            ),
            label: "PROFILE",
          ),
        ],
      ),
    );
  }
}
