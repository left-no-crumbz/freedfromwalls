import 'package:flutter/material.dart';
import '../assets/widgets/customThemes.dart';
import '../main.dart';

class IntroPage extends StatefulWidget {
  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.grey[100],
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            //Space
            Flexible(
              fit: FlexFit.loose,
              child: SizedBox(
                height: height,
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Seems like your all set!",
                style: TextStyle(fontSize: AppThemes.getResponsiveFontSize(context, 18), fontWeight: FontWeight.w500, color: Colors.black),
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Ready to spill your guts?",
                style: TextStyle(fontSize: AppThemes.getResponsiveFontSize(context, 24), fontWeight: FontWeight.w500, color: Colors.black),
              ),
            ),

            Container(
              width: width * 0.45,
              margin: EdgeInsets.only(top: 15),
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
                    padding: EdgeInsets.all(20),
                    backgroundColor: Color(0xffD7D5EE),
                    side: BorderSide(
                      color: Colors.black,
                      width: 1,
                    )
                ),
                child: Text(
                  "Let's Go!",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: AppThemes.getResponsiveFontSize(context, 16)
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
                    borderRadius: BorderRadius.vertical(top: Radius.circular(500)),
                  ),
                ),
                Container(
                  height: height * 0.27,
                  width: width * 0.85,
                  decoration: BoxDecoration(
                    color: Color(0xFF56537C),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(400)),
                  ),
                ),
                Container(
                  height: height * 0.24,
                  width: width * 0.75,
                  decoration: BoxDecoration(
                    color: Color(0xFF9C98CB),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(350)),
                  ),
                ),
                Container(
                  height: height * 0.21,
                  width: width * 0.65,
                  decoration: BoxDecoration(
                    color: Color(0xFFD7D5EE),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(300)),
                  ),
                ),
                Container(
                  height: height * 0.18,
                  width: width * 0.55,
                  decoration: BoxDecoration(
                    color: Color(0xFFEFEEFF),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(200)),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
