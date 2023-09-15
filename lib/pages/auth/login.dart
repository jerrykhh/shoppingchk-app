import 'dart:convert';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingchk/layout/responsive/rwd_layout.dart';
import 'package:shoppingchk/models/ModelProvider.dart';
import 'package:shoppingchk/pages/auth/verify.dart';

class LoginPage extends StatefulWidget {
  final ConfirmedSignUpRestult? confirmedSignUpRestult;
  const LoginPage({super.key, this.confirmedSignUpRestult});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  String errorMessage = "";
  bool _isSubmittedLoginForm = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = (widget.confirmedSignUpRestult != null)
        ? widget.confirmedSignUpRestult!.emailAddress
        : "";
  }

  Future<void> _handleSignInResult(SignInResult result) async {
    print(result.nextStep);
    switch (result.nextStep.signInStep) {
      case AuthSignInStep.resetPassword:
      case AuthSignInStep.confirmSignInWithNewPassword:
        context.push("/auth/reset");
        break;

      case AuthSignInStep.confirmSignUp:
        // Resend the sign up code to the registered device.
        context.replace("/auth/verify", extra: _emailController.text.trim());
        break;

      case AuthSignInStep.done:
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final user = await Amplify.Auth.getCurrentUser();
        // final dbUser = (await Amplify.DataStore.query(User.classType,
        //         where: User.ID.eq(user.userId)))
        //     .first;

        prefs.setString("user", jsonEncode(user));
        context.pop();

        break;

      case AuthSignInStep.confirmSignInWithCustomChallenge:
      case AuthSignInStep.continueSignInWithMfaSelection:
      case AuthSignInStep.continueSignInWithTotpSetup:
      case AuthSignInStep.confirmSignInWithTotpMfaCode:
      case AuthSignInStep.confirmSignInWithSmsMfaCode:
        throw UnimplementedError();
    }
  }

  Future<bool> _handleLogin() async {
    try {
      final result = await Amplify.Auth.signIn(
          username: _emailController.text.trim(),
          password: _pwdController.text);

      await _handleSignInResult(result);
      return true;
    } on AuthException catch (e) {
      setState(() {
        errorMessage = 'Error signing in: ${e.message}';
      });
    } on UnimplementedError catch (e) {
      safePrint("$e");
    }
    setState(() {
      _isSubmittedLoginForm = false;
    });
    return false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwdController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.transparent,
          forceMaterialTransparency: false,
          actions: [
            IconButton(
                iconSize: 28,
                onPressed: () => context.pop(),
                padding: const EdgeInsets.only(right: 16.0),
                icon: const Icon(Icons.close_rounded))
          ]),
      body: Form(
          key: _formKey,
          child: RWDLayout(
            child: ListView(children: [
              const Padding(padding: EdgeInsets.only(top: 60.0)),
              SizedBox(
                  height: 100,
                  child: Image.asset("assets/shoppingchk_logo.png")),
              const Text(
                "Login",
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: "Email",
                    ),
                    validator: (value) => value == null ||
                            value.isEmpty ||
                            !RegExp(r'''(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])''')
                                .hasMatch(value)
                        ? "Email is Invalid"
                        : null),
              ),
              TextFormField(
                  obscureText: false,
                  controller: _pwdController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: "Password",
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter Password"
                      : null),
              if (errorMessage.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 0),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
              Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size.fromHeight(45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        disabledBackgroundColor: Colors.black54),
                    onPressed: (!_isSubmittedLoginForm)
                        ? () async {
                            if ((_formKey.currentState as FormState)
                                .validate()) {
                              setState(() {
                                errorMessage = "";
                                _isSubmittedLoginForm = true;
                              });
                              await _handleLogin();
                            }
                          }
                        : null,
                    child: (!_isSubmittedLoginForm)
                        ? const Text(
                            "Login",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(2.0),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          ),
                  )),
              GestureDetector(
                  onTap: () => context.push("/auth/register"),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "register",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ))
            ]),
          )),
    );
  }
}
