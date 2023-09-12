import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppingchk/layout/responsive/rwd_layout.dart';

class VerifyPage extends StatefulWidget {
  final String emailAddress;
  const VerifyPage({super.key, required this.emailAddress});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _verifyCodeController = TextEditingController();
  bool _isFormSubbmited = false;

  String errorMessage = "";

  void _handleVerifyCode() async {
    SignUpResult result = await Amplify.Auth.confirmSignUp(
        username: widget.emailAddress,
        confirmationCode: _verifyCodeController.text.trim());

    if (result.isSignUpComplete) {
      context.push("/auth/login",
          extra: ConfirmedSignUpRestult(widget.emailAddress, result));
    } else {
      setState(() {
        _isFormSubbmited = false;
        errorMessage = "Incorrect Verify Code.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Your Email"),
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
                Text(
                    "The verify code is sent to your email (${widget.emailAddress}), please enter the code below."),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: TextFormField(
                                autofocus: true,
                                controller: _verifyCodeController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Verify Code",
                                  labelText: "Verify Code",
                                ),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? "Please enter the verify code"
                                        : null)),
                        if (errorMessage.isNotEmpty) ...[
                          Text(
                            errorMessage,
                            style: const TextStyle(color: Colors.red),
                          )
                        ],
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
                              onPressed: (!_isFormSubbmited)
                                  ? () async {
                                      if ((_formKey.currentState as FormState)
                                          .validate()) {
                                        setState(() => _isFormSubbmited = true);
                                        _handleVerifyCode();
                                      }
                                    }
                                  : null,
                              child: (!_isFormSubbmited)
                                  ? const Text(
                                      "Login",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Container(
                                      width: 24,
                                      height: 24,
                                      padding: const EdgeInsets.all(2.0),
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      )),
                            )),
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}

class ConfirmedSignUpRestult extends SignUpResult {
  final String emailAddress;
  ConfirmedSignUpRestult(this.emailAddress, SignUpResult result)
      : super(
            isSignUpComplete: result.isSignUpComplete,
            nextStep: result.nextStep,
            userId: result.userId);
}
