import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_calling/pages/settings_page.dart';
import 'package:i_calling/styles/app_colors.dart';



class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: const[
            Text('Santanu Sharma',style:  TextStyle(color: Colors.black)),
            //Container(child: Text(subTitle,style: const TextStyle(color: Colors.grey))),
          ],
        ),


        actions:  [
          InkWell(
              onTap: () {
                Get.to(()=> const SettingsPage());
              },
              child: const Icon(Icons.settings,color: Colors.blueGrey)),
          const SizedBox(width: 20,)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children:[
             const SizedBox(height: 20,width: double.infinity,),
             Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.black,
                  image: const DecorationImage(image: AssetImage('assets/images/my_profile.jpg')),
                  borderRadius: BorderRadius.circular(15)),
              ),
            const SizedBox(height: 15,),
            const Text('+91 85422 65782',style: TextStyle(fontSize: 16)),
            const SizedBox(height: 15,),
            InkWell(
              onTap: () {
                // if (_formKey.currentState!.validate()) {
                //Get.to(()=> const InputDetails());
                // }
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(color: AppColors.themeColor,borderRadius: BorderRadius.circular(5)),
                margin: const EdgeInsets.symmetric(horizontal: 90,vertical: 0),
                child: const Center(
                    child:  Text('Complete your profile',
                        style: TextStyle(color: Colors.white,fontSize: 12))),
              ),
            ),
            const SizedBox(height: 15,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!),
                  borderRadius: const  BorderRadius.all(Radius.circular(8))),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.verified_user_outlined,color: Colors.redAccent,),
                              Text('15'),
                            ],
                          ),
                          const Text('Total Spam Calls')
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: const[
                              Icon(Icons.verified_user_outlined,color: Colors.redAccent,),
                              Text('15'),
                            ],
                          ),
                          const Text('Total Spam Calls')
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.verified_user_outlined,color: Colors.redAccent,),
                              Text('15'),
                            ],
                          ),
                          const Text('Total Spam Calls')
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.verified_user_outlined,color: Colors.redAccent,),
                              Text('15'),
                            ],
                          ),
                          const Text('Total Spam Calls')
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!),
                  borderRadius: const  BorderRadius.all(Radius.circular(8))),
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.fromLTRB(20,20,0,20),
              child: Column(
                children: [
                  Row(
                    children:  const [
                      Icon(Icons.location_on_outlined,color: AppColors.themeColor),
                      Text('      West Bengal, India')
                    ],
                  ),
                  Divider(color: Colors.grey[300],),
                  Row(
                    children: const [
                      Icon(Icons.notifications_none_outlined,color: AppColors.themeColor),
                      Text('     Notification')
                    ],
                  ),
                  Divider(color: Colors.grey[300],),
                  Row(
                    children: const [
                      Icon(Icons.verified_user_outlined,color: AppColors.themeColor),
                      Text('     Protect')
                    ],
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!),
                  borderRadius: const  BorderRadius.all(Radius.circular(8))),
              margin: const EdgeInsets.symmetric(horizontal: 20,),
              padding: const EdgeInsets.fromLTRB(20,20,0,20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Invite friends'),
                  Divider(color: Colors.grey[300],),
                  const Text('News'),
                  Divider(color: Colors.grey[300],),
                  const Text('Send Feedback'),
                  Divider(color: Colors.grey[300],),
                  const Text('FAQ')
                ],
              ),
            ),
            const SizedBox(height: 80,),
          ],
        ),
      ),
    );
  }
}
