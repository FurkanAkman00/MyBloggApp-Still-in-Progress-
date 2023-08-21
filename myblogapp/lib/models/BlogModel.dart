class Blog {
  String? title;
  String? content;
  String? authorName;
  String? authorEmail;
  String? description;
  int? likeCount;
  DateTime? date;

  Blog({
    this.title,
    this.content,
    this.authorName,
    this.authorEmail,
    this.description,
    this.date,
    this.likeCount,
  });

  Blog.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    likeCount = json['likeCount'];
    content = json['content'];
    authorEmail = json['authorEmail'];
    authorName = json['authorName'];
    description = json['description'];
    date = DateTime.parse(json['date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['authorName'] = authorName;
    data['authorEmail'] = authorEmail;
    data['description'] = description;
    data['likeCount'] = likeCount;
    data['date'] = date?.toIso8601String();
    return data;
  }
}
