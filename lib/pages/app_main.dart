import 'package:flutter/material.dart';
import 'package:shoppingchk/pages/home/index.dart';
import 'package:shoppingchk/pages/profile/index.dart';

class AppMainPage extends StatefulWidget {
  const AppMainPage({super.key});

  @override
  State<AppMainPage> createState() => _AppMainPageState();
}

class _AppMainPageState extends State<AppMainPage> {
  int _currentIndex = 0;

  static const MAIN_PAGES = [HomePage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MAIN_PAGES[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 28,
          elevation: 6.0,
          onTap: (value) => setState(() => _currentIndex = value),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded), label: "Profile")
          ]),
    );
  }
}
