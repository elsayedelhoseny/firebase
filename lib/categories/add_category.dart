// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tests/components/custombuttonauth.dart';
import 'package:tests/components/textformfield.dart';

class AddCategory extends StatelessWidget {
  AddCategory({super.key});

  TextEditingController name = TextEditingController();
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
                  hinttext: "ُEnter Your Email",
                  mycontroller: name),
              const SizedBox(height: 30),
              Center(
                  child: CustomButtonAuth(
                      title: "Add",
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {}
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
