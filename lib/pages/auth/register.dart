import 'dart:math';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppingchk/layout/responsive/rwd_layout.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

const List<String> genderList = ["M", "F"];

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _pwdChkController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String errorMessage = "";
  bool _isDuplciatedUsername = false;

  // Future<bool> _checkIsDuplicatedUsername() async {
  //   String username = _usernameController.text;
  //   // List<User> users = await Amplify.DataStore.query(User.classType,
  //   //     where: User.USERNAME.eq(username),
  //   //     pagination: const QueryPagination(limit: 1));

  //   setState(() {
  //     _isDuplciatedUsername = users.isNotEmpty;
  //   });
  //   return users.isNotEmpty;
  // }

  Future<void> _handleSignUpResult(SignUpResult result) async {
    switch (result.nextStep.signUpStep) {
      case AuthSignUpStep.confirmSignUp:
        context.go("/auth/verify", extra: _emailController.text.trim());
        // final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        // _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthSignUpStep.done:
        context.pop();
        break;
    }
  }

  Future<void> handleRegister() async {
    final email = _emailController.text.trim();
    final username = _usernameController.text.trim();
    final password = _pwdChkController.text;
    final gender = _genderController.text.trim();
    final name = _nameController.text.trim();

    try {
      final userAttrubutes = <AuthUserAttributeKey, String>{
        AuthUserAttributeKey.preferredUsername: username,
        AuthUserAttributeKey.email: email,
        AuthUserAttributeKey.gender: gender,
        AuthUserAttributeKey.name: name,
      };

      final result = await Amplify.Auth.signUp(
          username: email,
          password: password,
          options: SignUpOptions(userAttributes: userAttrubutes));

      _handleSignUpResult(result);
    } on AuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _pwdController.dispose();
    _pwdChkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("Register"),
        ),
        body: Form(
            key: _formKey,
            child: RWDLayout(
              child: ListView(
                children: [
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text("Please enter following information")),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: TextFormField(
                        autofocus: true,
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
                            : null,
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: TextFormField(
                        autofocus: true,
                        controller: _usernameController,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: "Username",
                            errorText: _isDuplciatedUsername
                                ? 'Username is Exists'
                                : null),
                        validator: (value) => value == null || value.isEmpty
                            ? "Username required"
                            : null,
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: TextFormField(
                        autofocus: true,
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelText: "Name",
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? "Name is required"
                            : null,
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: TextFormField(
                          autofocus: true,
                          autocorrect: false,
                          enableSuggestions: false,
                          obscureText: true,
                          controller: _pwdController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: "Password",
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? "Password is required"
                              : null)),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: TextFormField(
                          autofocus: true,
                          enableSuggestions: false,
                          obscureText: true,
                          autocorrect: false,
                          controller: _pwdChkController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            labelText: "Confirm Password",
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? "Confirm Password is Missing"
                              : _pwdController.text != value
                                  ? "Password and Confirm Password not match"
                                  : null)),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: DropdownMenu<String>(
                        label: const Text("Gender"),
                        controller: _genderController,
                        initialSelection: genderList.first,
                        dropdownMenuEntries: genderList
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value, label: value);
                        }).toList(),
                      )),
                  if (errorMessage.isNotEmpty) ...[
                    Text(errorMessage,
                        style: const TextStyle(color: Colors.red))
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
                        child: const Text(
                          "Submit",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          if ((_formKey.currentState as FormState).validate()) {
                            // if (!await _checkIsDuplicatedUsername()) {
                            handleRegister();
                            // }
                          }
                        },
                      )),
                ],
              ),
            )));
  }
}
