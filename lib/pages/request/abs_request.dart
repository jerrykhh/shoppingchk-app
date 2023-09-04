import 'package:flutter/material.dart';
import 'package:shoppingchk/layout/responsive/rwd_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RequestPage extends StatefulWidget {
  const RequestPage({super.key});
}

abstract class RequestPageState extends State<RequestPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late final String _userId;

  GlobalKey get formKey {
    return _formKey;
  }

  String get userId {
    return _userId;
  }

  Future<void> _getUserId() async {
    final SharedPreferences prefs = await _prefs;
    final String? userId = prefs.getString('userId');

    setState(() {
      _userId = userId!;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  AppBar _appBar(String title) {
    return AppBar(
      title: Text(title),
    );
  }

  Widget structure(
      {String title = "Make Request",
      List<Widget> children = const <Widget>[]}) {
    return Scaffold(
      appBar: _appBar(title),
      body: RWDLayout(
        alignment: Alignment.center,
        child: Form(
            key: _formKey,
            child: ListView.builder(
              itemCount: children.length,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) => children[index],
            )),
      ),
    );
  }
}
