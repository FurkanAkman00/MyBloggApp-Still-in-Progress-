import 'package:flutter/material.dart';
import 'package:myblogapp/product/password_field.dart';

import 'register_login_controller.dart';
import '../validate.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends RegisterLoginController {
  final texts = MyLoginText();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _key,
          child: SizedBox(
            width: 320,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                showError
                    ? const Text("Wrong password or email. Please try again.")
                    : const SizedBox.shrink(),
                TextFormField(
                  validator: Validate.email,
                  controller: emailController,
                  maxLength: 30,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.mail),
                      labelText: texts.emailAdress),
                ),
                MyPasswordField(
                  validator: Validate.password,
                  controller: passwordController,
                ),
                SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: handleLoginSubmit,
                        child: Text(texts.loginText)))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleLoginSubmit() async {
    if (_key.currentState?.validate() ?? false) {
      changeError(false);
      await loginUser(emailController.text, passwordController.text);
      deleteFields();
    }
  }

  void deleteFields() {
    passwordController.text = "";
    emailController.text = "";
  }
}

class MyLoginText {
  final loginText = "Login";
  final emailAdress = "Email Adress";
  final password = "Password";
}
