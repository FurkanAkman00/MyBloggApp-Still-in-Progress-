import 'package:flutter/material.dart';
import 'package:myblogapp/user/create_user_blog.dart';

import '../blog/blog_controller.dart';
import '../models/BlogModel.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends BlogController<UserPage> {
  @override
  void initState() {
    super.initState();
    fetchUserBlogs();
  }

  late List<Blog>? blogs;
  Offset _tabPosition = Offset.zero;

  Future<void> fetchUserBlogs() async {
    blogs = await getUserBlogs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Blogs"),
        actions: [
          IconButton(
              onPressed: () {
                navigateToCreateBlog();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _listUserBlogs(),
    );
  }

  ListView _listUserBlogs() {
    return ListView.builder(
      itemCount: blogs!.length,
      itemBuilder: (context, index) {
        return blogs == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: GestureDetector(
                    onTapDown: _getTapPosition,
                    child: ListTile(
                      onLongPress: () {
                        _showContextMenu(context, blogs?[index]);
                      },
                      dense: true,
                      tileColor: const Color.fromARGB(255, 7, 101, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      title: Center(
                        child: Text(
                          "${blogs![index].title} By ${blogs![index].author}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                      leading: const CircleAvatar(
                        radius: 28,
                        backgroundImage:
                            NetworkImage("https://picsum.photos/200/300"),
                      ),
                      subtitle: SizedBox(
                          height: 70,
                          child: Text(
                            blogs![index].description ?? "NoData",
                            style: const TextStyle(color: Colors.white60),
                          )),
                      trailing: IconButton(
                        color: Colors.black,
                        onPressed: () {
                          navigateToBlogPage(blogs![index]);
                        },
                        icon: const Icon(Icons.arrow_right),
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  void _getTapPosition(TapDownDetails tapPosition) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tabPosition = renderBox.globalToLocal(tapPosition.globalPosition);
    });
  }

  void _showContextMenu(context, Blog? blog) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();
    final result = await showMenu(
        context: context,
        position: RelativeRect.fromRect(
            Rect.fromLTWH(_tabPosition.dx, _tabPosition.dy, 10, 10),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay.paintBounds.size.height)),
        items: [
          const PopupMenuItem(value: "delete", child: Text("Delete Blog")),
        ]);

    if (result == "delete") {
      final result = await deleteBlog(blog!);
      if (result != null && result) {
        await fetchUserBlogs();
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return _showError(context);
          },
        );
      }
    }
  }

  AlertDialog _showError(BuildContext context) {
    return AlertDialog(
        title: const Text("Some error has accured. Try again later"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"))
        ]);
  }

  void navigateToCreateBlog() {
    Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (context) => const CreateBlog(),
        ))
        .then((value) => fetchUserBlogs());
  }
}
