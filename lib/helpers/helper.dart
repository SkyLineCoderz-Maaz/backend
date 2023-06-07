import 'package:cloud_firestore/cloud_firestore.dart';


var usersRef=FirebaseFirestore.instance.collection('users');
var postsRef=FirebaseFirestore.instance.collection('posts');