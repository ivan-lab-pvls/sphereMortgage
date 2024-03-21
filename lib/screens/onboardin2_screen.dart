import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mortgage_calc/const/app_images.dart';
import 'package:mortgage_calc/const/app_styles.dart';

class OnBoarding2Widget extends StatefulWidget {
  const OnBoarding2Widget({super.key});

  @override
  State<OnBoarding2Widget> createState() => OnBoarding2WidgetState();
}

class OnBoarding2WidgetState extends State<OnBoarding2Widget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(onboarding2)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'WE VALUE YOUR FEEDBACK',
                  style: boldstyle,
                ),
                SizedBox(height: 20),
                Text(
                  'Every day we are getting better due to your ratings \nand reviews — that helps us protect your accounts.',
                  style: opacityStyle,
                ),
                SizedBox(height: 100),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/main');
                  },
                  child: Container(
                    width: double.infinity,
                    height: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xffFF9500)),
                    child: Center(
                      child: Text(
                        'CONTINUE',
                        style: btntext,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 70,
                  height: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 12,
                        height: 3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffF0F0F0)),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 12,
                        height: 3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xff5C5C65)),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'Terms of Use       |       Privacy Policy',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffC1C1C1)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
