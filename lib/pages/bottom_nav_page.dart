import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:i_calling/pages/profile.dart';

import '../styles/app_colors.dart';
import 'call_history.dart';
import 'contact_page.dart';
import 'invite_page.dart';




class BottomNavPage extends StatefulWidget {
  const BottomNavPage({Key? key}) : super(key: key);


  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _currentIndex = 0;
  final List<Widget> _screens =
  [
    const CallHistory(),
    const ContactsPage(),
    const InvitePage(),
    const Profile(),
  ];

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
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.contacts),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.add_box),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.account_circle),
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
