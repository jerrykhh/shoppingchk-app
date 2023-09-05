import 'package:flutter/material.dart';
import 'package:shoppingchk/layout/responsive/rwd_layout.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void signOut() {
    print("sign out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RWDLayout(
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: const Text(
              "Hi, @username",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            onTap: () => print("test"),
            title: const Text(
              "Account",
              style: TextStyle(color: Colors.black),
            ),
            contentPadding: EdgeInsets.zero,
            shape: const Border(bottom: BorderSide(width: 0.5)),
          ),
          ListTile(
            onTap: () => print("test"),
            title: const Text(
              "Languages",
              style: TextStyle(color: Colors.black),
            ),
            contentPadding: EdgeInsets.zero,
            shape: const Border(bottom: BorderSide(width: 0.5)),
          ),
          ListTile(
            onTap: () => print("test"),
            title: const Text(
              "Content Settings",
              style: TextStyle(color: Colors.black),
            ),
            contentPadding: EdgeInsets.zero,
            shape: const Border(bottom: BorderSide(width: 0.5)),
          ),
          ListTile(
            onTap: () => print("test"),
            title: const Text(
              "Supports",
              style: TextStyle(color: Colors.black),
            ),
            contentPadding: EdgeInsets.zero,
            shape: const Border(bottom: BorderSide(width: 0.5)),
          ),
          ListTile(
            onTap: () => signOut(),
            title: const Text(
              "Sign Out",
              style: TextStyle(color: Colors.black45),
            ),
            contentPadding: EdgeInsets.zero,
            shape: const Border(bottom: BorderSide(width: 0.5)),
          )
        ],
      ),
    ));
  }
}
