import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../assets/widgets/title_description.dart';
import './edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Name";
  String bio = "Bio";
  String avatarPath = "lib/assets/images/avatars/avatar-1.png";
  Map<String, String> favorites = {
    "Motto": "Favorite Motto",
    "Food": "Favorite Food",
    "Drink": "Favorite Drink",
    "Film": "Favorite Film",
    "Show": "Favorite Show",
    "Song": "Favorite Song",
    "Game": "Favorite Game",
    "Book": "Favorite Book",
    "Color": "Favorite Color",
  };

  final FlutterSecureStorage localStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

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
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        name: name,
                        bio: bio,
                        avatarPath: avatarPath,
                        favorites: favorites,
                      ),
                    ),
                  );
                  if (result != null) {
                    localStorage.write(key: 'name', value: result['name']);
                    localStorage.write(key: 'bio', value: result['bio']);
                    localStorage.write(
                        key: 'avatarPath', value: result['avatarPath']);

                    result['favorites'].forEach((key, value) {
                      localStorage.write(key: 'key', value: value);
                    });

                    setState(() {
                      name = result['name'];
                      bio = result['bio'];
                      avatarPath = result['avatarPath'];
                      favorites = Map<String, String>.from(result['favorites']);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).cardColor,
                    side: BorderSide(color: Colors.black, width: 1.5)),
                child: Text(
                  "EDIT",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.displaySmall?.color,
                      fontFamily: "RethinkSans",
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          Image.asset(
            avatarPath,
            height: 200,
            width: 200,
          ),
          const SizedBox(height: 16),
          NameBio(name: name, bio: bio),
          const SizedBox(height: 16),
          ...favorites.entries
              .map((entry) => Favorite(keyStr: entry.key, value: entry.value))
              .toList(),
          const Divider(color: Colors.grey),
          const SizedBox(height: 32)
        ],
      ),
    );
  }
}

class NameBio extends StatefulWidget {
  final String name;
  final String bio;
  const NameBio({super.key, required this.name, required this.bio});

  @override
  State<NameBio> createState() => _NameBioState();
}

class _NameBioState extends State<NameBio> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.name,
          style: const TextStyle(fontSize: 20, fontFamily: "Jua"),
        ),
        Text(
          widget.bio,
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
                    style: TextStyle(
                        color: Theme.of(context).textTheme.displayMedium?.color,
                        fontFamily: "RethinkSans",
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.value,
                    style: const TextStyle(
                        fontFamily: "RethinkSans", fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
