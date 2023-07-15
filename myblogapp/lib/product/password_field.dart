import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyPasswordField extends StatefulWidget {
  const MyPasswordField(
      {super.key, required this.validator, required this.controller});

  final String? Function(String? value) validator;
  final TextEditingController controller;

  @override
  State<MyPasswordField> createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  bool isVisible = false;

  void changeVisible() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                changeVisible();
              },
              icon: AnimatedPasswordIcon(),
            ),
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.password_outlined),
            labelText: "Password"),
        maxLength: 20,
        keyboardType: TextInputType.visiblePassword,
        obscureText: isVisible ? false : true,
      ),
    );
  }

  AnimatedCrossFade AnimatedPasswordIcon() {
    return AnimatedCrossFade(
        firstChild: const Icon(Icons.remove_red_eye),
        secondChild: const Icon(Icons.remove_red_eye_outlined),
        crossFadeState:
            isVisible ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(seconds: 1));
  }
}
