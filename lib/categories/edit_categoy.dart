// ignore_for_file: must_be_immutable, invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tests/components/custombuttonauth.dart';
import 'package:tests/components/textformfield.dart';

class EditCategory extends StatefulWidget {
  const EditCategory({super.key});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  TextEditingController name = TextEditingController();
  CollectionReference category =
      FirebaseFirestore.instance.collection('category');
  bool isLoading = false;
  Future<void> EditUser() {
    isLoading = true;
    return category
        .add({
          'name': name.text,
          'id': FirebaseAuth.instance.currentUser!.uid,
        })
        .then((value) => Navigator.pushNamedAndRemoveUntil(
            context, 'homepage', (route) => false))
        .catchError((error) {
          isLoading = false;
          print("Failed to add user: $error");
        });
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Caregory'),
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomTextForm(
                  validator: (v) {
                    if (v == '') {
                      return "Can't  To Be empty";
                    }
                    return null;
                  },
                  hinttext: "ُEnter Your Name",
                  mycontroller: name),
              const SizedBox(height: 30),
              Center(
                  child: CustomButtonAuth(
                      title: "Save",
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          EditUser();
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
