import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  late String id;
  late String title;
  late String content;
  late String userId;

  Post(
      {required this.id,
      required this.title,
      required this.content,
      required this.userId});

  Post.fromDocumentSnapshot(DocumentSnapshot docSnap) {
    id = docSnap.id;
    title = docSnap['title'];
    content = docSnap['content'];
    userId = docSnap['userId'];
  }
}
