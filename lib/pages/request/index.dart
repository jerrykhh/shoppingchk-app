import 'package:flutter/material.dart';
import 'package:shoppingchk/pages/request/form_reg.dart';

class RequestOptionPage extends StatefulWidget {
  final String q;
  const RequestOptionPage({super.key, required this.q});

  @override
  State<RequestOptionPage> createState() => _RequestOptionPageState();
}

class _RequestOptionPageState extends State<RequestOptionPage> {
  @override
  Widget build(BuildContext context) {
    if (!reqFormRegister.containsKey(widget.q)) {
      throw Error();
    }

    return reqFormRegister[widget.q] as Widget;
  }
}
