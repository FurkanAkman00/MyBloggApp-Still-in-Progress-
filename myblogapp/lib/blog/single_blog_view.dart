import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myblogapp/blog/blog_controller.dart';

import '../models/BlogModel.dart';

class SingleBlogView extends StatefulWidget {
  const SingleBlogView(
      {super.key,
      required this.blog,
      required this.isUserBlog,
      required this.isLiked});
  final Blog blog;
  final bool isUserBlog;
  final bool isLiked;

  @override
  State<SingleBlogView> createState() => _SingleBlogViewState();
}

class _SingleBlogViewState extends BlogController<SingleBlogView> {
  late bool isLikedBlog;
  @override
  void initState() {
    super.initState();
    isLikedBlog = widget.isLiked;
  }

  void changeIsliked() {
    setState(() {
      isLikedBlog = !isLikedBlog;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: widget.isUserBlog
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: IconButton(
                      splashRadius: 25,
                      onPressed: () {
                        changeIsliked();
                        likeBlog(widget.blog, isLikedBlog);
                      },
                      icon: isLikedBlog
                          ? const Icon(Icons.check_circle)
                          : const Icon(Icons.check_circle_outline)),
                ),
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
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[700]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      widget.blog.title ?? "Noo",
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 10, right: 10, bottom: 25),
                    child: Text(
                      widget.blog.content!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        wordSpacing: 1,
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
