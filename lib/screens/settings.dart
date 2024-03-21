import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:mortgage_calc/const/app_styles.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 45),
          Text(
            'SETTINGS',
            style: boldstyle.copyWith(fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const Prefers(
                          dax: 'https://docs.google.com/document/d/1rXyAmuUbR_3tIbEWqaBS3SJ3Yz14S1E_au-f-xVOi3E/edit?usp=sharing',
                        )),
              );
            },
            child: Container(
              width: double.infinity,
              child: Text(
                'Privacy Policy',
                style: contTextMain.copyWith(fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 1,
            color: Color(0xffECECEC),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const Prefers(
                          dax: 'https://docs.google.com/document/d/1pO4Dc7F_5W0Bjv0L06k339oB2xBnOscT-4Tfol9e-T4/edit?usp=sharing',
                        )),
              );
            },
            child: Container(
              width: double.infinity,
              child: Text(
                'Terms of Use',
                style: contTextMain.copyWith(fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 1,
            color: Color(0xffECECEC),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const Prefers(
                          dax: 'https://forms.gle/8mJZAoWExWtgMEqZ7',
                        )),
              );
            },
            child: Container(
              width: double.infinity,
              child: Text(
                'Write Support',
                style: contTextMain.copyWith(fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 1,
            color: Color(0xffECECEC),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              InAppReview.instance.openStoreListing(appStoreId: '6479754482');
            },
            child: Container(
              width: double.infinity,
              child: Text(
                'Rate us in AppStore',
                style: contTextMain.copyWith(fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 1,
            color: Color(0xffECECEC),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class Prefers extends StatelessWidget {
  final String dax;

  const Prefers({Key? key, required this.dax}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 157, 255),
      ),
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(dax)),
        ),
      ),
    );
  }
}
