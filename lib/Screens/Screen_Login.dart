import 'package:backend/Screens/Screen_Home.dart';
import 'package:backend/Screens/Screen_Sign_Up.dart';
import 'package:backend/controller/registration_controllere.dart';
import 'package:custom_utils/custom_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'Screen_Forget.dart';
import 'Screen_Login_with_phone.dart';

class LoginScreen extends StatelessWidget {
  RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Obx(() {
        return CustomProgressWidget(
          loading: controller.loginLoading.value,
          text: "Logging In",
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomInputField(
                  controller: controller.emailController.value,
                  hint: 'Email',
                ),
                CustomInputField(
                  controller: controller.passwordController.value,
                  hint: 'Password',
                  isPasswordField: true,
                ),
                TextButton(
                  onPressed: () {
                    Get.to(ForgetScreen());
                  },
                  child: Text('Forget Password'),
                ),
                CustomButton(
                    height: 43.sp,
                    width: Get.width,
                    text: 'Login',
                    onPressed: () async {
                      String response = await controller.LogIn();
                      if (response == 'Success') {
                        Get.snackbar('Success', response.toString());
                        Get.offAll(HomePageScreen());
                      } else {
                        Get.snackbar('Error', response.toString());
                      }
                    }),
                TextButton(
                    onPressed: (){
                      Get.to(LoginWithPhoneNumber());
                    },
                    child: Text("Login With Phone")),
                Padding(
                  padding: EdgeInsets.all(60.sp),
                  child: Row(
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) {
                              return SignUPScreen();
                            }));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 12.sp, color: Colors.blue),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
      ),
    );
  }
}
