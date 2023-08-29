import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myblogapp/blog/blog_controller.dart';

import '../models/BlogModel.dart';

class SingleBlogView extends StatefulWidget {
  const SingleBlogView({
    super.key,
    required this.blog,
    required this.isUserBlog,
  });
  final Blog blog;
  final bool isUserBlog;

  @override
  State<SingleBlogView> createState() => _SingleBlogViewState();
}

class _SingleBlogViewState extends BlogController<SingleBlogView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: widget.isUserBlog
              ? const SizedBox.shrink()
              : IconButton(
                  splashRadius: BlogValues.buttonSplashRadius,
                  onPressed: () {},
                  icon: const Icon(Icons.check_circle_outline)),
          backgroundColor: Colors.black87,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
                onPressed: () {
                  navigateStartPage();
                },
                icon: const Icon(Icons.logout))
          ]),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
        child: SingleChildScrollView(
          child: Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 5),
                  borderRadius:
                      BorderRadius.circular(BlogValues.containerRadius),
                  color: Colors.grey[700]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      widget.blog.title ?? "Noo",
                      style: const TextStyle(
                          fontSize: BlogValues.contentTitleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: BlogValues.contentPaddingTop,
                        left: BlogValues.contentPaddingLeft,
                        right: BlogValues.contentPaddingRight,
                        bottom: BlogValues.contentPaddingBottom),
                    child: Text(
                      widget.blog.content!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: BlogValues.contentFontsize,
                        wordSpacing: BlogValues.contentWordSpacing,
                      ),
                    ),
                  ),
                  Text(
                    widget.blog.authorName ?? "Furkan Akman",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white60),
                  ),
                  Text(
                    widget.blog.date.toString().split(" ")[0],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white60),
                  ),
                  widget.isUserBlog
                      ? ElevatedButton(
                          onPressed: () async {
                            final result = await deleteBlog(widget.blog);
                            if (result == true) {
                              Navigator.of(context).pop();
                            } else {
                              navigateStartPage();
                            }
                          },
                          child: const Text("Delete Blog"))
                      : const SizedBox.shrink()
                ],
              )),
        ),
      ),
    );
  }
}

class BlogValues {
  static const double contentPaddingTop = 20;
  static const double contentPaddingLeft = 10;
  static const double contentPaddingRight = 10;
  static const double contentPaddingBottom = 25;
  static const double contentFontsize = 15;
  static const double contentWordSpacing = 1;

  static const double contentTitleFontSize = 25;
  static const double buttonSplashRadius = 25;

  static const double containerRadius = 20;
}
