import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myblogapp/blog/blog_service.dart';
import 'package:myblogapp/models/BlogModel.dart';
import 'package:myblogapp/register_login/start_page.dart';
import 'package:provider/provider.dart';
import '../core/auth_manager.dart';

abstract class BlogController<T extends StatefulWidget> extends State<T> {
  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  final _baseUrl = "http://10.0.2.2:5000/blogs";
  late final BlogService blogService;
  @override
  void initState() {
    super.initState();
    blogService = BlogService(
        Dio(BaseOptions(baseUrl: _baseUrl, validateStatus: (_) => true)),
        context.read<AuthManager>().myToken);
  }

  Future<List<Blog>?> getAllBlogs() async {
    changeLoading();
    final blogs = await blogService.getAllBlogs();
    await Future.delayed(const Duration(seconds: 2));
    changeLoading();
    if (blogs != null) {
      return blogs;
    } else {
      return null;
    }
  }

  Future<bool?> postBlog(Blog blog) async {
    changeLoading();
    final result = await blogService.postBlog(blog);

    changeLoading();
    return result;
  }

  Future<List<Blog>?> getUserBlogs() async {
    changeLoading();
    final blogs = await blogService.getUserBlogs();
    changeLoading();
    if (blogs != null) {
      return blogs;
    } else {
      return null;
    }
  }

  Future<bool?> likeBlog(Blog blog, bool isLiked) async {
    changeLoading();
    if (isLiked == false) {
      context.read<AuthManager>().myUser?.likedBlogs?.add(blog);
      final result = await blogService.likeBlog(blog, isLiked);
      changeLoading();
      return result;
    } else {
      context.read<AuthManager>().myUser?.likedBlogs?.remove(blog);
      final result = await blogService.likeBlog(blog, isLiked);
      changeLoading();
      return result;
    }
  }

  Future<bool?> deleteBlog(Blog blog) async {
    changeLoading();
    final result = await blogService.deleteBlog(blog);
    changeLoading();
    return result;
  }

  void navigateStartPage() async {
    await context.read<AuthManager>().deleteAll();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const StartPage()),
        (Route<dynamic> route) => false);
  }

  Future<void> handleLogOut(BuildContext context) async {
    await context.read<AuthManager>().deleteAll();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => StartPage()),
        (Route<dynamic> route) => false);
  }
}
