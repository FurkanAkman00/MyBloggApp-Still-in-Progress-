import 'dart:io';
import 'package:dio/dio.dart';
import 'package:myblogapp/models/BlogModel.dart';

abstract class IBlogService {
  Dio _dio;
  IBlogService(this._dio, this.token);
  String token;
  Future<List<Blog>?> getAllBlogs();
  Future<List<Blog>?> getUserBlogs();
  Future<bool?> postBlog(Blog blog);
  Future<bool?> deleteBlog(Blog blog);
  // Future<List<Blog>?> getLikedBlogs();
  Future<bool?> likeBlog(Blog blog, bool isLiked);
  Future<bool?> isLikedBlog(Blog blog);
}

class BlogService extends IBlogService {
  BlogService(super.dio, super.token);

  @override
  Future<List<Blog>?> getAllBlogs() async {
    try {
      final response = await _dio.get("/all");
      if (response.statusCode == HttpStatus.ok) {
        final blogs = response.data;

        if (blogs is List) {
          List<Blog> myBlogs = blogs.map((e) => Blog.fromJson(e)).toList();
          return myBlogs;
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
        "/createBlog",
        data: {
          "title": blog.title,
          "content": blog.content,
          "description": blog.description,
        },
      );
      if (response.statusCode == HttpStatus.created) {
        return true;
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return false;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Blog>?> getUserBlogs() async {
    final result = await _dio.get("/userBlogs");
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

  @override
  Future<bool?> isLikedBlog(Blog blog) async {
    final response = await _dio.get("/isLikedBlog", data: blog.toJson());
    if (response.statusCode == HttpStatus.ok) {
      final result = response.data;
      print(result);
      if (result is bool) {
        return result;
      } else {
        return null;
      }
    }
    return null;
  }

/*   @override
  Future<List<Blog>?> getLikedBlogs() async {
    final result = await _dio.get("/likedBlogs/$token");
    if (result.statusCode == HttpStatus.ok) {
      final likedBlogs = result.data;
      if (likedBlogs is List) {
        return likedBlogs.map((e) => Blog.fromJson(e)).toList();
      }
    } else {
      return null;
    }
    return null;
  } */

  @override
  Future<bool?> deleteBlog(Blog blog) async {
    final result = await _dio.delete("/userBlogDelete", data: blog.toJson());
    if (result.statusCode == HttpStatus.ok) {
      return true;
    } else if (result.statusCode == HttpStatus.unauthorized) {
      return false;
    } else {
      return null;
    }
  }

  @override
  Future<bool?> likeBlog(Blog blog, bool isLiked) async {
    final result = await _dio.put("/likeBlog/$isLiked", data: blog.toJson());
    if (result.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return null;
    }
  }
}
