import 'package:flutter/material.dart';
import 'package:mortgage_calc/const/model.dart';
import 'package:mortgage_calc/screens/add_mortgage.dart';
import 'package:mortgage_calc/screens/loading_screen.dart';
import 'package:mortgage_calc/screens/main_screen.dart';
import 'package:mortgage_calc/screens/onboardin2_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MortgageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final mortgageProvider =
        Provider.of<MortgageProvider>(context, listen: false);
    mortgageProvider.loadMortgagesFromPrefs();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      routes: {
        '/onboard2': (context) => OnBoarding2Widget(),
        '/main': (context) => MainWidget(),
        '/addmort': (context) => AddMortGageWidget(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences prefs;
  bool showInstructions = true;

  @override
  void initState() {
    super.initState();
    checkInstructionsStatus();
  }

  Future<void> checkInstructionsStatus() async {
    prefs = await SharedPreferences.getInstance();
    bool shouldShowInstructions = prefs.getBool('showInstructions') ?? true;

    if (mounted) {
      setState(() {
        showInstructions = shouldShowInstructions;
      });

      if (showInstructions) {
        await prefs.setBool('showInstructions', false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoadingWidget()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainWidget()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
