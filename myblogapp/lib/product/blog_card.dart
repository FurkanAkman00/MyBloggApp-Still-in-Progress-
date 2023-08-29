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
                  left: CardValues.cardPadding,
                  right: CardValues.cardPadding,
                  top: CardValues.cardPadding,
                  bottom: CardValues.cardPaddingBottom),
              child: Row(
                children: [
                  SizedBox(
                    height: CardValues.authorNameHeight,
                    width: CardValues.authorNameWidth,
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: CardValues.cardAuthorNamePadding),
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
                    padding:
                        const EdgeInsets.only(left: CardValues.cardDatePadding),
                    child: Text(widget.blog.date.toString().split(" ")[0],
                        style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: CardValues.cardTitlePadding,
                  right: CardValues.cardTitlePadding),
              child: SizedBox(
                width: CardValues.cardTitleWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.blog.title}",
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: CardValues.cardDescriptionPadding),
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

class CardValues {
  static const double cardPadding = 25.0;
  static const double cardPaddingBottom = 10.0;
  static const double cardTitlePadding = 30.0;
  static const double cardDatePadding = 90.0;
  static const double cardDescriptionPadding = 8.0;
  static const double cardAuthorNamePadding = 8.0;

  static const double authorNameHeight = 50;
  static const double authorNameWidth = 160;
  static const double cardTitleWidth = 400.0;
}
