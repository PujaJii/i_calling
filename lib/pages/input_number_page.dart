import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_calling/pages/varify_otp.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


class InputNumber extends StatelessWidget {
  const InputNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return
      Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SizedBox(height: 10,),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    //const Text('i - Calling',style: TextStyle(color: Colors.green,fontSize: 20)),
                  ],
                ),const SizedBox(height: 40,),
                const Text('Enter Your Phone Number',style: TextStyle(color: Colors.black,fontSize: 16)),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 10),
                  child:
                  IntlPhoneField(
                    decoration: const InputDecoration(
                     // labelText: 'Phone Number',
                      prefixIcon: SizedBox(),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                     // print(phone.completeNumber);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  Get.to(()=> const VerifyOTP());
                }
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
      ),
    );

  }
}
