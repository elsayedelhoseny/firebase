import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text('Firebase Install'),
            actions: [
              GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'login', (route) => false);
                  },
                  child: const Padding(
                    padding: EdgeInsetsDirectional.only(end: 10),
                    child: Icon(
                      Icons.exit_to_app,
                      color: Colors.black,
                    ),
                  ))
            ],
          ),
          body: ListView(
            children: const [
              // Text(
              //   "How Are You",
              // ),
            ],
          )),
    );
  }
}
