import 'package:flutter/material.dart';
import 'package:myblogapp/register_login/register_login_controller.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends RegisterLoginController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/appImage/appImage.png"),
                  Text("Think", style: _headerStyle()),
                  Text("Create", style: _headerStyle()),
                  Text("Post", style: _headerStyle())
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: SizedBox(
              child: Column(
                children: [
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                        onPressed: navigateToRegisterPage,
                        child: const Text("Sign Up")),
                  ),
                  SizedBox(
                      width: 300,
                      child: ElevatedButton(
                          onPressed: navigateToLoginPage,
                          child: const Text("Login")))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  TextStyle _headerStyle() => const TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
      fontSize: 40,
      letterSpacing: 2);
}
