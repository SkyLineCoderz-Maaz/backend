import 'package:backend/helpers/helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:backend/model/user.dart' as model;
import 'package:image_picker/image_picker.dart';
import '../Screens/Screen_Login_with_phone.dart';

class RegistrationController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  Rx<PlatformFile?> pickedFile = Rx<PlatformFile?>(null);
  Rx<UploadTask?> uploadTask = Rx<UploadTask?>(null);
  RxBool codeSent = false.obs;
  RxString verificationId = ''.obs;
  RxString verificationCode = ''.obs;
  RxBool loginLoading = false.obs;
  RxBool signUpLoading = false.obs;
  RxBool phoneLoading = false.obs;

  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> genderController = TextEditingController().obs;
  Rx<TextEditingController> dobController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> verifyController = TextEditingController().obs;

  Future<String> LogIn() async {
    String response = "";
    String email = emailController.value.text.trim();
    String password = passwordController.value.text.trim();

    if (email.isEmpty || password.isEmpty) {
      response = "Email and Password Requires";
    }
    loginLoading.value = true;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      response = "success";

      loginLoading.value = false;
    }).catchError((error) {
      loginLoading.value = false;
      response = error.toString();
    });

    return response;
  }

  Future<String> SignUp() async {
    String response = "";
    String email = emailController.value.text.trim();
    String firstName = firstNameController.value.text.trim();
    String lastName = lastNameController.value.text.trim();
    String gender = genderController.value.text.trim();
    String dob = dobController.value.text.trim();
    String confirmPassword = confirmPasswordController.value.text.trim();
    String password = passwordController.value.text.trim();
    if (email.isEmpty || password.isEmpty) {
      response = "Email and Password Requires";
    }
    signUpLoading.value = true;
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      String uid = value.user!.uid;

      model.User user = model.User(
        id: uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        gender: gender,
        dob: dob,
        notification_token: "",
        timeStamp: DateTime.now().millisecondsSinceEpoch,
      );

      await usersRef.doc(uid).set(user.toMap()).then((value) {
        signUpLoading.value = false;
        response="success";

      });
    }).catchError((error) {
      response = error.toString();

      signUpLoading.value = false;
    });

    return response;
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    try {
      phoneLoading.value = true;
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
          phoneLoading.value = false;
        },
        verificationFailed: (FirebaseAuthException e) {
          phoneLoading.value = false;
          // Handle verification failure
        },
        codeSent: (String verificationId, int? resendToken) {
          codeSent.value = true;
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      phoneLoading.value = false;
      // Handle any other exceptions
    }
  }

  Future<void> verifyCode() async {
    try {
      phoneLoading.value = true;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: verificationCode.value,
      );
      await auth.signInWithCredential(credential);
      phoneLoading.value = false;
      // Code verification successful, proceed to the next screen
      Get.to(LoginWithPhoneNumber());
    } catch (e) {
      phoneLoading.value = false;
      // Handle verification failure
    }
  }

  Future selectFile()async{
    final result=await FilePicker.platform.pickFiles();
    if(result==null) return;
    pickedFile=result.files.first.obs;
  }
}



