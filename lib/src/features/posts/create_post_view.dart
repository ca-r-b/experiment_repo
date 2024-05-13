import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
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
                const SizedBox(height: 50),
                // Add a outlined button to pick a file and display the file name
                OutlinedButton(
                  onPressed: createPostController.selectFile,
                  child: const Text('Pick a file'),
                ),
                Obx(() {
                  return Column(
                    children: [
                      // Display the file name
                      Text(createPostController.selectedFile.value == ''
                          ? 'example.pdf'
                          : createPostController.selectedFile.value),
                      Text(createPostController.fileInBytes != null
                          ? 'File selected'
                          : 'No file selected')
                    ],
                  );
                }),
                Obx(() {
                  // Add a outlined button to upload the file
                  return OutlinedButton(
                    onPressed: () {
                      if (createPostController.fileInBytes != null) {
                        createPostController.uploadFileAndSaveUrl(
                            createPostController.fileInBytes!,
                            createPostController.selectedFile.value);
                      }
                    },
                    child: createPostController.fileIsLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator())
                        : const Text('Upload File'),
                  );
                }),
                // Display the PDF in a bottom sheet
                ElevatedButton(
                  onPressed: () {
                    showPDFInBottomSheet(context,
                        "https://firebasestorage.googleapis.com/v0/b/flutterfirebase-6c279.appspot.com/o/GIS.pdf?alt=media&token=51654170-c140-4ffa-ae1a-9fb431d0dee2");
                  },
                  child: const Text('Show Sample pdf in Bottom Sheet'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showPDFInBottomSheet(BuildContext context, String url) {
    showModalBottomSheet(
      context: context,
      // for full screen
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('PDF Viewer'),
            ),
            body: SfPdfViewer.network(
              url,
            ),
          ),
        );
      },
    );
  }
}
