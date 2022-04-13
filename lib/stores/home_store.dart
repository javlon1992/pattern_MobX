import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pattern_mobx/model/post_model.dart';
import 'package:pattern_mobx/pages/create_page.dart';
import 'package:pattern_mobx/pages/update_page.dart';
import 'package:pattern_mobx/service/http_service.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  bool isLoading = false;
  @observable
  List<Post> posts = [];

  void apiPostList() {
    isLoading = true;
    Network.GET(Network.API_LIST, Network.paramsEmpty()).then((response) => {
          _showResponse(response!),
        });
  }

  void apiPostDelete(Post post) async {
    var result = await Network.DELETE(
        Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    if (result != null) {
      apiPostList();
    }
  }

  void _showResponse(String response) {
    var json = jsonDecode(response);
    posts = List<Post>.from(json.map((x) => Post.fromJson(x)));
    isLoading = false;
  }

  void goToCreate(BuildContext context) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreatePage()));
    if (result != null) {
      posts.add(result as Post);
      apiPostList();
    }
  }

  void goToEdit(Post post, BuildContext context) async {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
        UpdatePage(post: post,)));
    if (result != null) {
      posts.replaceRange(posts.indexOf(post), posts.indexOf(post) + 1, [result]);
      apiPostList();
    }
  }
}
