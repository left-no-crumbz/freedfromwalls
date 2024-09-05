import 'package:flutter/material.dart';
import '../assets/widgets/screen_title.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const dividerColor = Color(0xFF423e3d);
  static const scaffoldBackgroundColor = Color(0xFFF1F3F4);

  final TextEditingController mottoController = TextEditingController();
  final TextEditingController foodController = TextEditingController();
  final TextEditingController drinkController = TextEditingController();
  final TextEditingController filmController = TextEditingController();
  final TextEditingController songController = TextEditingController();
  final TextEditingController showController = TextEditingController();
  final TextEditingController bookController = TextEditingController();
  final TextEditingController gameController = TextEditingController();
  final TextEditingController colorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter",
        scaffoldBackgroundColor: scaffoldBackgroundColor,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                const ScreenTitle(
                  title: "USER PROFILE",
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .9, // 90% width
                  height: MediaQuery.of(context).size.height * .9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: dividerColor),
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 30,
                        padding: const EdgeInsets.only(left: 16, right: 4),
                        child: Row(
                          children: [
                            const Text(
                              'All About Nickname',
                              style: TextStyle(fontSize: 14),
                            ),
                            const Expanded(child: SizedBox()),
                            IconButton(
                              iconSize: 24, // Increased icon size
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                setState(() {
                                  // TODO: Add functionality here
                                });
                              },
                              constraints: const BoxConstraints.tightFor(
                                width: 24,
                                height: 24,
                              ),
                              icon: const Icon(Icons.edit_note),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 2,
                        color: dividerColor,
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(16.0),
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "lib/assets/images/sample picture.png",
                                  width: 120, // Increased image size
                                  height: 120,
                                ),
                                const SizedBox(width: 24), // Increased spacing
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "SURNAME,",
                                        style: TextStyle(
                                          fontSize: 14, // Larger text for name
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "First Name Second Name Middle Name",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(height: 8),
                                      Text("Age"),
                                      SizedBox(height: 8),
                                      Text("Birthday"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            const Text("Nationality"),
                            const SizedBox(height: 8),
                            const Text("Religion"),
                            const SizedBox(height: 8), // Increased spacing
                            const Text("Address"),
                            const SizedBox(height: 8), // Increased spacing
                            const Text("Contact Number"),
                            const SizedBox(height: 8), // Increased spacing
                            const Text("Email Address"),
                            const SizedBox(height: 24), // Increased spacing
                            Container(
                              width: MediaQuery.of(context).size.width *
                                  .8, // 80% width
                              height: MediaQuery.of(context).size.height * .5,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: dividerColor),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    16.0), // Adjust the padding as needed
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Personal Preferences',
                                      style: TextStyle(
                                        fontSize:
                                            20, // Larger text for section title
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Divider(
                                      height: 2,
                                      color: dividerColor,
                                    ),
                                    const SizedBox(
                                        height: 8), // Increased spacing
                                    TextField(
                                      controller: mottoController,
                                      decoration: const InputDecoration(
                                        labelText: 'Personal Motto',
                                        labelStyle:
                                            TextStyle(color: Colors.black38),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                    const SizedBox(
                                        height: 8), // Increased spacing
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: foodController,
                                            decoration: const InputDecoration(
                                              labelText: 'Favorite Food',
                                              labelStyle: TextStyle(
                                                  color: Colors.black38),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: TextField(
                                            controller: drinkController,
                                            decoration: const InputDecoration(
                                              labelText: 'Favorite Drink',
                                              labelStyle: TextStyle(
                                                  color: Colors.black38),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: 8), // Increased spacing
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: filmController,
                                            decoration: const InputDecoration(
                                              labelText: 'Favorite Film',
                                              labelStyle: TextStyle(
                                                  color: Colors.black38),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: TextField(
                                            controller: showController,
                                            decoration: const InputDecoration(
                                              labelText: 'Favorite Show',
                                              labelStyle: TextStyle(
                                                  color: Colors.black38),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: 8), // Increased spacing
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: songController,
                                            decoration: const InputDecoration(
                                              labelText: 'Favorite Song',
                                              labelStyle: TextStyle(
                                                  color: Colors.black38),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: TextField(
                                            controller: bookController,
                                            decoration: const InputDecoration(
                                              labelText: 'Favorite Book',
                                              labelStyle: TextStyle(
                                                  color: Colors.black38),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: 8), // Increased spacing
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: gameController,
                                            decoration: const InputDecoration(
                                              labelText: 'Favorite Game',
                                              labelStyle: TextStyle(
                                                  color: Colors.black38),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: TextField(
                                            controller: colorController,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            decoration: const InputDecoration(
                                              labelText: 'Favorite Color',
                                              labelStyle: TextStyle(
                                                  color: Colors.black38),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
