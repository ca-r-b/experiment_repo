import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:testing_with_db/src/common_models/post.dart';
import 'package:testing_with_db/src/services/firestore_service.dart';

class DashboardController extends GetxController {
  // Call firebase service for fetching data
  final FirestoreService _firestoreService = FirestoreService();

  var posts = <DocumentSnapshot>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() {
    // Listen to posts
    _firestoreService.getPostsStream().listen((postList) {
      // Checks if code has entered function
      debugPrint("Am here");

      // Replace content of list ('posts') with updated content (postList) from stream
      // ChatGPT explanation: This code replaces all elements in the observable list 'posts' with the elements of the new 'postList'
      posts.assignAll(postList);
    });
  }
}
