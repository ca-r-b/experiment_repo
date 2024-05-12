import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_with_db/src/features/posts/create_post_controller.dart';

class CreatePostView extends StatelessWidget {
  // Similar to our old code
  final CreatePostController createPostController = Get.find();

  // Add to our main code? Remove warnings.
  CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reddit Clone'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                // NO CODE YET FOR ERROR CHECKING
                // -----------------------------------------
                // IMPORTANT NOTE: Look for efficient way
                Obx(
                  () {
                    return TextFormField(
                      controller: createPostController.titleController,
                      onChanged: (value) {
                        createPostController.title.value = value;
                        createPostController.submitFunc.value =
                            createPostController.submitPost;
                      },
                      decoration: InputDecoration(
                          labelText: 'Title',
                          errorText:
                              // NO CODE YET FOR VALIDATIONS
                              createPostController.titleErrorText.value),
                    );
                  },
                ),
                Obx(
                  () {
                    return TextFormField(
                      controller: createPostController.contentController,
                      onChanged: (value) =>
                          createPostController.content.value = value,
                      decoration: InputDecoration(
                          labelText: 'Content',
                          errorText:
                              // NO CODE YET FOR VALIDATIONS
                              createPostController.contentErrorText.value // obs
                          ),
                    );
                  },
                ),
                Obx(
                  () => OutlinedButton(
                    // The function of onPressed will have the value of 'submitFunc'
                    onPressed: createPostController.submitFunc.value,
                    child: const Text("Submit Post"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
