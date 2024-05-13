// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_with_db/src/common_models/post.dart';
import 'package:testing_with_db/src/features/posts/crud/posts_crud.dart';
// import 'package:testing_with_db/src/services/firestore_service.dart';

class CreatePostController extends GetxController {
  // Call functions for Creating, Updating & Deleting posts
  final PostsCRUD _postsCRUD = PostsCRUD();
  late Post post;

  // RX Variable for checking that file is being uploaded
  RxBool fileIsLoading = false.obs;

  /// RX Variables:
  RxString title = RxString('');
  RxString content = RxString('');
  RxString selectedFile = RxString('');
  Uint8List? fileInBytes;

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

  void selectFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      selectedFile.value = result.files.first.name;
      fileInBytes = result.files.first.bytes;
    }
  }

  Future<void> uploadFileAndSaveUrl(Uint8List fileData, String fileName) async {
    // Set the loading state to true
    fileIsLoading.value = true;

    // Create a reference to the location you want to upload to in Firebase Storage
    final storageReference =
        FirebaseStorage.instance.ref().child('files').child(fileName);

    /// Sets a metadata to the file of type PDF so that it can be viewed in the browser...
    /// ...instead na ma-download
    final metadata = SettableMetadata(
      contentType: 'application/pdf',
    );

    // Upload the file to Firebase Storage
    UploadTask uploadTask = storageReference.putData(fileData, metadata);

    // Wait for the upload to complete
    final snapshot = await uploadTask;

    // Get the download URL
    String fileUrl = await snapshot.ref.getDownloadURL();

    // Print the download URL for testing
    debugPrint(fileUrl);

    // Save the URL to Firestore
    await FirebaseFirestore.instance
        .collection('files')
        // .collection('posts')
        // .doc(uid of post here) --subcollection
        // .collection('files')
        .add({
      'fileName': fileName,
      'fileUrl': fileUrl,
    });

    // Set the loading state to false
    fileIsLoading.value = false;
  }

  Future<void> submitPost() async {
    // Instantiate model/object first with collected values from TEXTCONTROLLERS
    // - Can be coded without the use of Model, but I think this is the cleaner way?
    //   [i.e. By 'cleaner way', I MEAN:
    //                > No need to pass values as parameters (magulo tingnan) +
    //                > No need to declare the function (Line 49) with ALL parameters needed]
    post = Post(
      id: "",
      title: title.value,
      content: content.value,
      userId: "Carlo",
    );

    // Call function "addPost(Post post)"
    await _postsCRUD.addPost(post);
  }

  // Try UPDATE - NO CODE YET

  // Try DELETE - NO CODE YET
}
