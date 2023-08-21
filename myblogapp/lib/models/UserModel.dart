import 'BlogModel.dart';

class User {
  String? username;
  String? password;
  String? email;
  List<Blog>? blogs;
  List<Blog>? likedBlogs;

  User({this.username, this.password, this.email, this.blogs});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    if (json['blogs'] != null) {
      blogs = <Blog>[];
      json['blogs'].forEach((v) {
        blogs!.add(Blog.fromJson(v));
      });
    }
    if (json['likedBlogs'] != null) {
      likedBlogs = <Blog>[];
      json['likedBlogs'].forEach((v) {
        likedBlogs!.add(Blog.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['email'] = email;
    if (blogs != null) {
      data['blogs'] = blogs!.map((v) => v.toJson()).toList();
    }
    if (likedBlogs != null) {
      data['likedBlogs'] = likedBlogs!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
