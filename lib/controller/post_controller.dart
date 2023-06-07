import 'dart:io';
import 'package:backend/helpers/firebase_utils.dart';
import 'package:backend/helpers/helper.dart';
import 'package:backend/model/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  Rx<TextEditingController> descriptionController = TextEditingController().obs;
  Rx<File> pickedImage = File("").obs;
  RxBool postLoading = false.obs;

  Future<String> uploadPost(String mediaType) async {
    String response = '';
    String description = descriptionController.value.text.trim();
    String id = FirebaseUtils.newId.toString();
    postLoading.value = true;
    String url = await FirebaseUtils.uploadImage(
      pickedImage.value.path.toString(),
      'post/$id/image',
    );
    Post post = Post(
        id: id,
        media_url: url,
        media_type: mediaType,
        description: description,
        user_id: FirebaseUtils.myId,
        time_Stamp: FirebaseUtils.newId,
    );
    await postsRef.doc(post.id).set(post.toMap()).then((value) {
response='success';
postLoading.value=false;

    }).catchError((error){
response=error.toString();
postLoading.value=false;
    });
return response;
  }
}
