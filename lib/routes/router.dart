import 'dart:ffi';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingchk/pages/app_main.dart';
import 'package:shoppingchk/pages/auth/login.dart';
import 'package:shoppingchk/pages/auth/pwd_reset.dart';
import 'package:shoppingchk/pages/auth/register.dart';
import 'package:shoppingchk/pages/auth/verify.dart';
import 'package:shoppingchk/pages/comment/detail.dart';
import 'package:shoppingchk/pages/request/index.dart';
import 'package:shoppingchk/pages/shop/detail.dart';

Future<String?> _authRedirect(BuildContext context, GoRouterState state) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? user = prefs.getString('user');

  if (user == null) {
    return "/auth/login";
  }

  if ((await Amplify.Auth.fetchAuthSession()).isSignedIn) {
    return null;
  }

  return "/auth/login";
}

final GoRouter router = GoRouter(initialLocation: "/", routes: <RouteBase>[
  GoRoute(
      path: "/",
      name: "ShoppingChk",
      builder: (BuildContext context, state) => const AppMainPage(),
      routes: [
        GoRoute(
            path: "shop/:id",
            name: "Shop Chking",
            builder: (BuildContext context, state) =>
                ShopDetailPage(id: state.pathParameters['id']!),
            routes: [
              GoRoute(
                path: "request",
                name: "Shop Comment Request",
                builder: (context, state) => const RequestOptionPage(q: "2"),
              ),
              GoRoute(
                  path: "comment/:cid",
                  name: "Shop Comment",
                  builder: (context, state) =>
                      CommentDetailPage(id: state.pathParameters['cid']!))
            ]),
        GoRoute(
          path: "request/:q",
          name: "Request",
          builder: (context, state) =>
              RequestOptionPage(q: state.pathParameters['q']!),
          redirect: (context, state) => _authRedirect(context, state),
        ),
        GoRoute(
          path: "auth/login",
          name: "Login",
          builder: (context, state) {
            ConfirmedSignUpRestult? sigupResult =
                state.extra as ConfirmedSignUpRestult?;
            return LoginPage(confirmedSignUpRestult: sigupResult);
          },
        ),
        GoRoute(
            path: "auth/register",
            name: "Register",
            builder: (context, state) => const RegisterPage()),
        GoRoute(
            path: "auth/verify",
            name: "Verify Account",
            builder: (context, state) {
              String emailAddress = state.extra as String;
              return VerifyPage(emailAddress: emailAddress);
            }),
        GoRoute(
          path: "auth/reset",
          name: "Reset Password",
          builder: (context, state) {
            String emailAddress = state.extra as String;
            return ResetPasswordPage(emailAddress: emailAddress);
          },
        )
      ]),
]);
