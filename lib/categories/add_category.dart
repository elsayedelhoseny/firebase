// ignore_for_file: must_be_immutable, invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tests/components/custombuttonauth.dart';
import 'package:tests/components/textformfield.dart';

class AddCategory extends StatefulWidget {
  AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController name = TextEditingController();
  CollectionReference category =
      FirebaseFirestore.instance.collection('category');
  Future<void> addUser() {
    return category
        .add({
          'name': name.text,
        })
        .then((value) => Navigator.pushReplacementNamed(context, 'homepage'))
        .catchError((error) => print("Failed to add user: $error"));
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Caregory'),
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
                      title: "Add",
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          addUser();
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
