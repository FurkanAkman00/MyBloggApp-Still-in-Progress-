import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:myblogapp/blog/blog_controller.dart';
import 'package:myblogapp/core/auth_manager.dart';
import 'package:provider/provider.dart';

import '../models/BlogModel.dart';
import '../validate.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({super.key});

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends BlogController<CreateBlog> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Create A Blog"),
        actions: [
          // WTF?
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox.shrink()
        ],
      ),
      body: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    width: 10, color: const Color.fromARGB(255, 12, 93, 120)),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      validator: Validate.title,
                      decoration: const InputDecoration(
                        hintText: "Title",
                        border: OutlineInputBorder(),
                      ),
                      controller: _titleController,
                      maxLength: 20,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      validator: Validate.notEmpty,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Description"),
                      expands: true,
                      maxLines: null,
                      controller: _descriptionController,
                      maxLength: 100,
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 3,
                      validator: Validate.notEmpty,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                          hintText: "Content"),
                      scrollPhysics: const AlwaysScrollableScrollPhysics(),
                      controller: _contentController,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        handleSubmit();
                      },
                      child: const Text("Create Blog"))
                ],
              ),
            ),
          )),
    );
  }

  Future<void> handleSubmit() async {
    final result = await postBlog(Blog(
        title: _titleController.text.toString(),
        content: _contentController.text.toString(),
        description: _descriptionController.text.toString()));

    if (result == true) {
      _titleController.text = "";
      _contentController.text = "";
      _descriptionController.text = "";
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return showAlert(context);
        },
      );
    }
  }

  AlertDialog showAlert(BuildContext context) {
    return AlertDialog(
      title: const Text(
          "Some error has accured and your blog couldnt be posted. Try again later."),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"))
      ],
    );
  }
}
