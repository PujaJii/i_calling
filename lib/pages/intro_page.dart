import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_calling/pages/input_number_page.dart';
import 'package:permission_handler/permission_handler.dart';

import '../styles/app_colors.dart';



class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}
int _indicator = 0;
final PageController _pageController = PageController(initialPage: 0);
final List<String> _myList = [
  'Make calls more securely\nwith My Caller ID',
  'A trusted Platform\nfor making class',
  'Detect spam calls\neasily'
];
class _IntroPageState extends State<IntroPage> {


  Future<void> getContactPermission() async {
    if (await Permission.contacts.isGranted) {

    } else {
      await Permission.contacts.request();
    }
    if (await Permission.phone.isGranted) {

    } else {
      await Permission.phone.request();
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    getContactPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 60,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('i - Calling',style:  TextStyle(color: AppColors.themeColor,fontSize: 25,fontFamily: 'JacquesFrancois-Regular')),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 100,
                  child: Image.asset('assets/images/caller.gif'),
                ),
              ],
            ),
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int value) {
                  setState((){
                    _indicator = value;
                  });
                },
                itemCount: _myList.length,
                itemBuilder: (context, index) {
                return Center(
                  child: Text(_myList[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,)),
                );
              },),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                _myList.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () {
                              _pageController.animateToPage(index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: _indicator == index? AppColors.themeColor: Colors.grey,),
                          ),);
                      },
              ),
            ),
            const SizedBox(height: 20,),
             InkWell(
               onTap: () {
                   Get.to(()=>const InputNumber());
               },
               child: Container(
                  height: 50,

                  decoration: BoxDecoration(color: AppColors.themeColor,borderRadius: BorderRadius.circular(5)),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Center(child:  Text('Continue',style: TextStyle(color: Colors.white,fontSize: 18))),
                ),
             ),
            const SizedBox(height: 2,),
          ],
        ),
      ),
    );
  }
}
