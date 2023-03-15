import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    List<Color> colors = [
      AppColors.pattern1,
      AppColors.pattern2,
      AppColors.pattern3,
      AppColors.pattern4,
    ];
    List<Color> colors2 = [
      // const Color(0x3300AF5B),
      const Color(0xFF00AF5B),
      const Color(0xFF1800AF),
      const Color(0xFFAF4A00),
      const Color(0xFF13828A),
    ];
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 50,
                child: CupertinoSearchTextField(
                  padding: const EdgeInsets.all(8),
                  controller: controller,
                  onChanged: (value) {},
                  onSubmitted: (value) {},
                  autocorrect: true,
                ),
              ),
            ),
            const Text('History'),
            Expanded(
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                 return ListTile(
                  leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: colors[index % colors.length],
                      ),
                      child:  Center(
                          child: Text('U', 
                              style: TextStyle(
                                  color: colors2[index % colors2.length], fontSize: 20)))),
                  title: const Text('Unknown Number'),
                  subtitle: const Text('1234567890'),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
