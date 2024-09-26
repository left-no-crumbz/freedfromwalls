import 'package:flutter/material.dart';
import '../assets/widgets/title_description.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              const TitleDescription(
                  title: "Profile", description: "All about yourself"),
              const Expanded(child: SizedBox()),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "EDIT",
                  style: const TextStyle(color: const Color(0xffD7D5EE)),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff56537C),
                    side: BorderSide(color: Colors.black, width: 1.5)),
              ),
              const SizedBox(width: 16),
            ],
          )
        ],
      ),
    );
  }
}
