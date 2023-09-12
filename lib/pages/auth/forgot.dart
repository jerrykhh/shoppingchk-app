import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppingchk/layout/responsive/rwd_layout.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCodeController = TextEditingController();

  void _handleForgotPassword() {
    context.push("/auth/reset", extra: _emailCodeController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.close_rounded))
        ],
      ),
      body: Container(
          alignment: Alignment.center,
          child: RWDLayout(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text("Please enter your email here."),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: TextFormField(
                                autofocus: true,
                                controller: _emailCodeController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Your Email Address",
                                  labelText: "Your Email Address",
                                ),
                                validator: (value) => value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'''(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])''')
                                            .hasMatch(value)
                                    ? "Email is Invalid"
                                    : null)),
                        Padding(
                          padding: const EdgeInsets.only(top: 45, bottom: 65),
                          child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.black,
                                minimumSize: const Size.fromHeight(45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              onPressed: () {
                                if ((_formKey.currentState as FormState)
                                    .validate()) {
                                  _handleForgotPassword();
                                }
                              },
                              child: const Text(
                                "Send Verify Code",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}
