import 'package:flutter/material.dart';
import 'package:mortgage_calc/const/app_images.dart';
import 'package:mortgage_calc/screens/onboardin1_screen.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  void initState() {
    super.initState();

    _loadData().then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OnBoarding1Widget()),
      );
    });
  }

  Future<void> _loadData() async {
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(loading),
          width: 159,
          height: 159,
        ),
      ),
    );
  }
}
