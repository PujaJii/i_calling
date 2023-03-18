import 'package:flutter/material.dart';
import 'package:i_calling/styles/common_module/app_bar.dart';



class ViewAll extends StatelessWidget {
   String number;
   ViewAll(this.number, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBars.myAppBar('Call History',Icons.delete),
      body: ListView.builder(
        itemCount: 12,
        padding: const EdgeInsets.only(left: 20),
        itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Text('    $number',style: const TextStyle(fontSize: 17)),
            Row(
              children: const [
                Icon(Icons.call_missed,color: Colors.red),
                Text('    Mobile'),
                Text('    5:32 PM'),
              ],
            ),

          ],
        );
      },),
    );
  }
}
