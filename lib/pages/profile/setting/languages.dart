import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppingchk/main.dart';
import 'package:shoppingchk/tools/localization.dart';

class LanguagesSettingPage extends StatefulWidget {
  const LanguagesSettingPage({super.key});

  @override
  State<LanguagesSettingPage> createState() => _LanguagesSettingPageState();
}

class _LanguagesSettingPageState extends State<LanguagesSettingPage> {
  final Localization localization = Localization.instance;
  late Map<String, String> languages = localization.languages;

  void changeLocalization(BuildContext content, String langCode) async {
    ShoppingChkApp.setLocale(content, langCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.get(context).appBarLanguageSettingPageTitle),
      ),
      body: ListView(
        children: languages.entries
            .map((e) => ListTile(
                  onTap: () => changeLocalization(context, e.value),
                  contentPadding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
                  title: Text(e.key),
                ))
            .toList(),
      ),
    );
  }
}
