import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteDetail extends StatefulWidget {
  final note;
  const NoteDetail(this.note, {Key? key}) : super(key: key);

  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String title;
  late String content;
  late List toDoList;
  late TextEditingController _controllerTitle;
  late TextEditingController _controllerContent;

  @override
  void initState() {
    super.initState();
    title = widget.note["noteTitle"];
    content = widget.note["noteContent"];
    toDoList = widget.note["toDoList"];
    _controllerTitle = TextEditingController(text: title);
    _controllerContent = TextEditingController(text: content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            TextField(
              controller: _controllerTitle,
              onChanged: (text) {
                setState(() {
                  title = text;
                });
              },
            ),
            TextField(
              controller: _controllerContent,
              onChanged: (text) {
                setState(() {
                  content = text;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    updateDatabase();
                  },
                  child: const Text("Kaydet"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      toDoList.add({"isChecked": false, "toDo": ""});
                    });
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var controller = TextEditingController(text: toDoList[index]["toDo"]);
                  return Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3 * 2,
                        child: TextField(
                          onChanged: (text) {
                            toDoList[index]["toDo"] = text;
                          },
                          controller: controller,
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
            ),
          ],
        ),
      ),
    );
  }

  void updateDatabase() async {
    var id = widget.note["id"];
    _firestore
        .doc("notes/$id")
        .update({"noteContent": content, "noteTitle": title, "toDoList": toDoList})
        .then((value) => Navigator.pop(context))
        .catchError((onError) => print("Hata"));
  }
}
