import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freedfromwalls/providers/user_provider.dart';
import 'package:freedfromwalls/screens/intro_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../assets/widgets/customThemes.dart';
import '../main.dart';
import '../models/user.dart';

class OnboardingPage extends StatefulWidget {
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  //Controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final _localStorage = FlutterSecureStorage();

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2200));

    if (_picked != null) {
      UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

      final formattedDate = DateFormat('yMMMMd').format(_picked);
      await _localStorage.write(
          key: '${user!.email}_birthday', value: formattedDate);

      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  void _confirm() async {
    String username = _usernameController.text;
    String birthday = _dateController.text;

    if (username.isNotEmpty && birthday.isNotEmpty) {
      UserModel? user = Provider.of<UserProvider>(context, listen: false).user;

      await _localStorage.write(key: '${user!.email}_name', value: username);

      // Store birthday in secure storage
      // await _localStorage.write(key: '${user.email}_birthday', value: birthday);

      // TODO: PushandRemoveUntil

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => IntroPage(),
        ),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error: Empty Field."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.grey[100],
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Welcome to FreedFromWalls!",
                      style: TextStyle(
                          fontSize:
                              AppThemes.getResponsiveFontSize(context, 16),
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Your Virtual Diary and Virtual Company~",
                      style: TextStyle(
                          fontSize:
                              AppThemes.getResponsiveFontSize(context, 16),
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),

            //Space
            Flexible(
              fit: FlexFit.loose,
              child: SizedBox(
                height: height,
              ),
            ),

            //Inputs
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.transparent,
                      child: Text(
                        "Please enter your name:",
                        style: TextStyle(
                            fontSize:
                                AppThemes.getResponsiveFontSize(context, 12),
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(2, 4),
                        ),
                      ]),
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: "Your Name",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(0xFFF1F1F1),
                    ),
                  ),
                ),
              ],
            ),

            //Space
            Flexible(
              fit: FlexFit.loose,
              child: SizedBox(
                height: height,
              ),
            ),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.transparent,
                      child: Text(
                        "Your Birthday",
                        style: TextStyle(
                            fontSize:
                                AppThemes.getResponsiveFontSize(context, 12),
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(2, 4),
                        ),
                      ]),
                  child: TextField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: _selectDate,
                    decoration: InputDecoration(
                      labelText: "Select Date...",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(0xFFF1F1F1),
                      prefixIcon: Icon(Icons.calendar_month),
                    ),
                  ),
                ),
              ],
            ),

            //Space
            Flexible(
              fit: FlexFit.loose,
              child: SizedBox(
                height: height,
              ),
            ),

            Container(
              width: width * 0.45,
              child: ElevatedButton(
                onPressed: _confirm,
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    backgroundColor: Color(0xffD7D5EE),
                    side: BorderSide(
                      color: Colors.black,
                      width: 1,
                    )),
                child: Text(
                  "CONTINUE",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: AppThemes.getResponsiveFontSize(context, 16)),
                ),
              ),
            ),

            //Space
            Flexible(
              fit: FlexFit.loose,
              child: SizedBox(
                height: height,
              ),
            ),

            Container(
              height: height * 0.17,
              margin: EdgeInsets.only(bottom: height * 0.01),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: height * 0.09,
                    backgroundColor: Color(0xFF3A375E),
                  ),
                  CircleAvatar(
                    radius: height * 0.075,
                    backgroundColor: Color(0xFF56537C),
                  ),
                  CircleAvatar(
                    radius: height * 0.06,
                    backgroundColor: Color(0xFF9C98CB),
                  ),
                  CircleAvatar(
                    radius: height * 0.045,
                    backgroundColor: Color(0xFFD7D5EE),
                  ),
                ],
              ),
            ),

            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: height * 0.30,
                  width: width,
                  decoration: BoxDecoration(
                    color: Color(0xFF3A375E),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(500)),
                  ),
                ),
                Container(
                  height: height * 0.27,
                  width: width * 0.85,
                  decoration: BoxDecoration(
                    color: Color(0xFF56537C),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(400)),
                  ),
                ),
                Container(
                  height: height * 0.24,
                  width: width * 0.75,
                  decoration: BoxDecoration(
                    color: Color(0xFF9C98CB),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(350)),
                  ),
                ),
                Container(
                  height: height * 0.21,
                  width: width * 0.65,
                  decoration: BoxDecoration(
                    color: Color(0xFFD7D5EE),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(300)),
                  ),
                ),
                Container(
                  height: height * 0.18,
                  width: width * 0.55,
                  decoration: BoxDecoration(
                    color: Color(0xFFEFEEFF),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(200)),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
