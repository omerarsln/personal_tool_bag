// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key? key}) : super(key: key);

  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String noteTitle;
  late String noteContent;
  late List<Map> toDoList;

  @override
  void initState() {
    super.initState();
    noteTitle = "";
    noteContent = "";
    toDoList = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Not Oluştur"),
        centerTitle: true,
      ),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width / 3 * 2,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Başlık",
                  ),
                  textAlign: TextAlign.center,
                  onChanged: (text) {
                    setState(() {
                      noteTitle = text;
                    });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width / 3 * 2,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "İçerik",
                  ),
                  textAlign: TextAlign.center,
                  onChanged: (text) {
                    setState(() {
                      noteContent = text;
                    });
                  },
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      toDoList.add({"toDo": "", "isChecked": false});
                    });
                  },
                  child: const Icon(Icons.add),
                ),
                ElevatedButton(
                  onPressed: () {
                    saveToDatabase();
                  },
                  child: const Text("Kaydet"),
                ),
              ]),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: MediaQuery.of(context).size.width / 3 * 2,
                          child: TextField(
                            onChanged: (newText) {
                              setState(() {
                                toDoList[index]["toDo"] = newText;
                              });
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Checkbox(
                            value: toDoList[index]["isChecked"],
                            onChanged: (newValue) {
                              setState(() {
                                toDoList[index]["isChecked"] = newValue;
                              });
                            })
                      ],
                    );
                  },
                  itemCount: toDoList.length,
                ),
              )
            ],
          )),
    );
  }

  void saveToDatabase() async {
    var newNoteId = _firestore.collection("notes").doc().id;

    await _firestore
        .doc("notes/$newNoteId")
        .set({
          "id": newNoteId,
          "owner": _auth.currentUser!.uid,
          "noteTitle": noteTitle,
          "noteContent": noteContent,
          "toDoList": toDoList
        })
        .then((value) => Navigator.pop(context))
        .catchError((onError) => print("Not Ekleme Başarısız"));
  }
}
