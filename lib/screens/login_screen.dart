import 'package:flutter/material.dart';
import '../main.dart';
import 'register_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: ListView(
          children: [
            Expanded(
                child: Column(
              children: [
                // Title Text
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
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                // Remember me checkbox
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        activeColor:
                            isChecked ? Color(0xff2d2d2d) : Colors.white,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Text("Remember me"),
                    ],
                  ),
                ),
              ],
            )),

            // Login Button
            Container(
              width: width * 0.35, // Set button width and height as a circle
              height: width * 0.35,
              margin: EdgeInsets.symmetric(vertical: 15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FreedFromWallsApp(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    backgroundColor: Color(0xff2d2d2d)),
                child: Text(
                  "LOG IN",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
            ),

            Container(
              height: height * 0.36,
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
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
