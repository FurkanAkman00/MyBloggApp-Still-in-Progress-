import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/BlogModel.dart';

class SingleBlogView extends StatefulWidget {
  const SingleBlogView({super.key, required this.blog});
  final Blog blog;

  @override
  State<SingleBlogView> createState() => _SingleBlogViewState();
}

class _SingleBlogViewState extends State<SingleBlogView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.blog.title ?? "NODATA")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                color: const Color.fromARGB(255, 30, 127, 130),
              ),
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
                    widget.blog.author ?? "Furkan Akman",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white60),
                  ),
                  Text(
                    widget.blog.date.toString().split(" ")[0],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white60),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
