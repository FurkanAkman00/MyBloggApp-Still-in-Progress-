import 'package:flutter/material.dart';
import 'package:myblogapp/blog/single_blog_view.dart';
import 'package:myblogapp/core/theme_manager.dart';
import 'package:myblogapp/user/user_page_view.dart';
import 'package:provider/provider.dart';

import 'blog/blog_controller.dart';
import 'core/auth_manager.dart';
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
    fetchBlogs();
  }

  Future<void> fetchBlogs() async {
    setState(() {});
    blogs = await getAllBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 95.0),
            child: Text("All Blogs"),
          ),
          leading: IconButton(
            onPressed: () {
              navigateToUserPage();
            },
            icon: const Icon(Icons.person),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<ThemeManager>().changeTheme();
                },
                icon: AnimatedCrossFade(
                    firstChild: const Icon(Icons.light_mode),
                    secondChild: const Icon(Icons.dark_mode),
                    crossFadeState: context.watch<ThemeManager>().lightTheme
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(seconds: 1))),
            IconButton(
                onPressed: () async {
                  handleLogOut(context);
                },
                icon: const Icon(Icons.logout_rounded))
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : blogProvider());
  }

  ListView blogProvider() {
    return ListView.builder(
      itemCount: blogs?.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            dense: true,
            tileColor: const Color.fromARGB(255, 7, 101, 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            title: Center(
              child: Text(
                "${blogs![index].title} By ${blogs![index].title}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              ),
            ),
            leading: const CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage("https://picsum.photos/200/300"),
            ),
            subtitle: SizedBox(
                height: 70,
                child: Text(
                  blogs![index].description ?? "NoData",
                  style: const TextStyle(color: Colors.white60),
                )),
            trailing: IconButton(
              color: Colors.black,
              onPressed: () {
                navigateToBlogPage(blogs![index]);
              },
              icon: const Icon(Icons.arrow_right),
            ),
          ),
        );
      },
    );
  }

  void navigateToUserPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (context) => const UserPage(),
        ))
        .then((value) => fetchBlogs());
  }

  Future<void> handleLogOut(BuildContext context) async {
    await context.read<AuthManager>().deleteAll();
    Navigator.pop(context);
  }
}
