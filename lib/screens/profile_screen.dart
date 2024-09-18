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
  bool _isEditing = false;

  // ALL ABOUT NICKNAME
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bdayController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();

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
                  height: 770,
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
                                  _isEditing = !_isEditing;
                                });
                              },
                              constraints: const BoxConstraints.tightFor(
                                width: 24,
                                height: 24,
                              ),
                              icon: Icon(
                                  _isEditing ? Icons.check : Icons.edit_note),
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
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "lib/assets/images/sample picture.png",
                                    width: 120, // Increased image size
                                    height: 120,
                                  ),
                                  const SizedBox(
                                      width: 24), // Increased spacing
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // TODO: Refactor into TextField
                                        EditableTextField(
                                          controller: nameController,
                                          maxLines: 3,
                                          hintText:
                                              "SURNAME, First Name Second Name Middle Name",
                                          isEditing: _isEditing,
                                        ),

                                        SizedBox(
                                          height: 20,
                                          child: EditableTextField(
                                            controller: ageController,
                                            hintText: "Age",
                                            isEditing: _isEditing,
                                          ),
                                        ),

                                        SizedBox(
                                          height: 30,
                                          child: EditableTextField(
                                            controller: bdayController,
                                            hintText: "Birthday",
                                            isEditing: _isEditing,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                height: 20,
                                child: EditableTextField(
                                  controller: nationalityController,
                                  hintText: "Nationality",
                                  isEditing: _isEditing,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 20,
                                child: EditableTextField(
                                  controller: religionController,
                                  hintText: "Religion",
                                  isEditing: _isEditing,
                                ),
                              ),
                              const SizedBox(height: 8), // Increased spacing
                              SizedBox(
                                height: 20,
                                child: EditableTextField(
                                  controller: addressController,
                                  hintText: "Address",
                                  isEditing: _isEditing,
                                ),
                              ),
                              const SizedBox(height: 8), // Increased spacing
                              SizedBox(
                                height: 20,
                                child: EditableTextField(
                                  controller: contactNumberController,
                                  hintText: "Contact Number",
                                  isEditing: _isEditing,
                                ),
                              ),
                              const SizedBox(height: 8), // Increased spacing
                              SizedBox(
                                height: 20,
                                child: EditableTextField(
                                  controller: emailAddressController,
                                  hintText: "Email Address",
                                  isEditing: _isEditing,
                                ),
                              ),
                              const SizedBox(height: 24), // Increased spacing
                              Container(
                                width: MediaQuery.of(context).size.width *
                                    .8, // 80% width
                                height:
                                    MediaQuery.of(context).size.height * .48,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: dividerColor),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      16.0), // Adjust the padding as needed
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      const SizedBox(height: 8),

                                      EditableTextField(
                                        controller: mottoController,
                                        isEditing: _isEditing,
                                        labelText: "Personal Motto",
                                      ),

                                      const SizedBox(
                                          height: 8), // Increased spacing
                                      Row(
                                        children: [
                                          Expanded(
                                            child: EditableTextField(
                                              controller: foodController,
                                              isEditing: _isEditing,
                                              labelText: "Favorite Food",
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: EditableTextField(
                                              controller: drinkController,
                                              isEditing: _isEditing,
                                              labelText: "Favorite Drink",
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                          height: 8), // Increased spacing
                                      Row(
                                        children: [
                                          Expanded(
                                            child: EditableTextField(
                                              controller: filmController,
                                              isEditing: _isEditing,
                                              labelText: "Favorite Film",
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: EditableTextField(
                                              controller: showController,
                                              isEditing: _isEditing,
                                              labelText: "Favorite Show",
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                          height: 8), // Increased spacing
                                      Row(
                                        children: [
                                          Expanded(
                                            child: EditableTextField(
                                              controller: songController,
                                              isEditing: _isEditing,
                                              labelText: "Favorite Song",
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: EditableTextField(
                                              controller: bookController,
                                              isEditing: _isEditing,
                                              labelText: "Favorite Book",
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                          height: 8), // Increased spacing
                                      Row(
                                        children: [
                                          Expanded(
                                            child: EditableTextField(
                                              controller: gameController,
                                              isEditing: _isEditing,
                                              labelText: "Favorite Game",
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: EditableTextField(
                                              controller: colorController,
                                              isEditing: _isEditing,
                                              labelText: "Favorite Color",
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

class EditableTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isEditing;
  final String? hintText;
  final String? labelText;
  final int? maxLines;
  final FontWeight? fontWeight;

  const EditableTextField({
    Key? key,
    required this.controller,
    required this.isEditing,
    this.hintText,
    this.labelText,
    this.maxLines,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: isEditing,
      maxLines: maxLines ?? 1,
      style: TextStyle(
        fontSize: 14,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        labelText: labelText,
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: Colors.black.withOpacity(0.6),
        ),
        labelStyle: const TextStyle(color: Colors.black38),
      ),
    );
  }
}
