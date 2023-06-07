import 'package:backend/controller/registration_controllere.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_utils/custom_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/post.dart';

class UploadedScreen extends StatelessWidget {
  final RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('post'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var posts = snapshot.data!.docs
              .map((e) => Post.fromMap(e.data() as Map<String, dynamic>))
              .toList();
          return CustomListviewBuilder(
              itemCount: posts.length,
              scrollDirection: CustomDirection.vertical,
            itemBuilder: (BuildContext context,int index) {
                var post=posts[index];
                return ListTile(
                  leading: Container(
                    height: 5.h,
                    width: 5.w,
                    child: Image.network(post.media_url),
                  ),
                  title: Text(post.media_type),
                  subtitle: Text(post.description),
                );
            },
          );
        },
      ),
    );
  }
}
