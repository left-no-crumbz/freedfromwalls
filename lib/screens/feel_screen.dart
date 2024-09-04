import 'package:flutter/material.dart';
import '../assets/widgets/screen_title.dart';

class FeelPage extends StatefulWidget {
  const FeelPage({super.key});

  @override
  State<FeelPage> createState() => _FeelPageState();
}

class _FeelPageState extends State<FeelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ScreenTitle(title: "FULFEELMENT"),
              // Motivational Text Container with vertical numbered circles
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(bottom: 16.0),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white, // Background color of the container
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the left
                  children: [
                    // Motivational Text with Icon
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Remind yourself of your achievements.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                            width:
                                8), // Space between the text and the first icon
                        Icon(
                          Icons.notifications, // Bell icon
                          size: 14,
                          color: Colors.black, // Adjust color if needed
                        ),
                        SizedBox(
                            width:
                                8), // Space between the first and second icon
                        Icon(
                          Icons.edit, // Replace 'Write' image with edit icon
                          size: 18,
                          color: Colors.black, // Adjust color if needed
                        ),
                      ],
                    ),
                    const SizedBox(
                        height:
                            10), // Space between Motivational Text and Win Count
                    // Win Count Text
                    const Text(
                      'Win Count: 6',
                      style: TextStyle(
                        fontSize: 24, // Increased size
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                        height: 20), // Space between Win Count Text and circles
                    // Vertical Numbered Circles with Text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(6, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20.0), // Space between circles
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                      width:
                                          16), // Space between circle and text
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'First Reminder Sample!',
                                          style: TextStyle(
                                            fontSize: 18, // Large font size
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                4), // Space between main text and description
                                        Text(
                                          'The first reminder sample description should be one sentence only, just make it brief.',
                                          style: TextStyle(
                                            fontSize: 10, // Smaller font size
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
