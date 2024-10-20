import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:freedfromwalls/assets/widgets/customThemes.dart';
import 'package:freedfromwalls/controllers/login_controller.dart';
import 'package:freedfromwalls/models/user.dart';
import '../controllers/auth_service.dart';
import '../main.dart';
import 'register_screen.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic tests',
      ),
    ],
    debug: true,
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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

  final LoginController _loginController = LoginController();
  final FocusNode _focusNode = FocusNode();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadRememberedCredentials();
  }

  Future<void> _loadRememberedCredentials() async {
    final credentials = await _authService.getRememberedCredentials();
    if (credentials['email'] != null && credentials['password'] != null) {
      setState(() {
        _emailController.text = credentials['email']!;
        _passController.text = credentials['password']!;
        _isChecked = true;
      });
    }
  }

  // FIXME: Login not working in release mode
  // FIXME: Login not redirecting to main screen
  //login function
  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error: Empty Field."),
      ));
    }

    UserModel user = UserModel(
      email: email,
      password: password,
    );

    bool success = await _loginController.login(user);

    debugPrint("Login is successful: $success");
    debugPrint("Umaabot ba here after ng login");

    if (success) {
      if (_isChecked) {
        await _authService.saveCredentials(email, password);
        debugPrint("Credentials saved!");
      } else {
        await _authService.clearRememberedCredentials();
        debugPrint("Credentials removed!");
      }

      UserModel? updatedUser;

      try {
        debugPrint("Attempting to update the user");
        updatedUser = await _loginController.getUser(email);
        debugPrint("User updated successfully");
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Error: User is not authenticated."),
          ));
        }
        throw Exception("$e");
      }

      debugPrint("Umaabot ba here");

      if (mounted) {
        try {
          Provider.of<UserProvider>(context, listen: false)
              .setUser(updatedUser);
        } catch (e) {
          throw Exception("ERROR: $e");
        }
        debugPrint("How about here Umaabot ba here");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const FreedFromWallsApp(),
          ),
          (route) => false,
        );
      } else {
        debugPrint("ERROR: Context not mounted!");
      }
    } else if (email.isEmpty && password.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error: Empty Field."),
        ));
      } else {
        debugPrint("ERROR: Context not mounted!");
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error: Incorrect email or password."),
        ));
      } else {
        debugPrint("ERROR: Context not mounted!");
      }
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
                style: TextStyle(
                    fontSize: AppThemes.getResponsiveFontSize(context, 18),
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),

            //Inputs
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(1, 1),
                    ),
                  ]),
              child: TextField(
                onSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_focusNode);
                },
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  filled: true,
                  fillColor: Color(0xFFF1F1F1),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(1, 1),
                    ),
                  ]),
              child: TextField(
                focusNode: _focusNode,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _login(),
                obscureText: _isShown ? false : true,
                controller: _passController,
                decoration: InputDecoration(
                  labelText: "Password",
                  filled: true,
                  fillColor: const Color(0xFFF1F1F1),
                  border: const OutlineInputBorder(),
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
                        _isChecked ? const Color(0xff2d2d2d) : Colors.white,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                  Text(
                    "Remember me",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: AppThemes.getResponsiveFontSize(context, 12),
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

            SizedBox(
              width: width * 0.45,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color(0xffD7D5EE),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    )),
                child: Text(
                  "LOG IN",
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
                    backgroundColor: const Color(0xFF3A375E),
                  ),
                  CircleAvatar(
                    radius: height * 0.075,
                    backgroundColor: const Color(0xFF56537C),
                  ),
                  CircleAvatar(
                    radius: height * 0.06,
                    backgroundColor: const Color(0xFF9C98CB),
                  ),
                  CircleAvatar(
                    radius: height * 0.045,
                    backgroundColor: const Color(0xFFD7D5EE),
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
                    color: const Color(0xFF3A375E),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(500)),
                  ),
                ),
                Container(
                  height: height * 0.27,
                  width: width * 0.85,
                  decoration: const BoxDecoration(
                    color: Color(0xFF56537C),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(400)),
                  ),
                ),
                Container(
                  height: height * 0.24,
                  width: width * 0.75,
                  decoration: const BoxDecoration(
                    color: Color(0xFF9C98CB),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(350)),
                  ),
                ),
                Container(
                  height: height * 0.21,
                  width: width * 0.65,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD7D5EE),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(300)),
                  ),
                ),
                Container(
                  height: height * 0.18,
                  width: width * 0.55,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFEEFF),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(200)),
                  ),
                ),
                Container(
                  height: height * 0.05,
                  width: width * 0.50,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Not a member? Sign up now.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                AppThemes.getResponsiveFontSize(context, 11.5)),
                      )),
                )
              ],
            ),
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _focusNode.dispose();
  }
}
