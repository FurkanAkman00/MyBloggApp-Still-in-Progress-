import 'package:flutter/material.dart';
import 'package:myblogapp/product/blog_card.dart';
import 'package:myblogapp/user/create_user_blog.dart';

import '../blog/blog_controller.dart';
import '../blog/single_blog_view.dart';
import '../models/BlogModel.dart';
import '../register_login/start_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends BlogController<UserPage> {
  List<Blog>? blogs = [];

  Future<void> fetchUserBlogs() async {
    blogs = await getUserBlogs();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchUserBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return blogs == null
        ? const StartPage()
        : Scaffold(
            appBar: AppBar(
              title: const Text(_MyTexts.appBarTitle),
              backgroundColor: Colors.black87,
              actions: [
                IconButton(
                    onPressed: () {
                      _navigateToCreateBlog();
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            body: isLoading
                ? const Center(child: CircularProgressIndicator())
                : _listUserBlogs(),
          );
  }

  ListView _listUserBlogs() {
    return ListView.builder(
      itemCount: blogs?.length,
      itemBuilder: (context, index) {
        return blogs == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: _singleUserBlog(context, index),
              );
      },
    );
  }

  GestureDetector _singleUserBlog(BuildContext context, int index) {
    return GestureDetector(
        onTap: () => _navigateToUserBlogPage(index),
        child: BlogCard(blog: blogs![index]));
  }

  void _navigateToUserBlogPage(int index) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => SingleBlogView(
                  blog: blogs![index],
                  isUserBlog: true,
                  isLiked: false,
                )))
        .then((value) => fetchUserBlogs());
  }

  void _navigateToCreateBlog() {
    Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (context) => const CreateBlog(),
        ))
        .then((value) => fetchUserBlogs());
  }
}

class _MyTexts {
  static const appBarTitle = "Your Blogs";
}
