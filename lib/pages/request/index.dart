import 'package:flutter/material.dart';
import 'package:shoppingchk/pages/request/shop_request.dart';

class RequestOptionPage extends StatefulWidget {
  final String q;
  const RequestOptionPage({super.key, required this.q});

  @override
  State<RequestOptionPage> createState() => _RequestOptionPageState();
}

class _RequestOptionPageState extends State<RequestOptionPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.q == "1") {
      return const ShopRequestPage();
    } else {
      throw Error();
    }
  }
}
