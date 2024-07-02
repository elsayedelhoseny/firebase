// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tests/components/custombuttonauth.dart';
import 'package:tests/components/customlogoauth.dart';
import 'package:tests/components/textformfield.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 120),
                const CustomLogoAuth(),
                const SizedBox(height: 50),
                const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                CustomTextForm(
                    validator: (v) {
                      if (v == '') {
                        return "Can't  To Be empty";
                      }
                      return null;
                    },
                    hinttext: "ُEnter Your Email",
                    mycontroller: email),
                const SizedBox(height: 50),
                Center(
                    child: CustomButtonAuth(
                        title: "Send",
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: email.text);
                              Navigator.of(context)
                                  .pushReplacementNamed("homepage");

                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                title: 'success',
                                desc:
                                    'الرجاء الذهاب الي البريد لادخال كلمه السر الجديده وتسجيل الدخول ',
                              ).show();
                            } catch (e) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'error',
                                desc: 'لا يوجد بريد بهذا الاسم تاكد من ذالك ',
                              ).show();
                              if (kDebugMode) {
                                print(e.toString());
                              }
                            }
                          }
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
