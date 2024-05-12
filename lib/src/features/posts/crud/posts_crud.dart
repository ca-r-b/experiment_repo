import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_with_db/src/common_models/post.dart';

class PostsCRUD {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPost(Post post) async {
    await _firestore.collection('posts').add({
      'title': post.title,
      'content': post.content,
      'userId': post.userId,
    });
  }

  Future<void> updatePost(Post post) async {
    await _firestore.collection('posts').doc(post.id).update({
      'title': post.title,
      'content': post.content,
    });
  }

  Future<void> deletePost(String postId) async {
    await _firestore.collection('posts').doc(postId).delete();
  }
}
