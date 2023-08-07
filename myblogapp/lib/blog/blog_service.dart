import 'dart:io';
import 'package:dio/dio.dart';
import 'package:myblogapp/models/BlogModel.dart';

abstract class IBlogService {
  Dio _dio;
  IBlogService(this._dio, this.token);
  String token;
  Future<List<Blog>?> getAllPosts();
  Future<List<Blog>?> getUserBlogs();
  Future<bool?> postBlog(Blog blog);
}

class BlogService extends IBlogService {
  BlogService(super.dio, super.token);

  @override
  Future<List<Blog>?> getAllPosts() async {
    try {
      final response = await _dio.get("/all");
      if (response.statusCode == HttpStatus.ok) {
        final blogs = response.data;
        if (blogs is List) {
          return blogs.map((e) => Blog.fromJson(e)).toList();
        }
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  @override
  Future<bool?> postBlog(Blog blog) async {
    try {
      final response = await _dio.post(
        "/",
        data: {
          "title": blog.title,
          "content": blog.content,
          "description": blog.description,
          "token": token
        },
      );
      if (response.statusCode == HttpStatus.created) {
        return true;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Blog>?> getUserBlogs() async {
    final result = await _dio.get("/userPost/$token");
    if (result.statusCode == HttpStatus.ok) {
      final blogs = result.data;
      if (blogs is List) {
        return blogs.map((e) => Blog.fromJson(e)).toList();
      }
    } else {
      return null;
    }
    return null;
  }

  Future<bool?> deleteBlog(Blog blog) async {
    final result =
        await _dio.delete("/userPostDelete/$token", data: blog.toJson());
    if (result.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }
}
