import 'package:flutter/material.dart';
import 'package:myblogapp/register_login/start_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _MySplashPageState();
}

class _MySplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) {
      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginRegister()));
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const StartPage(),
            transitionDuration: const Duration(seconds: 1),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          ),
          ModalRoute.withName("/SplashPage"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/appImage/appImage.png"),
            // Lottie.asset("assets/splash/SplashPageAnimation.json")
          ],
        ),
      )),
    );
  }
}
