import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:shoppingchk/models/ModelProvider.dart';
import 'package:shoppingchk/routes/router.dart';
import 'package:shoppingchk/tools/localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Generated in previous step
import 'amplifyconfiguration.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await _configureAmplify();
  runApp(ShoppingChkApp());
}

Future<void> _configureAmplify() async {
  // Add any Amplify plugins you want to use
  final authPlugin = AmplifyAuthCognito();
  final datastorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);
  final s3Plugin = AmplifyStorageS3();
  await Amplify.addPlugins([datastorePlugin, authPlugin, s3Plugin]);

  // You can use addPlugins if you are going to be adding multiple plugins
  // await Amplify.addPlugins([authPlugin, analyticsPlugin]);

  // Once Plugins are added, configure Amplify
  // Note: Amplify can only be configured once.
  try {
    await Amplify.configure(amplifyconfig);
  } on AmplifyAlreadyConfiguredException {
    safePrint(
        "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
  }
}

class ShoppingChkApp extends StatefulWidget {
  final Localization localization = Localization.instance;
  ShoppingChkApp({super.key});

  @override
  State<ShoppingChkApp> createState() => _ShoppingChkAppState();
  static void setLocale(BuildContext content, String langCode) {
    _ShoppingChkAppState? state =
        content.findAncestorStateOfType<_ShoppingChkAppState>();
    state?.setLocale(langCode);
  }
}

class _ShoppingChkAppState extends State<ShoppingChkApp> {
  Locale? _locale;

  setLocale(String langCode) async {
    Locale locale = await widget.localization.setLocale(langCode);
    safePrint(locale.toString());
    setState(() {
      _locale = locale;
    });
  }

  initLocale() async {
    Locale locale = await widget.localization.getLocale();
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    initLocale();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "ShoppingChk App",
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate
      ],
      locale: _locale,
      supportedLocales: AppLocalizations.supportedLocales,
      // supportedLocales: const [
      //   Locale('en'), // English
      //   // Locale.fromSubtags(languageCode: 'zh', countryCode: 'HK'), // Chinese
      //   Locale('zh')
      // ],
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.

        primaryColor: Colors.black,
        textTheme: const TextTheme(
            titleMedium: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
            titleSmall: TextStyle(color: Colors.black45)),

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
