import 'package:flutter/material.dart';
import 'package:mortgage_calc/const/app_styles.dart';

class DetailsWidget extends StatefulWidget {
  const DetailsWidget({super.key});

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 35),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Spacer(),
                Text(
                  'DETAILS',
                  style: btntext.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w800),
                ),
                Spacer(),
                Container(
                  width: 40,
                )
              ],
            ),
            TextField(
              cursorColor: Colors.black,
              style: btntext.copyWith(color: Colors.black, fontSize: 14),
              decoration: txtFieldStyle.copyWith(hintText: 'Bank'),
            ),
            SizedBox(height: 25),
            TextField(
              cursorColor: Colors.black,
              style: btntext.copyWith(color: Colors.black, fontSize: 14),
              decoration: txtFieldStyle.copyWith(hintText: 'Account number'),
            ),
            SizedBox(height: 25),
            TextField(
              cursorColor: Colors.black,
              style: btntext.copyWith(color: Colors.black, fontSize: 14),
              decoration: txtFieldStyle.copyWith(hintText: 'UIC'),
            ),
            SizedBox(height: 25),
            TextField(
              cursorColor: Colors.black,
              style: btntext.copyWith(color: Colors.black, fontSize: 14),
              decoration:
                  txtFieldStyle.copyWith(hintText: 'Correspondent Account'),
            ),
            SizedBox(height: 25),
            TextField(
              cursorColor: Colors.black,
              style: btntext.copyWith(color: Colors.black, fontSize: 14),
              decoration: txtFieldStyle.copyWith(hintText: 'Payment Comment'),
            ),
          ],
        ),
      ),
    );
  }
}
