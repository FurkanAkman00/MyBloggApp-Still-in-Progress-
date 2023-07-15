class Blog {
  String? title;
  String? content;
  String? author;
  String? description;
  DateTime? date;

  Blog({this.title, this.content, this.author, this.description, this.date});

  Blog.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    author = json['author'];
    description = json['description'];
    date = DateTime.parse(json['date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['content'] = content;
    data['author'] = author;
    data['description'] = description;
    data['date'] = date?.toIso8601String();
    return data;
  }
}
