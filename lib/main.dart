import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tests/auth/forgot_password.dart';
import 'package:tests/auth/login.dart';
import 'package:tests/auth/signup.dart';
import 'package:tests/categories/add_category.dart';
import 'package:tests/firebase_options.dart';
import 'package:tests/home/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        if (kDebugMode) {
          print(' ========== User is currently signed out!');
        }
      } else {
        if (kDebugMode) {
          print('================ User is signed in!');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey[200],
              iconTheme: const IconThemeData(color: Colors.orange),
              titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.orange))),
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? const Homepage()
          : const Login(),
      routes: {
        "signup": (context) => const SignUp(),
        "login": (context) => const Login(),
        "homepage": (context) => const Homepage(),
        "forgotpassword": (context) => ForgotPassword(),
        "addcategory": (context) => const AddCategory(),
      },
    );
  }
}
