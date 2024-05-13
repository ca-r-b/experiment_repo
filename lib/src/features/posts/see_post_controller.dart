import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:testing_with_db/src/services/firestore_service.dart';

class SeePostController extends GetxController {
  // Call data fetcher
  final FirestoreService _firestoreService = FirestoreService();

  // Compare to old code
  RxBool isLoading = true.obs;
  RxString uid = ''.obs;

  // Make 'post' reactive, so changes could be observed when document has updates
  Rx<DocumentSnapshot?> post = Rx<DocumentSnapshot?>(null);

  @override
  void onInit() {
    super.onInit();

    // What is "ever"?
    // - In the code's context, think of it as a reactive listener which listens to changes in the 'uid' [TAMA BA PAGKAKAINTINDI KO?]
    ever(uid, (_) {
      // Fetch specific post clicked IF there is update in UID being passed as parameter in URL ('/see_post/:uid')
      fetchPost();
    });
  }

  void fetchPost() {
    isLoading.value = true;

    try {
      // Listen to stream coming from FIRESTORE CLASS (_firestoreService)
      // - Updates will be shown in the UI
      //   -> Temporarily test it via Firebase Console
      _firestoreService.getOnePostStream(uid.value).listen((postSnapshot) {
        // Check if code has entered function
        debugPrint("Am here VIEW NO");

        if (postSnapshot != null) {
          // Check if code has entered function
          debugPrint("Am here VIEW YES");

          // Change the value of snapshot -- 'post'
          post.value = postSnapshot;

          // Change the value of 'isLoading' to false -- review the Obx condition in 'see_post_view.dart' file
          isLoading.value = false;
        } else {
          isLoading.value = true;
        }
      });
    } catch (e) {
      debugPrint("Error fetching the post title: $e");
    }
  }
}
