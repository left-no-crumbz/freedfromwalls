import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String bio;
  final String avatarPath;
  final Map<String, String> favorites;

  const EditProfileScreen({
    super.key,
    required this.name,
    required this.bio,
    required this.avatarPath,
    required this.favorites,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController bioController;
  late String chosenImagePath;
  late Map<String, TextEditingController> favoritesControllers;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    bioController = TextEditingController(text: widget.bio);
    chosenImagePath = widget.avatarPath;
    favoritesControllers = widget.favorites
        .map((key, value) => MapEntry(key, TextEditingController(text: value)));
  }

  bool _validateInputs() {
    if (nameController.text.trim().isEmpty ||
        bioController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name and Bio cannot be blank')),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "FreedFrom Walls",
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "User Profile",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Expanded(child: SizedBox()),
                ElevatedButton(
                  onPressed: () {
                    if (_validateInputs()) {
                      Navigator.pop(context, {
                        'name': nameController.text,
                        'bio': bioController.text,
                        'avatarPath': chosenImagePath,
                        'favorites': favoritesControllers.map(
                            (key, controller) =>
                                MapEntry(key, controller.text)),
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).cardColor,
                      side: const BorderSide(color: Colors.black, width: 1.5)),
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.displaySmall?.color,
                        fontFamily: "RethinkSans",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 1, child: Divider(color: Colors.black)),
          AvatarSelector(
            initialAvatarPath: chosenImagePath,
            onAvatarSelected: (String path) {
              setState(() {
                chosenImagePath = path;
              });
            },
          ),
          PersonalContainer(
            nameController: nameController,
            bioController: bioController,
            favoritesControllers: favoritesControllers,
          )
        ],
      ),
    );
  }
}

class AvatarSelector extends StatefulWidget {
  final String initialAvatarPath;
  final Function(String) onAvatarSelected;

  const AvatarSelector({
    super.key,
    required this.initialAvatarPath,
    required this.onAvatarSelected,
  });

  static const int numberOfAvatars = 12;
  static final List<String> avatarList = List.generate(numberOfAvatars,
      (index) => "lib/assets/images/avatars/avatar-${index + 1}.png");

  @override
  State<AvatarSelector> createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  late String chosenImagePath;

  @override
  void initState() {
    super.initState();
    chosenImagePath = widget.initialAvatarPath;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: [
          const Text(
            "Choose Your Avatar",
            style: TextStyle(
              fontSize: 15,
              fontFamily: "RethinkSans",
              fontWeight: FontWeight.bold,
            ),
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
                      widget.onAvatarSelected(chosenImagePath);
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
      ),
    );
  }
}

class InformationField extends StatefulWidget {
  final String? hintText;
  final String? field;
  final TextEditingController informationController;
  final Icon? prefixIcon;
  final bool readOnly;

  const InformationField({
    super.key,
    required this.hintText,
    required this.field,
    required this.informationController,
    this.prefixIcon,
    this.readOnly = false,
  });

  @override
  State<InformationField> createState() => _InformationFieldState();
}

class _InformationFieldState extends State<InformationField> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        widget.informationController.text = DateFormat('yMMMMd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.field ?? "Field",
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xffBABABA),
              fontFamily: "RethinkSans",
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 25,
            child: TextField(
              controller: widget.informationController,
              readOnly: widget.readOnly,
              style: const TextStyle(
                  fontFamily: "RethinkSans", fontWeight: FontWeight.w500),
              onTap: widget.readOnly && widget.field == "Birthday"
                  ? () => _selectDate(context)
                  : null,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff000000))),
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  fontSize: 15,
                  fontFamily: "RethinkSans",
                ),
                isDense: true,
                prefixIconConstraints: BoxConstraints(maxWidth: 30),
                prefixIcon: widget.prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: widget.prefixIcon,
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PersonalContainer extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController bioController;
  final Map<String, TextEditingController> favoritesControllers;

  const PersonalContainer({
    super.key,
    required this.nameController,
    required this.bioController,
    required this.favoritesControllers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        const Align(
            alignment: Alignment.center, child: Text("Personal Information")),
        const SizedBox(height: 16),
        InformationField(
          hintText: "Name cannot be blank",
          field: "Name",
          informationController: nameController,
        ),
        const SizedBox(height: 16),
        InformationField(
          hintText: "Bio cannot be blank",
          field: "Bio",
          informationController: bioController,
        ),
        const SizedBox(height: 16),
        InformationField(
          hintText: "",
          field: "Birthday",
          informationController: TextEditingController(),
          readOnly: true,
          prefixIcon: const Icon(Icons.calendar_month, size: 20),
        ),
        const SizedBox(height: 32),
        const Align(
            alignment: Alignment.center, child: Text("Personal Preference")),
        const SizedBox(height: 16),
        ...favoritesControllers.entries
            .map((entry) => Column(
                  children: [
                    InformationField(
                      hintText: "Insert something here.",
                      field: entry.key,
                      informationController: entry.value,
                    ),
                    const SizedBox(height: 16),
                  ],
                ))
            .toList(),
        const SizedBox(height: 32),
      ],
    );
  }
}
