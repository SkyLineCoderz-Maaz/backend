import 'package:backend/controller/registration_controllere.dart';
import 'package:custom_utils/custom_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';

class VerificationScreenDone extends StatefulWidget {
  final String verificationId;
  const VerificationScreenDone({Key? key ,required this.verificationId}) : super(key: key);

  @override
  State<VerificationScreenDone> createState() => _VerificationScreenDoneState();
}

class _VerificationScreenDoneState extends State<VerificationScreenDone> {
  RegistrationController controller=Get.put(RegistrationController());
  var code = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30.sp),
            child: Center(
                child: Image.asset(
                    "asset/image/veri.png")),
          ),
          Padding(
            padding:EdgeInsets.only(right: 120.sp),
            child: Text("Verification",style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontFamily: 'Segoe UI',
              fontWeight: FontWeight.w600,
            ),),
          ),
          SizedBox(height: 1.h,),
          Text("Enter the OTP code sent to your phone",style: TextStyle(
            color: Colors.black,
            fontSize: 15.sp,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w400,
          ),),
          SizedBox(height: 5.h,),
          Pinput(
            onChanged: (value){
              code = value;
            },
            length: 6,
            controller: controller.verifyController.value,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 5.h,),
          Center(child: Text("Did not receive a code?",style: TextStyle(
            color: Color(0xff939393),
            fontSize: 18.sp,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w600,
          ),),),
          SizedBox(height: 3.h,),
          Center(child: Text("Resend",style: TextStyle(
            letterSpacing: 1,
            color: Colors.black,
            fontSize: 18.sp,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w700,
          ),),),
          SizedBox(height: 3.h,),
          CustomButton(
              height: 6.h,
              width: 60.w,
              text: 'Done',
              onPressed: (){}
          ),
          SizedBox(height: 5.h,),
          Center(child: Text("Change phone number?",style: TextStyle(
            color: Colors.blue,
            fontSize: 15.sp,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w400,
          ),)),
        ],
      ),
    );;
  }
}
