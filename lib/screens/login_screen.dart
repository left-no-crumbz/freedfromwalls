import 'package:flutter/material.dart';
import '../main.dart';
import 'register_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isChecked = false; // Remember me button
  bool _isShown = false; // Password visibility

  //Controllers
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  //Temporary username and pass
  final String _username = 'Kyle';
  final String _password = 'admin12345';

  //login function
  void _login() {
    String email = _userController.text;
    String password = _passController.text;

    if (email == _username && password == _password) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FreedFromWallsApp(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Incorrect email or password"),
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
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                "FreedFromWalls",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
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
              child: TextField(
                controller: _userController,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                obscureText: _isShown ? false : true,
                controller: _passController,
                decoration: InputDecoration(
                  labelText: "Password",
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

            // Login Button
            Container(
              width: width * 0.35, // Set button width and height as a circle
              height: width * 0.35,
              margin: EdgeInsets.symmetric(vertical: 15),
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    backgroundColor: Color(0xff2d2d2d)),
                child: Text(
                  "LOG IN",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),
                ),
              ),
            ),

            Container(
              height: height * 0.33,
              width: width,
              decoration: BoxDecoration(
                color: Color(0xff2d2d2d),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(height),
                    topRight: Radius.circular(height)),
              ),
              child: Container(
                  height: height * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
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
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ));
  }
}
