import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// What are "STREAMS"?
  /// - In this context, it listens to changes in the 'posts' collection in Firestore.
  /// - Whenever there's a new post or an update to an existing post, it delivers that information to our app

  // Return a stream of lists of DocumentSnapshot objects
  Stream<List<DocumentSnapshot>> getPostsStream() {
    // Access Firestore instance (the database) and get reference to the collection named 'posts'
    return _firestore
        .collection('posts')
        // // OPTIONAL -> Sort/Order
        // // .orderBy('title', descending: false)
        // Listen to changes in the 'posts' collection and get a stream of snapshots.
        .snapshots()
        // Map each snapshot in the stream to a list of DocumentSnapshot objects.
        // The map function transforms each snapshot to a list of documents.
        .map((querySnapshot) {
      // Convert the list of DocumentSnapshot objects in the querySnapshot to a regular Dart list.
      return querySnapshot.docs.toList();
    });
  }

  // Return a stream of DocumentSnapshot object/s.
  // The snapshot can be nullable since it may not exist.
  Stream<DocumentSnapshot?> getOnePostStream(String postId) {
    return _firestore
        .collection('posts')
        .doc(postId)
        // Listen to changes in the document and get stream of snapshots.
        .snapshots()
        // Map each snapshot in the stream to DocumentSnapshot object.
        .map((snapshot) {
      if (snapshot.exists) {
        // If the document exists, return the snapshot.
        return snapshot;
      } else {
        // If the document doesn't exist, throw an exception with a message.
        throw Exception('Document with ID $postId does not exist.');
      }
    }).handleError((error) {
      // Handle errors here
      debugPrint('Error fetching document: $error');
      return null; // Return null to the stream in case of an error
    });
  }

  // =================================
  // IGNORE THIS
  // =================================
  // - When using MODELS...

  // ========== [ALL POSTS] ==========
  // .map((snapshot) => snapshot.docs
  //     .map((doc) => Post(
  //           id: doc.id,
  //           title: doc['title'],
  //           content: doc['content'],
  //           userId: doc['userId'],
  //         ))
  //     .toList());

  // ========== [SPECIFIC POSTS] ==========
  //Stream<Post?> getPostStream(String postId) {
  //   return _firestore
  //       .collection('posts')
  //       .doc(postId)
  //       .snapshots()
  //       .map((snapshot) {
  //     if (snapshot.exists) {
  //       return Post(
  //         id: snapshot.id,
  //         title: snapshot['title'],
  //         content: snapshot['content'],
  //         userId: snapshot['userId'],
  //       );
  //     } else {
  //       return null; // Return null if the document doesn't exist
  //     }
  //   });
  // }
}
