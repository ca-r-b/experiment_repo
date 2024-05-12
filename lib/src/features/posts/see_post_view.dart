import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_with_db/src/features/posts/see_post_controller.dart';

class SeePostView extends StatelessWidget {
  final SeePostController seePostController = Get.find();

  SeePostView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //
      seePostController.uid.value = Get.parameters['uid']!;
      seePostController.fetchPost();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reddit Clone'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Obx(() {
                  if (seePostController.isLoading.value) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "TITLE: ${seePostController.post.value!['title']}"),
                        Text(
                            "CONTENT: ${seePostController.post.value!['content']}"),
                        Text(
                            "USERID: ${seePostController.post.value!['userId']}"),
                      ],
                    );
                  }
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
