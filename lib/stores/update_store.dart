import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pattern_mobx/model/post_model.dart';
import 'package:pattern_mobx/service/http_service.dart';

part 'update_store.g.dart';

class UpdateStore = _UpdateStore with _$UpdateStore;

abstract class _UpdateStore with Store {
  @observable
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  void saveAndExit(Post post, BuildContext context) async {
    isLoading = true;
    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();
    Post postUpdate =
        Post(id: post.id, title: title, body: body, userId: post.userId);
    await Network.PUT(Network.API_UPDATE + postUpdate.id.toString(),
        Network.paramsUpdate(postUpdate));
    Navigator.pop((context), postUpdate);
    isLoading = false;
  }
}
