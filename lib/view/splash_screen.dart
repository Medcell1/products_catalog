import 'package:flutter/cupertino.dart';
import 'package:product_catalog/view/home_screen.dart';

import 'view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigate() {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  pushToHome() {
    Future.delayed(const Duration(seconds: 3), navigate);
  }

  @override
  void initState() {
    pushToHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: StyledText(
                text: "ClOt",
                fontName: "Poppins",
                fontSize: 50,
                color: Colors.white,
              ),
            ),
          ],
        ));
  }
}
