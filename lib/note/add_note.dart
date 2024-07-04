// ignore_for_file: must_be_immutable, invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tests/components/custombuttonauth.dart';
import 'package:tests/components/textformfield.dart';
import 'package:tests/note/note_view.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, required this.docId});
  final String docId;
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController note = TextEditingController();

  bool isLoading = false;
  Future<void> addNote() {
    CollectionReference category = FirebaseFirestore.instance
        .collection('category')
        .doc(widget.docId)
        .collection('note');
    isLoading = true;
    return category
        .add({
          'note': note.text,
        })
        .then((value) => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return NoteView(
                  docId: widget.docId,
                );
              },
            )))
        .catchError((error) {
          isLoading = false;
          if (kDebugMode) {
            if (kDebugMode) {
              print("Failed to add user: $error");
            }
          }
        });
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
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
                      title: "Add",
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          addNote();
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
