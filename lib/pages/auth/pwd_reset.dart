import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppingchk/layout/responsive/rwd_layout.dart';

class ResetPasswordPage extends StatefulWidget {
  final String emailAddress;
  const ResetPasswordPage({super.key, required this.emailAddress});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _verifyCodeController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _pwdConfirmController = TextEditingController();

  bool _isFormSubbmited = false;
  String errorMessage = "";

  void _handlePasswordReset() async {
    try {
      final result = await Amplify.Auth.confirmResetPassword(
          username: widget.emailAddress,
          newPassword: _pwdController.text,
          confirmationCode: _verifyCodeController.text.trim());
      if (result.isPasswordReset) {
        context.go("/auth/login");
      }
    } on AuthException catch (e) {
      setState(() {
        errorMessage = "Error Resetting password: $e";
        _isFormSubbmited = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.close_rounded))
        ],
      ),
      body: RWDLayout(
        alignment: Alignment.center,
        child: Column(children: [
          const Text("Please enter the verify code."),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: TextFormField(
                autofocus: true,
                controller: _verifyCodeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: "Verify Code",
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Please enter the verify code"
                    : null,
              )),
          const Divider(),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: TextFormField(
                autofocus: true,
                obscureText: true,
                autocorrect: false,
                controller: _pwdConfirmController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: "New Password",
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Please enter new Password"
                    : null,
              )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: TextFormField(
                autofocus: true,
                obscureText: true,
                autocorrect: false,
                controller: _pwdConfirmController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: "Confirmed New Password",
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Please enter confirmed Password"
                    : (value != _pwdConfirmController.text)
                        ? "Password and Confirmed Password not match"
                        : null,
              )),
          if (errorMessage.isNotEmpty) ...[
            Text(errorMessage, style: const TextStyle(color: Colors.red))
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
              onPressed: (_isFormSubbmited)
                  ? null
                  : () async {
                      if ((_formKey.currentState as FormState).validate()) {
                        setState(() {
                          _isFormSubbmited = true;
                          errorMessage = "";
                        });
                        _handlePasswordReset();
                      }
                    },
              child: (!_isFormSubbmited)
                  ? const Text(
                      "Reset",
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
            ),
          ),
        ]),
      ),
    );
  }
}
