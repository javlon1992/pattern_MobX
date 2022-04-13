import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pattern_mobx/stores/create_store.dart';

class CreatePage extends StatefulWidget {
  static const String id = "create_page";

  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  CreateStore store = CreateStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create post"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                store.saveAndExit(context);
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
                      controller: store.titleController,
                      maxLines: null,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10, top: 10),
                          hintText: "Title"),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: store.bodyController,
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
