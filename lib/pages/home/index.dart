import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _header() {
    return AppBar(
      centerTitle: true,
      title: const Text("ShoppingChk"),
      titleTextStyle:
          const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(
            child: ListView(
          children: [_header()],
        )));
  }
}
