import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // State variable to control the logo size for animation
  double _logoSize = 100.0;

  @override
  void initState() {
    super.initState();
    // Start the grow animation shortly after the screen is built
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _logoSize = 200.0; // The final size of the logo
      });
    });

    // Navigate to the next screen after a delay
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            // AnimatedContainer for the logo size animation
            AnimatedContainer(
              duration: const Duration(seconds: 2), // Animation duration
              curve: Curves.easeInOut, // Smooth animation curve
              height: _logoSize,
              child: Image.asset("assets/logo.png"),
            ),
            const SizedBox(height: 40),
            const Text(
              "PAKISTAN ORDNANCE FACTORIES",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Welcome To", style: TextStyle(fontSize: 16)),
            const Text(
              "POF e-Services",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Powered By: IT Department - POF",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
