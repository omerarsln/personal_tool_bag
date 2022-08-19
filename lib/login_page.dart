// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String mail;
  late String password;

  @override
  void initState() {
    super.initState();
    mail = "";
    password = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Oturum Açın"),
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
                signIn(mail, password);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange)),
              child: const Text("Giriş"),
            ),
          ],
        ),
      ),
    );
  }

  void signIn(mailAddress, password) async {
    try {
      if (_auth.currentUser == null) {
        print("Oturum Açılıyor");
        await _auth.signInWithEmailAndPassword(
            email: mailAddress, password: password);
        Navigator.pop(context);
      } else {
        print("Oturum Açmış Kullanıcı Zaten Var");
      }
    } catch (e) {
      print("***Hata Var***\n$e");
    }
  }
}
