import 'package:flutter/material.dart';

import '../models/BlogModel.dart';

class BlogCard extends StatefulWidget {
  const BlogCard({
    super.key,
    required this.blog,
  });
  final Blog blog;

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: SizedBox(
      height: MediaQuery.sizeOf(context).height * 1 / 3,
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, top: 25, bottom: 10),
              child: Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 160,
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "${widget.blog.authorName}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90.0),
                    child: Text(widget.blog.date.toString().split(" ")[0],
                        style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: SizedBox(
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.blog.title}",
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "${widget.blog.description}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Align(
              alignment: const Alignment(0, 0.75),
              child: Text(
                "Like: ${widget.blog.likeCount ?? 0}",
                style: const TextStyle(color: Colors.white),
              ),
            )),
          ],
        ),
      ),
    ));
  }
}
