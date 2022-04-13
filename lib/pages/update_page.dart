import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pattern_mobx/model/post_model.dart';
import 'package:pattern_mobx/stores/update_store.dart';

class UpdatePage extends StatefulWidget {
  static const String id = "update_page";

  final Post post;

  const UpdatePage({Key? key, required this.post}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  UpdateStore store = UpdateStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update post"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                store.saveAndExit(widget.post, context);
              },
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ))
        ],
      ),
      body: Observer(
        builder: (_) => Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: store.titleController..text = widget.post.title!,
                      maxLines: null,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10, top: 10),
                          hintText: "Title"),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: store.bodyController..text = widget.post.body!,
                      maxLines: null,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: "Body",
                          border: OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  ],
                ),
              ),
            ),
            store.isLoading
                ? const Center(child: CircularProgressIndicator.adaptive())
                : Container(),
          ],
        ),
      ),
    );
  }
}
