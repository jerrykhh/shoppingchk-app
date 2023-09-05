import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppingchk/pages/app_main.dart';
import 'package:shoppingchk/pages/comment/detail.dart';
import 'package:shoppingchk/pages/request/index.dart';
import 'package:shoppingchk/pages/shop/detail.dart';

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
        )
      ]),
]);
