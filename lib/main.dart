import 'package:backend/Screens/Screen_Home.dart';
import 'package:custom_utils/custom_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screens/Screen_Login.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return  GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Backend',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FirebaseAuth.instance.currentUser!=null?HomePageScreen():LoginScreen(),
        );
      },
    );
  }
}
