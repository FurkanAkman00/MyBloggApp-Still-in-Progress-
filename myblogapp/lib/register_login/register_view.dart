import 'package:flutter/material.dart';
import 'package:myblogapp/validate.dart';

import '../models/UserModel.dart';
import '../product/password_field.dart';
import 'register_login_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends RegisterLoginController {
  late final TextEditingController emailController;
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;

  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    usernameController = TextEditingController();
  }

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                showError
                    ? const Padding(
                        padding: EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          "An error has accured. This email might already in use. Please try again.",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  height: 65,
                  child: TextFormField(
                    controller: usernameController,
                    validator: Validate.username,
                    maxLength: 10,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.abc),
                        labelText: "Username"),
                  ),
                ),
                SizedBox(
                  height: 65,
                  child: TextFormField(
                    controller: emailController,
                    validator: Validate.email,
                    maxLength: 30,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.mail),
                        labelText: "Email Adress"),
                  ),
                ),
                MyPasswordField(
                  controller: passwordController,
                  validator: Validate.password,
                ),
                SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: handleSubmit, child: const Text("Register")))
              ],
            ),
          ),
        ),
      ),
    );
  }

  User createUser() {
    final user = User(
        username: usernameController.text,
        password: passwordController.text,
        email: emailController.text);
    return user;
  }

  void deleteFields() {
    usernameController.text = "";
    passwordController.text = "";
    emailController.text = "";
  }

  Future<void> handleSubmit() async {
    if (_key.currentState?.validate() ?? false) {
      changeError(false);
      await registerUser(createUser());
      deleteFields();
    }
  }
}
