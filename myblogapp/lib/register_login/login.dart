import 'package:flutter/material.dart';
import 'package:myblogapp/product/password_field.dart';

import 'register_login_controller.dart';
import '../validate.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends RegisterLoginController {
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
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: LoginPageValues.formFieldWidth,
              child: Column(
                children: [
                  showError
                      ? const Text(LoginPageValues.errorMessage)
                      : const SizedBox.shrink(),
                  Image.asset(
                    LoginPageValues.imagePath,
                    height: LoginPageValues.imageHeigth,
                  ),
                  const Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: LoginPageValues.textFontSize),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: LoginPageValues.fieldPadding),
                    child: Column(
                      children: [
                        _emailTextField(),
                        MyPasswordField(
                          validator: Validate.password,
                          controller: passwordController,
                        ),
                        _loginButton()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _loginButton() {
    return SizedBox(
        width: LoginPageValues.buttonWidth,
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            LoginPageValues.borderRadius)))),
            onPressed: handleLoginSubmit,
            child: const Text(LoginPageValues.loginText)));
  }

  TextFormField _emailTextField() {
    return TextFormField(
      validator: Validate.email,
      controller: emailController,
      textInputAction: TextInputAction.next,
      maxLength: LoginPageValues.emailMaxLength,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: LoginPageValues.emailAdress,
        counterStyle: const TextStyle(color: LoginPageValues.counterColor),
        fillColor: LoginPageValues.fillColor,
        filled: true,
        prefixIconColor: LoginPageValues.prefixIconColor,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(LoginPageValues.borderRadius)),
        prefixIcon: const Icon(Icons.mail),
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

class LoginPageValues {
  // Double values
  static const formFieldWidth = 350.0;
  static const imageHeigth = 200.0;
  static const borderRadius = 20.0;
  static const textFontSize = 30.0;
  static const emailMaxLength = 30;
  static const buttonWidth = 200.0;
  static const fieldPadding = 50.0;

  // String Values
  static const imagePath = "assets/login-register/login-register-page-icon.png";
  static const loginText = "Login";
  static const emailAdress = "Email Adress";
  static const password = "Password";
  static const errorMessage = "Wrong password or email. Please try again.";

  // Color Values
  static const prefixIconColor = Colors.black87;
  static const counterColor = Colors.white;
  static const fillColor = Colors.white;
}
