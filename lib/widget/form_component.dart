// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shoppingchk/tools/localization.dart';

enum RequestFormState { already, processing, finished }

class SubmitButton extends StatefulWidget {
  RequestFormState state;
  final Function onPressed;
  Widget? child;
  SubmitButton({
    Key? key,
    required this.state,
    required this.onPressed,
    this.child,
  }) : super(key: key);

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.black,
        minimumSize: const Size.fromHeight(40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      onPressed: (widget.state == RequestFormState.already)
          ? () => widget.onPressed()
          : null,
      child: (widget.state == RequestFormState.already)
          ? (widget.child != null)
              ? widget.child
              : Text(
                  Localization.instance.get(context).btnSubmit,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
          : Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(2.0),
              child: (widget.state == RequestFormState.processing)
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    )
                  : const Icon(
                      Icons.done_rounded,
                      color: Colors.white,
                      size: 24.0,
                    ),
            ),
    );
  }
}

class StyledTextFromFiled extends StatefulWidget {
  final Function(String?)? validator;
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final bool autofocus;
  final bool readOnly;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool autocorrect;

  const StyledTextFromFiled(
      {super.key,
      required this.controller,
      this.hintText,
      this.keyboardType,
      this.labelText,
      this.autofocus = false,
      this.readOnly = false,
      this.obscureText = false,
      this.autocorrect = true,
      this.validator});

  @override
  State<StyledTextFromFiled> createState() => _StyledTextFromFiledState();
}

class _StyledTextFromFiledState extends State<StyledTextFromFiled> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      controller: widget.controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        hintText: widget.hintText,
        labelText: widget.labelText,
      ),
      validator: (value) =>
          (widget.validator != null) ? widget.validator!(value) : null,
    );
  }
}
