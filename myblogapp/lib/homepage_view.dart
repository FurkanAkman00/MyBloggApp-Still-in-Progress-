import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myblogapp/core/auth_manager.dart';
import 'package:myblogapp/core/theme_manager.dart';
import 'package:myblogapp/product/blog_card.dart';
import 'package:myblogapp/user/user_page_view.dart';
import 'package:provider/provider.dart';

import 'blog/blog_controller.dart';
import 'blog/single_blog_view.dart';
import 'models/BlogModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BlogController<HomePage> {
  late List<Blog>? blogs;

  @override
  void initState() {
    super.initState();
    _fetchBlogs();
  }

  Future<void> _fetchBlogs() async {
    setState(() {});
    blogs = await getAllBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: isLoading
            ? null
            : AppBar(
                backgroundColor: Colors.black87,
                title: const Text("All Blogs"),
                leading: IconButton(
                  onPressed: () {
                    _navigateToUserPage();
                  },
                  icon: const Icon(Icons.person),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        context.read<ThemeManager>().changeTheme();
                      },
                      icon: _themeChangeIcon(context)),
                  IconButton(
                      onPressed: () async {
                        handleLogOut(context);
                      },
                      icon: const Icon(Icons.logout_rounded))
                ],
              ),
        body: isLoading
            ? Center(
                child: Lottie.asset("assets/splash/SplashPageAnimation.json"))
            : blogProvider());
  }

  ListView blogProvider() {
    return ListView.builder(
      itemCount: blogs?.length ?? 0,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: _singleBlogCard(index),
        );
      },
    );
  }

  GestureDetector _singleBlogCard(int index) {
    return GestureDetector(
        onTap: () {
          _navigateToBlogPageFromHome(blogs![index], false);
        },
        child: BlogCard(blog: blogs![index]));
  }

  AnimatedCrossFade _themeChangeIcon(BuildContext context) {
    return AnimatedCrossFade(
        firstChild: const Icon(Icons.light_mode),
        secondChild: const Icon(Icons.dark_mode),
        crossFadeState: context.watch<ThemeManager>().lightTheme
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: const Duration(seconds: 1));
  }

  void _navigateToBlogPageFromHome(Blog blog, bool isUserBlog) {
    bool isLiked =
        context.read<AuthManager>().myUser?.likedBlogs?.contains(blog) ?? false;
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => SingleBlogView(
                  blog: blog,
                  isUserBlog: isUserBlog,
                  isLiked: isLiked,
                )))
        .then((value) => _fetchBlogs());
  }

  void _navigateToUserPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (context) => const UserPage(),
        ))
        .then((value) => _fetchBlogs());
  }
}
