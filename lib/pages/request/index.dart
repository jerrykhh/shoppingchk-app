import 'package:flutter/material.dart';
import 'package:shoppingchk/pages/request/comment_request.dart';
import 'package:shoppingchk/pages/request/form_reg.dart';

class RequestOptionPage extends StatefulWidget {
  final String q;
  final Map<String, dynamic> params;
  const RequestOptionPage({super.key, required this.q, this.params = const {}});

  @override
  State<RequestOptionPage> createState() => _RequestOptionPageState();
}

class _RequestOptionPageState extends State<RequestOptionPage> {
  @override
  Widget build(BuildContext context) {
    if (!reqFormRegister.containsKey(widget.q)) {
      throw Error();
    }

    Widget selectedWidget;
    if (reqFormRegister[widget.q] is CommentRequestPage Function(String)) {
      // The selected widget is CommentRequestPage
      selectedWidget = reqFormRegister[widget.q]!(widget.params['shopID']);
    } else {
      selectedWidget = reqFormRegister[widget.q]!();
    }

    return selectedWidget;
  }
}
