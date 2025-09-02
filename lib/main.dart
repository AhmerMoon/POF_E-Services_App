import 'package:flutter/material.dart';
import 'package:pof_e_services/screens/home_screen.dart';
import 'package:pof_e_services/screens/login_screen.dart';
import 'package:pof_e_services/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider<AuthService>(create: (_) => AuthService())],
      child: MaterialApp(
        title: 'POF e-Services',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Roboto'),
        home: const SplashScreen(),
        routes: {'/login': (_) => LoginScreen(), '/home': (_) => HomeScreen()},
      ),
    );
  }
}
