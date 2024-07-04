// ignore_for_file: must_be_immutable, invalid_return_type_for_catch_error, use_build_context_synchronously, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tests/components/custombuttonauth.dart';
import 'package:tests/components/textformfield.dart';
import 'package:tests/note/note_view.dart';

class EditNote extends StatefulWidget {
  const EditNote(
      {super.key,
      required this.docId,
      required this.categoryId,
      required this.value});
  final String docId;
  final String value;
  final String categoryId;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController note = TextEditingController();

  bool isLoading = false;
  EditUser() async {
    try {
      CollectionReference category =
          FirebaseFirestore.instance.collection('category');
      isLoading = true;
      setState(() {});
      await category.doc(widget.docId).update({
        'name': note.text,
      });
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return NoteView(
            docId: widget.categoryId,
          );
        },
      ));
    } catch (e) {
      isLoading = false;
    }
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    note.text = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
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
                  hinttext: "ُEnter Your notes",
                  mycontroller: note),
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
