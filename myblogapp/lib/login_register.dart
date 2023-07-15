import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:myblogapp/register_login/login.dart';
import 'package:myblogapp/register_login/register_view.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister>
    with TickerProviderStateMixin {
  late final _controller;
  double notchedvalue = 10.0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(40))),
              title: _myTabBar()),
          body: _MyTabBarView(),
        ));
  }

  TabBar _myTabBar() {
    return TabBar(
        labelColor: Theme.of(context).textTheme.bodyText1?.color,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        controller: _controller,
        tabs: myTabs.values.map((e) => Tab(text: e.name)).toList());
  }

  TabBarView _MyTabBarView() {
    return TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: const [LoginPage(), RegisterView()]);
  }
}

enum myTabs { Login, Register }
