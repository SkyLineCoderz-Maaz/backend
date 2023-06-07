import 'package:backend/Screens/Screen_Home.dart';
import 'package:backend/controller/registration_controllere.dart';
import 'package:custom_utils/custom_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'Screen_Login.dart';

class SignUPScreen extends StatefulWidget {
  const SignUPScreen({Key? key}) : super(key: key);

  @override
  State<SignUPScreen> createState() => _SignUPScreenState();
}

class _SignUPScreenState extends State<SignUPScreen> {
  RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
        ),
        body: Obx(() {
          return CustomProgressWidget(
            loading: controller.signUpLoading.value,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomInputField(
                    controller: controller.firstNameController.value,
                    label: 'First Name',
                    showBorder: true,
                  ),
                  CustomInputField(
                    controller: controller.lastNameController.value,
                    label: 'Last Name',
                    showBorder: true,
                  ),
                  CustomInputField(
                    controller: controller.genderController.value,
                    label: 'Gender',
                    showBorder: true,
                  ),
                  CustomInputField(
                    controller: controller.dobController.value,
                    label: 'Date Of Birth',
                    showBorder: true,
                  ),
                  CustomInputField(
                    controller: controller.emailController.value,
                    label: 'Email',
                    showBorder: true,
                  ),
                  CustomInputField(
                    controller: controller.passwordController.value,
                    label: 'Password',
                    showBorder: true,
                    isPasswordField: true,
                  ),
                  CustomInputField(
                    controller: controller.confirmPasswordController.value,
                    label: 'Confirm Password',
                    showBorder: true,
                    isPasswordField: true,
                  ),
                  CustomButton(text: "Sign Up", onPressed: () async{
                    String response=await controller.SignUp();
                    if (response=="success") {
                      Get.offAll(HomePageScreen());
                    }
                    else{
                      Get.snackbar("Error", response.toString());
                    }

                  }),
                  Padding(
                    padding:  EdgeInsets.all(40.sp),
                    child: Row(
                      children: [
                        Text(
                          "You Already have an account? ",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return LoginScreen();
                              }));
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 12.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
