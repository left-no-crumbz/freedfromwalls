import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'register_screen.dart';
void main(){
  AwesomeNotifications().initialize(null,
    [
      NotificationChannel(channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic tests',),
    ],
    debug: true,
  );
}
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isChecked = false; // Remember me button
  bool _isShown = false; // Password visibility

  //Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  //Temporary username and pass
  final String _email = 'Kyle';
  final String _password = 'admin12345';

  //login function
  void _login() {
    String email = _emailController.text;
    String password = _passController.text;

    if (email == _email && password == _password) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FreedFromWallsApp(),
        ),
      );
    }
    else if (email.isEmpty && password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error: Empty Field."),
      ));
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error: Incorrect email or password."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    //Height and width of the Screen
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
              child: Text(
                "LOG IN",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),

            //Inputs
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
                  ]
              ),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  filled: true,
                  fillColor: Color(0xFFF1F1F1),
                  border: OutlineInputBorder(),
                ),
              ),
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
                  ]
              ),
              child: TextField(
                obscureText: _isShown ? false : true,
                controller: _passController,
                decoration: InputDecoration(
                  labelText: "Password",
                  filled: true,
                  fillColor: Color(0xFFF1F1F1),
                  border: OutlineInputBorder(),
                  suffixIcon: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: IconButton(
                      icon: Icon(
                        _isShown ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isShown = !_isShown;
                        });
                      },
                                    ),
                  ),
              ),
            ),
            ),

            // Remember me checkbox
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    activeColor:
                        _isChecked ? Color(0xff2d2d2d) : Colors.white,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                  Text("Remember me"),
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

            Container(
              width: width * 0.35,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    backgroundColor: Color(0xffD7D5EE),
                    side: BorderSide(
                      color: Colors.black,
                      width: 1,
                    )
                ),
                child: Text(
                  "LOG IN",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),
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
              height: height * 0.25,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: height * 0.10,
                    backgroundColor: Color(0xFF3A375E),
                  ),
                  CircleAvatar(
                    radius: height * 0.08,
                    backgroundColor: Color(0xFF56537C),
                  ),
                  CircleAvatar(
                    radius: height * 0.06,
                    backgroundColor: Color(0xFF9C98CB),
                  ),
                  CircleAvatar(
                    radius: height * 0.04,
                    backgroundColor: Color(0xFFD7D5EE),
                  ),
                ],
              ),
            ),

            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: height * 0.35,
                  width: width,
                  decoration: BoxDecoration(
                    color: Color(0xFF3A375E),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(500)),
                  ),
                ),
                Container(
                  height: height * 0.32,
                  width: width * 0.85,
                  decoration: BoxDecoration(
                    color: Color(0xFF56537C),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(400)),
                  ),
                ),
                Container(
                  height: height * 0.29,
                  width: width * 0.75,
                  decoration: BoxDecoration(
                    color: Color(0xFF9C98CB),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(350)),
                  ),
                ),
                Container(
                  height: height * 0.26,
                  width: width * 0.65,
                  decoration: BoxDecoration(
                    color: Color(0xFFD7D5EE),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(300)),
                  ),
                ),
                Container(
                  height: height * 0.23,
                  width: width * 0.55,
                  decoration: BoxDecoration(
                    color: Color(0xFFEFEEFF),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(200)),
                  ),
                ),
                Container(
                  height: height * 0.02,
                  width: width * 0.50,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.transparent
                  ),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Not a member? Sign up now.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      )
                  ),
                )
              ],
            ),
          ],
        )
    );
  }
}
