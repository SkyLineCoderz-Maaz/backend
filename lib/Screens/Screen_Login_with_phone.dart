import 'package:custom_utils/custom_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/registration_controllere.dart';
import 'Screen_verification_done.dart';

class LoginWithPhoneNumber extends StatefulWidget {

  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  late final String verificationId;
  RegistrationController controller=Get.put(RegistrationController());
  bool isChecked=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 55.sp, left: 20.sp),
            child: Row(
              children: [
                GestureDetector(
                  onTap:(){
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Color(0xff2E3A59),
                    size: 13.sp,
                  ),
                ),
                SizedBox(
                  width: 6.w,
                ),
                Text(
                  "Signup",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.sp,
                    fontFamily: 'Segoe UI',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100.sp, left: 20.sp),
            child: Text(
              "Phone Verification",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.sp,
                fontFamily: 'Segoe UI',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.sp, top: 150.sp),
            child: Text(
              "Add your phone number we will send you a\nverification codes we know you’re real.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontFamily: 'Segoe UI',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 230.sp, left: 35.sp),
            child: CustomInputField(
              controller: controller.phoneController.value,
              label: 'Phone Number',
              hint: '+92302324456',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 300.sp,left: 50.sp),
            child: Row(children: [
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  isChecked = value!;
                },
              ),
              RichText(
                text: TextSpan(
                    text: "Agree with",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Open Sans",
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: " Terms and Conditions",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Open Sans",
                          )
                      )
                    ]
                ),
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 400.sp, left: 70.sp),
            child: CustomButton(
              height: 6.h,
              width: 50.w,
              text: 'Send OTP',
              onPressed: () {
                Get.offAll(VerificationScreenDone(verificationId: verificationId,));
              },
            ),
          ),
        ],
      ),
    );
  }
}

