import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingchk/layout/responsive/rwd_layout.dart';
import 'package:shoppingchk/pages/auth/login.dart';
import 'package:shoppingchk/routes/router.dart';
import 'package:shoppingchk/tools/localization.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Localization localization = Localization.instance;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String?> fetchSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');
    if (user == null) {
      return "";
    }
    return user;
  }

  void signOut() async {
    try {
      await Amplify.Auth.signOut();
      (await _prefs).remove('userId');
      context.push("/auth/login");
    } on AuthException catch (e) {
      safePrint("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: fetchSession(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final user = snapshot.data;
                if (user != "") {
                  return RWDLayout(
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
                          title: Text(
                            localization.get(context).profileTitleAccount,
                            style: const TextStyle(color: Colors.black),
                          ),
                          contentPadding: EdgeInsets.zero,
                          shape: const Border(bottom: BorderSide(width: 0.5)),
                        ),
                        ListTile(
                          onTap: () => context.go("/profile/set/lang"),
                          title: Text(
                            localization.get(context).profileTitleLanguages,
                            style: const TextStyle(color: Colors.black),
                          ),
                          contentPadding: EdgeInsets.zero,
                          shape: const Border(bottom: BorderSide(width: 0.5)),
                        ),
                        ListTile(
                          onTap: () => print("test"),
                          title: Text(
                            localization
                                .get(context)
                                .profileTitleContentSettings,
                            style: const TextStyle(color: Colors.black),
                          ),
                          contentPadding: EdgeInsets.zero,
                          shape: const Border(bottom: BorderSide(width: 0.5)),
                        ),
                        ListTile(
                          onTap: () => print("test"),
                          title: Text(
                            localization.get(context).profileTitleSupports,
                            style: const TextStyle(color: Colors.black),
                          ),
                          contentPadding: EdgeInsets.zero,
                          shape: const Border(bottom: BorderSide(width: 0.5)),
                        ),
                        ListTile(
                          onTap: () => signOut(),
                          title: Text(
                            localization.get(context).profileTitleSignOut,
                            style: const TextStyle(color: Colors.black45),
                          ),
                          contentPadding: EdgeInsets.zero,
                          shape: const Border(bottom: BorderSide(width: 0.5)),
                        )
                      ],
                    ),
                  );
                } else {
                  return const LoginPage();
                }
              }
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            }));
  }
}
