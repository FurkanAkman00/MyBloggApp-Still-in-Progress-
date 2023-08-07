import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myblogapp/blog/blog_service.dart';
import 'package:myblogapp/blog/single_blog_view.dart';
import 'package:myblogapp/models/BlogModel.dart';
import 'package:provider/provider.dart';

import '../core/auth_manager.dart';

abstract class BlogController<T extends StatefulWidget> extends State<T> {
  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  // {your ip adress}:5000/blogs.
  final _baseUrl = "http://192.168.1.173:5000/blogs";
  late final BlogService blogService;
  @override
  void initState() {
    super.initState();
    blogService = BlogService(Dio(BaseOptions(baseUrl: _baseUrl)),
        context.read<AuthManager>().myToken);
  }

  Future<List<Blog>?> getAllBlogs() async {
    changeLoading();
    final blogs = await blogService.getAllPosts();
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

  Future<bool?> deleteBlog(Blog blog) async {
    changeLoading();
    final result = await blogService.deleteBlog(blog);
    changeLoading();
    return result;
  }

  void navigateToBlogPage(Blog blog) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => SingleBlogView(blog: blog)));
  }
}
