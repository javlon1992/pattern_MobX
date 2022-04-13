import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pattern_mobx/stores/home_store.dart';
import 'package:pattern_mobx/views/home_view.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeStore store = HomeStore();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    store.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MobX"),
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) => Stack(
          children: [
            ListView.builder(
              itemCount: store.posts.length,
              itemBuilder: (BuildContext context, int index) {
                return itemOfPosts(store, store.posts[index], context);
              },
            ),
            store.isLoading
                ? const Center(child: CircularProgressIndicator.adaptive())
                : Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          store.goToCreate(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
