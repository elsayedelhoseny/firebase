// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tests/note/add_note.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key, required this.docId});
  final String docId;
  @override
  State<NoteView> createState() => _NotepageeState();
}

class _NotepageeState extends State<NoteView> {
  List<QueryDocumentSnapshot> data = [];
  bool isLoading = true;

  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('category')
        .doc(widget.docId)
        .collection('note')
        .get();
    data.addAll(querySnapshot.docs);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              backgroundColor: Colors.orange,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AddNote(
                      docId: widget.docId,
                    );
                  },
                ));
              },
              child: const Icon(Icons.add)),
          appBar: AppBar(
            title: const Text('Note '),
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
          body: WillPopScope(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Colors.orange,
                    ))
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 4 / 4,
                              ),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onLongPress: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.rightSlide,
                                      title: 'Warning',
                                      desc: 'اختر ماذا تريد ؟ ',
                                      btnCancelText: 'حذف',
                                      btnOkText: 'تعديل ',
                                      btnOkOnPress: () {
                                        // Navigator.push(context, MaterialPageRoute(
                                        //   builder: (context) {
                                        //     return EditCategory(
                                        //       docid: data[index].id,
                                        //       oldName: data[index]['name'],
                                        //     );
                                        //   },
                                        // ));
                                      },
                                      btnCancelOnPress: () async {
                                        // await FirebaseFirestore.instance
                                        //     .collection('category')
                                        //     .doc(data[index].id)
                                        //     .delete();
                                        // Navigator.pushReplacementNamed(
                                        //     context, 'homepage');
                                      },
                                    ).show();
                                  },
                                  child: Card(
                                    elevation: 6.0,
                                    color: Colors.grey[20],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        '${data[index]['note']}',
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
              onWillPop: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'homepage', (route) => false);
                return Future.value(false);
              })),
    );
  }
}
