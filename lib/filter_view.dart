// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  List<QueryDocumentSnapshot> data = [];
  getData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    QuerySnapshot usersData = await users.get();
    for (var element in usersData.docs) {
      data.add(element);
    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FilterView'),
        actions: [
          GestureDetector(
            onTap: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.disconnect();
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'login', (route) => false);
            },
            child: const Padding(
              padding: EdgeInsetsDirectional.only(end: 10),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            title: Text(
              data[index]['username'],
              style: const TextStyle(fontSize: 30),
            ),
            subtitle: Text(
              'age : ${data[index]['age']}',
            ),
          ),
        ),
      ),
    );
  }
}
