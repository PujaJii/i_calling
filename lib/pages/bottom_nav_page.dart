import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:i_calling/pages/profile.dart';
import 'package:telephony/telephony.dart';

import '../styles/app_colors.dart';
import 'call_history.dart';
import 'contact_page.dart';
import 'invite_page.dart';
import 'messages_page.dart';




class BottomNavPage extends StatefulWidget {
  const BottomNavPage({Key? key}) : super(key: key);


  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _currentIndex = 0;
  Telephony telephony = Telephony.instance;
  final List<Widget> _screens =
  [
    const CallHistory(),
    const MessagesPage(),
    const ContactsPage(),
    const InvitePage(),
    const Profile(),
  ];

  Future<void> getCallStatus() async{
    await telephony.requestSmsPermissions;
    var callState = await telephony.callState;
    debugPrint(callState.toString());
  }
  @override
  void initState() {
    getCallStatus();
    super.initState();
  }
  int initValue = 0;

  // final ThemeStyle _currentStyle = ThemeStyle.NotificationBadge;

  // final List<int> _badgeCounts = List<int>.generate(5, (index) => index);
  //
  // final List<bool> _badgeShows = List<bool>.generate(5, (index) => true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildLightDesign(),
    );
  }

  Widget _buildLightDesign() {
    return CustomNavigationBar(
      iconSize: 25.0,
      selectedColor: AppColors.themeColor,
      strokeColor: const Color(0x30040307),
      unSelectedColor: const Color(0xffacacac),
      elevation: 10,
      backgroundColor: Colors.white,

      items: [
        CustomNavigationBarItem(
          icon: const Icon(Icons.call_outlined),
          selectedTitle: const Text('Call',style: TextStyle(fontSize: 12,color: AppColors.themeColor),),
          title: const Text('Call',style: TextStyle(fontSize: 12),)
        ),
        CustomNavigationBarItem(
            icon: Image.asset('assets/images/message_icon.png',
                color: _currentIndex== 1?AppColors.themeColor:Colors.grey),
            selectedTitle: const Text('Messages',style: TextStyle(fontSize: 12,color: AppColors.themeColor),),
            title: const Text('Messages',style: TextStyle(fontSize: 12),)
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.contacts),
            selectedTitle: const Text('Contacts',style: TextStyle(fontSize: 12,color: AppColors.themeColor),),
            title: const Text('Contacts',style: TextStyle(fontSize: 12),)
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.add_box),
            selectedTitle: const Text('Invite',style: TextStyle(fontSize: 12,color: AppColors.themeColor),),
            title: const Text('Invite',style: TextStyle(fontSize: 12),)
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.account_circle),
            selectedTitle: const Text('Profile',style: TextStyle(fontSize: 12,color: AppColors.themeColor),),
            title: const Text('Profile',style: TextStyle(fontSize: 12),)
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
