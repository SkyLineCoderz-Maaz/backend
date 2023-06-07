import 'package:backend/helpers/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_utils/custom_utils.dart';
import 'package:flutter/material.dart';
import 'package:backend/model/user.dart' as model;
import 'package:get/get.dart';

class MultiUserScreen extends StatefulWidget {
  const MultiUserScreen({Key? key}) : super(key: key);

  @override
  State<MultiUserScreen> createState() => _MultiUserScreenState();
}

class _MultiUserScreenState extends State<MultiUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multiuser"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          var users = snapshot.data.docs
              .map((e) => model.User.fromMap(e.data() as Map<String, dynamic>))
              .toList();
          return users.isEmpty
              ? Text("No Users")
              : CustomListviewBuilder(
                  itemCount: users.length,
                  scrollDirection: CustomDirection.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    var user = users[index];
                    return ListTile(
                      title: Text(user.firstName),
                      trailing: Text(user.dob),
                    );
                  },
                );
        },
      ),
    );
  }
}
