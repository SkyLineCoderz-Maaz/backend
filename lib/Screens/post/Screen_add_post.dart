import 'dart:io';
import 'package:custom_utils/custom_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/post_controller.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  PostController postController=Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Post'),
        ),
        body: Obx((){
          return CustomProgressWidget(
            loading: postController.postLoading.value,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                      onPressed: () async {
                        final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
                        if (pickedImage != null) {
                          postController.pickedImage.value = File(pickedImage.path);
                        }
                      },
                      child: Text('Pick Image'),
                    ),
                    SizedBox(height: 16.0),
                    postController.pickedImage.value!= null
                        ? Container(
                        height: 200,
                        width: 200,
                        child: Image.file(postController.pickedImage.value))
                        : Text('No image selected'),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: postController.descriptionController.value,
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () async{
                        var postResponse= await postController.uploadPost("Image");
                        if(postResponse=="success"){
                          Get.back();
                        }
                        else{
                          Get.snackbar("Eror", postResponse.toString());
                        }
                      },
                      child: Text('Upload'),
                    ),
                  ],
                )
            ),
          );
        })
    );
  }
}
