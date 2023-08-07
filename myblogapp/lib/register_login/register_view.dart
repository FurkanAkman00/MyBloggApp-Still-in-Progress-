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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: RegisterFieldValues.formFieldWidth,
              child: Column(
                children: [
                  showError
                      ? const Padding(
                          padding: EdgeInsets.only(bottom: 12.0),
                          child: Text(
                            RegisterFieldValues.errorMessage,
                            style: TextStyle(
                                color: RegisterFieldValues.errorColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : const SizedBox.shrink(),
                  Image.asset(
                    RegisterFieldValues.imagePath,
                    height: RegisterFieldValues.imageHeight,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      RegisterFieldValues.signup,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: RegisterFieldValues.blackColor,
                          fontSize: RegisterFieldValues.fontSize),
                    ),
                  ),
                  TextFormField(
                    controller: usernameController,
                    validator: Validate.username,
                    maxLength: RegisterFieldValues.maxUserName,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                RegisterFieldValues.fieldBorderRadius)),
                        prefixIcon: const Icon(
                          Icons.abc,
                          color: RegisterFieldValues.blackColor,
                        ),
                        labelText: RegisterFieldValues.userName),
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: Validate.email,
                    textInputAction: TextInputAction.next,
                    maxLength: RegisterFieldValues.emailMaxLength,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        fillColor: RegisterFieldValues.fillColor,
                        filled: true,
                        prefixIconColor: RegisterFieldValues.blackColor,
                        counterStyle: const TextStyle(
                            color: RegisterFieldValues.fillColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                RegisterFieldValues.fieldBorderRadius)),
                        prefixIcon: const Icon(Icons.mail),
                        hintText: RegisterFieldValues.email),
                  ),
                  MyPasswordField(
                    controller: passwordController,
                    validator: Validate.password,
                  ),
                  SizedBox(
                      width: RegisterFieldValues.imageHeight,
                      child: ElevatedButton(
                          onPressed: handleSubmit,
                          child: const Text(RegisterFieldValues.signup)))
                ],
              ),
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

class RegisterFieldValues {
  static const formFieldWidth = 350.0;
  static const maxUserName = 10;
  static const fieldBorderRadius = 20.0;
  static const imageHeight = 200.0;
  static const emailMaxLength = 30;
  static const fontSize = 30.0;

  static const blackColor = Colors.black87;
  static const errorColor = Colors.red;
  static const fillColor = Colors.white;

  static const errorMessage =
      "An error has accured. This email might already in use. Please try again.";
  static const imagePath = "assets/login-register/login-register-page-icon.png";
  static const userName = "Username";
  static const email = "Email";
  static const password = "Password";
  static const signup = "Sign Up";
}
