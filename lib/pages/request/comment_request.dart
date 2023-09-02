import 'package:flutter/material.dart';
import 'package:shoppingchk/pages/request/abs_request.dart';

class CommentRequestPage extends RequestPage {
  const CommentRequestPage({super.key});

  @override
  State<RequestPage> createState() => _CommentRequestPageState();
}

class _CommentRequestPageState extends RequestPageState {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return super.structure(children: [
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child:
            const Text("Please let me know whats your comment about the shop"),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
            autofocus: true,
            controller: _titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintText: "Title",
              labelText: "Title",
            )),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
          maxLines: 4,
          autofocus: true,
          keyboardType: TextInputType.multiline,
          controller: _descriptionController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              labelText: "Description/Remark (optional)",
              alignLabelWithHint: true),
          validator: (value) {
            return value!.trim().isNotEmpty
                ? null
                : "Description Cannot be Empty";
          },
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(top: 50),
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: const Size.fromHeight(40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            child: const Text(
              "Submit",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onPressed: () {
              if ((formKey.currentState as FormState).validate()) {}
            },
          )),
    ]);
  }
}
