import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_plus/share_plus.dart';
import 'note_create.dart';
import 'note_detail.dart';
import 'dart:async';

class NoteApp extends StatefulWidget {
  const NoteApp({Key? key}) : super(key: key);

  @override
  _NoteAppState createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map> notesList = [];

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Not Defteri"),
        centerTitle: true,
      ),
      body: notesList.isEmpty
          ? const Center(
              child: Text("Not Yok"),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => NoteDetail(notesList[index])));
                          },
                          title: Text(notesList[index]["noteTitle"]),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () async {
                          await _shareText(notesList[index]["noteTitle"], notesList[index]["noteContent"]);
                        },
                        splashColor: Colors.orange,
                      ),
                    ],
                  ),
                );
              },
              itemCount: notesList.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateNote()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void getNotes() async {
    var notes = await _firestore.collection("notes").where("owner", isEqualTo: _auth.currentUser!.uid).get();

    for (var note in notes.docs) {
      setState(() {
        notesList.add(note.data());
      });
    }
  }

  Future<void> _shareText(title, content) async {
    try {
      Share.share(title);
    } catch (e) {
      print('error: $e');
    }
  }
}
