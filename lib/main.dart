import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'calculator/calculator_app.dart';
import 'note/note_app.dart';
import 'create_account_page.dart';
import 'drawer.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Tool Bag',
      routes: {
        "/": (context) => const MyHomePage(),
        "/CalculatorApp": (context) => const CalculatorApp(),
        "/ToDoApp": (context) => const NoteApp(),
        "/Login": (context) => const Login(),
        "/CreateAccount": (context) => const CreateAccount(),
      },
      initialRoute: "/",
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kişisel Uygulama Çantam"),
        centerTitle: true,
      ),
      drawer: const DrawerMenu(),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/CalculatorApp"),
              child: const Text("Hesap Makinesi"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/ToDoApp"),
              child: const Text("Not Defteri"),
            ),
          ],
        ),
      ),
    );
  }
}
