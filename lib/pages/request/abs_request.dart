import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingchk/layout/responsive/rwd_layout.dart';
import 'package:shoppingchk/widget/form_component.dart';
// import 'package:shared_preferences/shared_preferences.dart';

abstract class RequestPage extends StatefulWidget {
  const RequestPage({super.key});
}

abstract class RequestPageState<T extends RequestPage> extends State<T> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  RequestFormState formState = RequestFormState.already;

  late final String _userId;

  GlobalKey get formKey {
    return _formKey;
  }

  String get userId {
    return _userId;
  }

  Future<void> _getUserId() async {
    // final SharedPreferences prefs = await _prefs;
    // final String? userId = prefs.getString('userId');
    final userId = (await Amplify.Auth.getCurrentUser()).userId;

    setState(() {
      _userId = userId;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserId();
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
