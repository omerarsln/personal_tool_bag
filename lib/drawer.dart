import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            child: _auth.currentUser == null
                ? Container(
                    height: 50,
                  )
                : UserAccountsDrawerHeader(
                    accountName: Text(_auth.currentUser!.displayName!),
                    accountEmail: Text(_auth.currentUser!.email!),
                    currentAccountPicture: _auth.currentUser!.photoURL == null
                        ? const Text("")
                        : Image.network(_auth.currentUser!.photoURL!),
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                splashColor: Colors.orange,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(border: Border.all()),
                  child: const Center(
                    child: Text("Oturum Aç"),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/Login");
                },
              ),
              InkWell(
                splashColor: Colors.orange,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(border: Border.all()),
                  child: const Center(
                    child: Text("Oturumu Kapat"),
                  ),
                ),
                onTap: () {
                  signOut();
                },
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Üyeliğiniz Yok Mu ?"),
                Container(
                  height: 10,
                ),
                InkWell(
                  splashColor: Colors.orange,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(border: Border.all()),
                    child: const Center(
                      child: Text("Hemen Oluşturun"),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/CreateAccount");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void signOut() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.signOut();
      } else {
        print("Oturum Açmış Kullanıcı Yok");
      }
    } catch (e) {
      print("***Hata Var***\n$e");
    }
  }
}
