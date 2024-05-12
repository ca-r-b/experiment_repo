import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_with_db/src/common_models/post.dart';
import 'package:testing_with_db/src/features/posts/crud/posts_crud.dart';
import 'package:testing_with_db/src/services/firestore_service.dart';

class CreatePostController extends GetxController {
  final PostsCRUD _postsCRUD = PostsCRUD();
  late Post post;

  /// RX Variables:
  RxString title = RxString('');
  RxString content = RxString('');

  /// RX Error Texts - NO CODE YET:
  RxnString titleErrorText = RxnString(null);
  RxnString contentErrorText = RxnString(null);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  // Submit Value for Submit Button
  Rxn<Function()> submitFunc = Rxn<Function()>(null);

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  Future<void> submitPost() async {
    // Instantiate model/object first with collected values from TEXTCONTROLLERS
    // - Can be coded without Model, but I think this is the cleaner way?
    //   [i.e. No need to pass values as parameters + No need to declare the function (Line 46) with ALL parameters needed]
    post = Post(
      id: "",
      title: title.value,
      content: content.value,
      userId: "Carlo",
    );

    // Call function "addPost(Post post)"
    await addPost(post);
  }

  Future<void> addPost(Post post) async {
    // Call the function for adding documents into the database
    await _postsCRUD.addPost(post);
  }

  // Try UPDATE - NO CODE YET

  // Try DELETE - NO CODE YET
}
