import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_calling/pages/bottom_nav_page.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';



class VerifyOTP extends StatelessWidget {
  const VerifyOTP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return   Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const SizedBox(height: 10,),
          Column(
            children: [
              const Text('Verify OTP',style: TextStyle(color: Colors.black,fontSize: 20)),const SizedBox(height: 40,),
              const Text('Enter Your Phone Number',style: TextStyle(color: Colors.black,fontSize: 16)),
              const SizedBox(height: 20,),
              OTPTextField(
                length: 4,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 50,
                style: const TextStyle(
                    fontSize: 17
                ),
                textFieldAlignment: MainAxisAlignment.center,
                margin:  EdgeInsets.all(8),
                otpFieldStyle: OtpFieldStyle(),
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) {
                  print("Completed: " + pin);

                },
              ),
            ],
          ),
          const SizedBox(height: 20,),
          InkWell(
            onTap: () {
              // if (_formKey.currentState!.validate()) {
                 Get.to(()=> const BottomNavPage());
              // }
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(5)),
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
              child: const Center(child:  Text('Confirm',style: TextStyle(color: Colors.white,fontSize: 18))),
            ),
          ),
        ],
      ),
    );
  }
}
