import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String mail;
  late String password;
  late String name;

  var profilePicture;

  @override
  void initState() {
    super.initState();
    mail = "";
    password = "";
    name = "";
    profilePicture = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hesap Oluşturun"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    mail = text;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Email Adresi",
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    name = text;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "İsim",
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    password = text;
                  });
                },
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: "Şifre",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                pickImageFromGallery();
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange)),
              child: const Text("Resim Seç"),
            ),
            ElevatedButton(
              onPressed: () {
                createAcc(mail, password, name);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange)),
              child: const Text("Oluştur"),
            ),
            Expanded(
                child: profilePicture == null
                    ? const Text("Resim Yok")
                    : Image.file(File(profilePicture.path))),
          ],
        ),
      ),
    );
  }

  pickImageFromGallery() async {
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      profilePicture = pickedImage;
    });
  }

  createAcc(mailAddress, password, name) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: mailAddress, password: password);
      await _auth.currentUser!.updateDisplayName(name);
      String newUserId = _auth.currentUser!.uid;
      await _firestore
          .doc("users/$newUserId")
          .set({
            "ID": newUserId,
            "name": name,
            "mail": mailAddress,
            "password": password
          })
          .then((value) => print("Kayıt Veritabanına Eklendi"))
          .catchError((onError) => print("Veritabanına Ekleme Başarısız"));
      if (profilePicture != null) {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child("user")
            .child(newUserId)
            .child("profil.png");
        UploadTask uploadTask = ref.putFile(File(profilePicture.path));

        await uploadTask
            .then((res) => {
                  res.ref.getDownloadURL().then((value) {
                    _auth.currentUser!.updatePhotoURL(value);
                  })
                })
            .catchError((onError) => print(onError));
      }
      Navigator.pop(context);
    } catch (e) {
      print("***Hata Var***\n$e");
    }
  }
}
