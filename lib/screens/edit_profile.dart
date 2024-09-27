import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "FreedFrom Walls",
          style: const TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "User Profile",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Expanded(child: const SizedBox()),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "SAVE",
                    style: const TextStyle(color: const Color(0xffD7D5EE)),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff56537C),
                      side: BorderSide(color: Colors.black, width: 1.5)),
                ),
              ],
            ),
          ),
          SizedBox(height: 1, child: const Divider(color: Colors.black)),
          const SizedBox(height: 16),
          const AvatarSelector(),
        ],
      ),
    );
  }
}

class AvatarSelector extends StatefulWidget {
  const AvatarSelector({super.key});
  static const int numberOfAvatars = 12;
  static final List<String> avatarList = List.generate(numberOfAvatars,
      (index) => "lib/assets/images/avatars/avatar-${index + 1}.png");

  @override
  State<AvatarSelector> createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  String chosenImagePath = "lib/assets/images/avatars/avatar-1.png";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Choose Your Avatar",
          style: const TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 16),
        Image.asset(
          chosenImagePath,
          height: 200,
          width: 200,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100, // Set a fixed height for the ListView
          child: ListView.builder(
            itemCount: 12,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      chosenImagePath = AvatarSelector.avatarList[index];
                    });
                  },
                  child: Image.asset(
                    AvatarSelector.avatarList[index],
                    height: 80,
                    width: 80,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
