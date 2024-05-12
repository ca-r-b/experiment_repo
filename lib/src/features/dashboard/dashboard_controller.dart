import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_with_db/src/common_models/post.dart';
import 'package:testing_with_db/src/services/firestore_service.dart';

class DashboardController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();

  // var posts = <Post>[].obs;
  var posts = <DocumentSnapshot>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() {
    _firestoreService.getPostsStream().listen((postList) {
      debugPrint("Am here");

      posts.assignAll(postList);
    });
  }
}
