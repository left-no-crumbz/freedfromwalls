import 'package:flutter/material.dart';
import 'package:freedfromwalls/screens/onboarding_screen.dart';
import 'login_screen.dart';
import '../main.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isShown1 = false; // Password visibility
  bool _isShown2 = false; // Confirm password visibility

  //Controllers
  final TextEditingController _confPassController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  //Register function
  void _register() {
    String confirmPass = _confPassController.text;
    String password = _passController.text;
    String email = _emailController.text;

    if (password.isNotEmpty && confirmPass.isNotEmpty && email.isNotEmpty) {
      if (password == confirmPass) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OnboardingPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error: Please confirm your password."),
        ));
      }
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error: Empty field."),
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
              child: Text(
                "REGISTER",
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
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFF1F1F1),
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
                obscureText: _isShown1 ? false : true,
                controller: _passController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFF1F1F1),
                  suffixIcon: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: IconButton(
                      icon: Icon(
                        _isShown1 ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isShown1 = !_isShown1;
                        });
                      },
                    ),
                  ),
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
                obscureText: _isShown2 ? false : true,
                controller: _confPassController,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFF1F1F1),
                  suffixIcon: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: IconButton(
                      icon: Icon(
                        _isShown2 ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isShown2 = !_isShown2;
                        });
                      },
                    ),
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
              width: width * 0.35,
              child: ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    backgroundColor: Color(0xffD7D5EE),
                    side: BorderSide(
                      color: Colors.black,
                      width: 1,
                    )
                ),
                child: Text(
                  "REGISTER",
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
                  height: height * 0.05,
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
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          Text(
                            "Return to Login Page.",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          )
                        ],
                      )
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
