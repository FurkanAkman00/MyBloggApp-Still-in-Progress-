import 'package:flutter/material.dart';

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
      height: FieldValues.height,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            counterStyle: const TextStyle(color: FieldValues.counterColor),
            suffixIcon: IconButton(
              color: FieldValues.prefixSuffixIconColor,
              onPressed: () {
                changeVisible();
              },
              icon: AnimatedPasswordIcon(),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(FieldValues.borderRadius)),
            fillColor: FieldValues.fillColor,
            filled: true,
            prefixIconColor: FieldValues.prefixSuffixIconColor,
            suffixIconColor: FieldValues.prefixSuffixIconColor,
            prefixIcon: const Icon(Icons.password_outlined),
            hintText: FieldValues.hintText),
        maxLength: FieldValues.maxLength,
        keyboardType: TextInputType.visiblePassword,
        obscureText: isVisible ? false : true,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  AnimatedCrossFade AnimatedPasswordIcon() {
    return AnimatedCrossFade(
        firstChild: const Icon(
          Icons.remove_red_eye,
          color: FieldValues.prefixSuffixIconColor,
        ),
        secondChild: const Icon(
          Icons.remove_red_eye_outlined,
          color: FieldValues.prefixSuffixIconColor,
        ),
        crossFadeState:
            isVisible ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(seconds: FieldValues.durationValue));
  }
}

class FieldValues {
  // Colors
  static const counterColor = Colors.white;
  static const fillColor = Colors.white;
  static const prefixSuffixIconColor = Colors.black87;

  // Numeric Values
  static const height = 100.0;
  static const maxLength = 20;
  static const durationValue = 1;
  static const borderRadius = 20.0;

  // String Values
  static const hintText = "Password";
}
