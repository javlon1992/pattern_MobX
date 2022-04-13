import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pattern_mobx/model/post_model.dart';
import 'package:pattern_mobx/service/http_service.dart';
part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  @observable
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  void saveAndExit(BuildContext context) async {
    isLoading = true;
    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();
    Post postCreate = Post(title: title, body: body, userId: title.hashCode);
    await Network.POST(Network.API_CREATE, Network.paramsCreate(postCreate));
    Navigator.pop((context), postCreate);
    isLoading = false;
  }
}
