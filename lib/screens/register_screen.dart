import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../main.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isChecked = false;

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
              margin: EdgeInsets.only(top: 6, left: 20, right: 20),
              child: Text(
                "FreedFromWalls",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "REGISTER",
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

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            //Space
            Flexible(
              fit: FlexFit.loose,
              child: SizedBox(
                height: height * 0.10,
              ),
            ),

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
                  "REGISTER",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
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
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Already have an account? Go back to login page",
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
