import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_with_db/src/common_models/post.dart';

class PostsCRUD {
  // Get instance of DB
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function for adding into 'posts' collection
  Future<void> addPost(Post post) async {
    await _firestore.collection('posts').add({
      'title': post.title,
      'content': post.content,
      'userId': post.userId,
    });
  }

  // Function for updating a document in 'posts' collection
  Future<void> updatePost(Post post) async {
    await _firestore.collection('posts').doc(post.id).update({
      'title': post.title,
      'content': post.content,
    });
  }

  // Function for deleting a document from 'posts' collection
  Future<void> deletePost(String postId) async {
    await _firestore.collection('posts').doc(postId).delete();
  }
}
