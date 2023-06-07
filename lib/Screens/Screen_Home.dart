import 'package:backend/Screens/Screen_Login.dart';
import 'package:backend/Screens/Screen_Multi_Users.dart';
import 'package:backend/Screens/post/Screen_Uploaded.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../helpers/helper.dart';
import 'package:backend/model/user.dart' as model;
class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Logout?"),
                    content: Text("Are you sure to logout?"),
                    actions: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Dismiss")),
                      OutlinedButton(
                          onPressed: () async {
                            FirebaseAuth.instance.signOut().then((value) {
                              Get.offAll(LoginScreen());
                            });
                          },
                          child: Text("Logout")),
                    ],
                  );
                },
              );
            },
            child: Text(
              "Logout",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
      body: Column(children: [
        FutureBuilder<DocumentSnapshot>(
          future: usersRef.doc(uid).get(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState==ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            model.User user=model.User.fromMap(snapshot.data!.data() as Map<String ,dynamic>);
            return (user.isNull)?Text("No User"):ListTile(
              title: Text("${user.firstName} ${user.lastName}"),
              subtitle: Text(user.gender),
              trailing: Text(user.dob),
            );

          },),
        TextButton(onPressed: (){
          Get.to(MultiUserScreen());
        }, child: Text("MultiUser")),
        TextButton(onPressed: (){
          Get.to(UploadedScreen());
        }, child: Text("Upload Post")),
      ],),
      // body: Container(
      //   width: Get.width,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       StreamBuilder<DocumentSnapshot>(
      //         stream: usersRef.doc(uid).snapshots(),
      //         builder: (context, snapshot) {
      //           if (snapshot.connectionState == ConnectionState.waiting) {
      //             return Center(
      //               child: CircularProgressIndicator(),
      //             );
      //           }
      //
      //           var docSnapshot = snapshot.data;
      //
      //           if (docSnapshot == null || docSnapshot.data() == null) {
      //             return Container(
      //               child: Text("User data doesn't exist"),
      //             );
      //           } else {
      //             var userMap = docSnapshot.data() as Map<String, dynamic>;
      //             var userObj = userModel.User.fromMap(userMap);
      //
      //             name = userObj.name;
      //
      //             return Container(
      //               child: Text(userObj.name),
      //             );
      //           }
      //         },
      //       ),
      //       ElevatedButton(
      //           onPressed: () {
      //             var renameController = TextEditingController();
      //             Get.defaultDialog(
      //                 title: "Rename",
      //                 content: TextField(
      //                   controller: renameController..text = name,
      //                 ),
      //                 actions: [
      //                   OutlinedButton(
      //                       onPressed: () {
      //                         Get.back();
      //                       },
      //                       child: Text("Cancel")),
      //                   OutlinedButton(
      //                       onPressed: () {
      //                         Get.back();
      //                         usersRef
      //                             .doc(uid)
      //                             .update({"name": renameController.text});
      //                       },
      //                       child: Text("Update"))
      //                 ]);
      //           },
      //           child: Text("Rename")),
      //       ElevatedButton(
      //           onPressed: () {
      //             Get.defaultDialog(
      //                 title: "Delete",
      //                 content: Text("Are you sure to delete the data?"),
      //                 actions: [
      //                   OutlinedButton(
      //                       onPressed: () {
      //                         Get.back();
      //                       },
      //                       child: Text("Cancel")),
      //                   OutlinedButton(
      //                       onPressed: () {
      //                         Get.back();
      //                         usersRef.doc(uid).delete();
      //                       },
      //                       child: Text("Delete"))
      //                 ]);
      //           },
      //           child: Text("Delete")),
      //     ],
      //   ),
      // ),
    );
  }
}
