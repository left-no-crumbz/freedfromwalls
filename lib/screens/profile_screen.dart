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
      body: ListView(
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
          ),
          Image.asset(
            "lib/assets/images/avatars/avatar-1.png",
            height: 200,
            width: 200,
          ),
          const SizedBox(height: 16),
          const NameBio(),
          const SizedBox(height: 16),
          const Favorite(keyStr: "Motto", value: "Favorite Motto"),
          const Favorite(keyStr: "Food", value: "Favorite Food"),
          const Favorite(keyStr: "Drink", value: "Favorite Drink"),
          const Favorite(keyStr: "Film", value: "Favorite Film"),
          const Favorite(keyStr: "Show", value: "Favorite Show"),
          const Favorite(keyStr: "Song", value: "Favorite Song"),
          const Favorite(keyStr: "Game", value: "Favorite Game"),
          const Favorite(keyStr: "Book", value: "Favorite Book"),
          const Favorite(keyStr: "Color", value: "Favorite Color"),
          const Divider(color: Colors.grey),
          const SizedBox(height: 32)
        ],
      ),
    );
  }
}

class NameBio extends StatefulWidget {
  const NameBio({super.key});

  @override
  State<NameBio> createState() => _NameBioState();
}

class _NameBioState extends State<NameBio> {
  String? name;
  String? bio;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name ?? "Name",
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          bio ?? "Bio",
          style: const TextStyle(fontSize: 14),
        )
      ],
    );
  }
}

class Favorite extends StatefulWidget {
  final String keyStr;
  final String value;
  const Favorite({super.key, required this.keyStr, required this.value});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Divider(color: Colors.grey),
          Table(
            columnWidths: const {
              0: FixedColumnWidth(100),
              1: FlexColumnWidth(),
            },
            children: [
              TableRow(
                children: [
                  Text(
                    widget.keyStr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Color(0xff9C98CB)),
                  ),
                  Text(widget.value),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
