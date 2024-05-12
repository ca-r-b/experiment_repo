import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_with_db/src/common_models/post.dart';

class PostTile extends StatelessWidget {
  // final Post post;
  final DocumentSnapshot post;

  const PostTile({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                  255, 156, 211, 255), // Set your desired background color here
              borderRadius: BorderRadius.circular(
                  8), // Optionally, you can add border radius to the container
            ),
            child: ListTile(
              title: Text(post['title']),
              subtitle: Text(post['content']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_red_eye_rounded),
                    onPressed: () {
                      Get.toNamed('/see/${post.id}');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
