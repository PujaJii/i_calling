import 'package:flutter/material.dart';



class InvitePage extends StatelessWidget {
  const InvitePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Future<void> share() async {
    //   await FlutterShare.share(
    //       title: 'Example share',
    //       text: 'Example share text',
    //       linkUrl: 'https://flutter.dev/',
    //       chooserTitle: 'Example Chooser Title',
    //   );
    // }
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/images/invite_frndz.png'),
          const Text('Invite Your Friends To Join\ni - calling',
              textAlign: TextAlign.center,style: TextStyle(fontSize: 18)),
          // ElevatedButton(
          //     onPressed: () {
          //      share();
          // }, child: const Text('Share'))
        ],
      ),
    );
  }
}
