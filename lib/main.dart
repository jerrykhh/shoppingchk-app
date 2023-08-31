import 'package:flutter/material.dart';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:shoppingchk/pages/shop/detail.dart';

// Generated in previous step
import 'amplifyconfiguration.dart';

import 'package:go_router/go_router.dart';
import 'package:shoppingchk/pages/home/index.dart';

void main() => runApp(const ShoppingChkApp());

final GoRouter _router = GoRouter(initialLocation: "/", routes: <RouteBase>[
  GoRoute(
      path: "/",
      name: "ShoppingChk",
      builder: (BuildContext context, state) => const HomePage(),
      routes: [
        GoRoute(
            path: "shop/:id",
            name: "Shop Chking",
            builder: (BuildContext context, state) =>
                ShopDetailPage(id: state.pathParameters['id']!))
      ]),
]);

class ShoppingChkApp extends StatefulWidget {
  const ShoppingChkApp({super.key});

  @override
  State<ShoppingChkApp> createState() => _ShoppingChkAppState();
}

class _ShoppingChkAppState extends State<ShoppingChkApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    // Add any Amplify plugins you want to use
    final authPlugin = AmplifyAuthCognito();
    await Amplify.addPlugin(authPlugin);

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
      routerConfig: _router,
    );
  }
}
