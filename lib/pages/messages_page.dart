import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

import '../styles/app_colors.dart';


class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {

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

  List<SmsMessage> _messages = [];
  Telephony telephony = Telephony.instance;

  Future<void> _getMessages() async {
    List<SmsMessage> messages = await telephony.getInboxSms(
        //columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
        //filter: SmsFilter.,
       // sortOrder: [SmsColumn.DATE,]
        );
    setState(() {
      _messages = messages;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    _getMessages();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
        Column(
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: InkWell(
                onTap: () {
                 // Get.to(() => const SearchPage());
                },
                child: Material(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    //side:  BorderSide(color: AppColors.pattern1, width: 1),
                  ),
                  // borderRadius: BorderRadiusGeometry,
                  child: Container(
                    height: 45,
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)
                    ),
                    child: Row(
                      children:  [
                        //const SizedBox(width: 15,),
                        Container(
                          height: 33,
                          width: 33,
                          margin: const EdgeInsets.only(left: 15),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              image: DecorationImage(
                                  image: AssetImage('assets/images/my_profile.jpg'))),
                        ),
                        const Text('    Search numbers, names & more'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Text('Total Messages (${_messages.length.toString()})'),
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.themeColor,),
                      borderRadius: BorderRadius.circular(25),color: colors[index % colors.length],
                    ),
                    child: Icon(Icons.person,color: colors2[index % colors2.length]),
                  ),
                  title:
                  Text(_messages[index].address.toString(),style: const TextStyle(
                      fontSize: 14,)),
                  subtitle: _messages[index].body ==null || _messages[index].body!.isEmpty?
                  const Text(''):
                  Text(_messages[index].body!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  // Text(messages[index].address!.first.value.toString()),
                );
              },),
            ),
          ],
        )
      ),
    );
  }
}
