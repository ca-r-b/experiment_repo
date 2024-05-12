import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_with_db/src/common_models/post.dart';
import 'package:testing_with_db/src/services/firestore_service.dart';

class SeePostController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();

  // var posts = <Post>[].obs;
  RxBool isLoading = true.obs;
  RxString uid = ''.obs;
  Rx<DocumentSnapshot?> post = Rx<DocumentSnapshot?>(null);

  @override
  void onInit() {
    super.onInit();

    ever(uid, (_) {
      fetchPost();
    });
  }

  void fetchPost() {
    isLoading.value = true;

    try {
      _firestoreService.getOnePostStream(uid.value).listen((postSnapshot) {
        debugPrint("Am here VIEW NO");

        if (postSnapshot != null) {
          debugPrint("Am here VIEW YES");

          post.value = postSnapshot;
          isLoading.value = false;
        } else {
          isLoading.value = true;
        }
      });
    } catch (e) {
      debugPrint("Error fetching the post title: $e");
    }
  }

  // void addPost(Post post) async {
  //   await _firestoreService.addPost(post);
  // }

  // void updatePost(Post post) async {
  //   await _firestoreService.updatePost(post);
  // }

  // void deletePost(String postId) async {
  //   await _firestoreService.deletePost(postId);
  // }
}
