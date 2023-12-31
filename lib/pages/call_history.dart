
import 'dart:async';

import 'package:get/get.dart';
import 'package:i_calling/pages/search_page.dart';

import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:i_calling/pages/num_pad.dart';
import 'package:i_calling/pages/user_profile.dart';
import 'package:i_calling/styles/app_colors.dart';
import 'package:intl/intl.dart';

///TOP-LEVEL FUNCTION PROVIDED FOR WORK MANAGER AS CALLBACK
// void callbackDispatcher() {
//   Workmanager().executeTask((dynamic task, dynamic inputData) async {
//     print('Background Services are Working!');
//     try {
//       final Iterable<CallLogEntry> cLog = await CallLog.get();
//       print('Queried call log entries');
//       for (CallLogEntry entry in cLog) {
//         print('-------------------------------------');
//         print('F. NUMBER  : ${entry.formattedNumber}');
//         print('C.M. NUMBER: ${entry.cachedMatchedNumber}');
//         print('NUMBER     : ${entry.number}');
//         print('NAME       : ${entry.name}');
//         print('TYPE       : ${entry.callType}');
//         print('DATE       : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)}');
//         print('DURATION   : ${entry.duration}');
//         print('ACCOUNT ID : ${entry.phoneAccountId}');
//         print('ACCOUNT ID : ${entry.phoneAccountId}');
//         print('SIM NAME   : ${entry.simDisplayName}');
//         print('-------------------------------------');
//       }
//       return true;
//     } on PlatformException catch (e, s) {
//       print(e);
//       print(s);
//       return true;
//     }
//   });
// }
/// example widget for call log plugin
class CallHistory extends StatefulWidget {
  const CallHistory({Key? key}) : super(key: key);

  @override
  State<CallHistory> createState() => _CallHistoryState();
}

class _CallHistoryState extends State<CallHistory> {


  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();


  int index = 0;
  bool isLoading = false;
  @override
  void initState() {
      getAllLogs();
    super.initState();
  }

  Future<void> _pullRefresh(var refreshIndicatorKey) async {
    // _refreshIndicatorKey.currentState?.show();
    getAllLogs();
  }


  Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];
  Future<void> getAllLogs() async {
    // var now = DateTime.now();
    // int from = now
    //     .subtract(const Duration(days: 2))
    //     .millisecondsSinceEpoch;
    // int to = now
    //     .subtract(const Duration(days: 0))
    //     .millisecondsSinceEpoch;
    final Iterable<CallLogEntry> result = await CallLog.query(
      // dateFrom: from,
      // dateTo: to,
     // number: '9614159151'
    );
    setState(() {
      _callLogEntries = result;
      isLoading = true;
    });
  }

  _callNumber(var number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    //const TextStyle mono = TextStyle(fontFamily: 'monospace');
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

    final List<Widget> children = <Widget>[];
    final List<Widget> faves = <Widget>[];
     Map<String, CallLogEntry> uniqueCallLogs = {};

     for (CallLogEntry callLog in _callLogEntries) {
       if (!uniqueCallLogs.containsKey(callLog.number)) {
         uniqueCallLogs[callLog.number!] = callLog;
       }
     }

     for (CallLogEntry entry in uniqueCallLogs.values) {
      // print(entry.number);
    //  }
    // for (CallLogEntry entry in _callLogEntries) {

      //String nameInit = entry.name![0];
      // print(entry.callType.toString());

      var mycl = colors[index % colors.length];
      var mycl2 = colors2[index % colors2.length];
      children.add(
          InkWell(
              splashColor: AppColors.pattern1,
              highlightColor: AppColors.pattern1,
               onTap: () {
                  _callNumber(entry.number);
               },
              child: ListTile(
                leading: InkWell(
                  onTap: () {
                    Get.to(()=>  UserProfile(
                        entry.name.toString(),
                        entry.number.toString(),
                        mycl,mycl2
                    ));
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 6),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.themeColor,),
                          borderRadius: BorderRadius.circular(25),
                          color: colors[index % colors.length],
                        ),
                        child: entry.name == null || entry.name == ''?
                         Center(child: Text(
                            'U', style: TextStyle(color : colors2[index % colors2.length], fontSize: 20))) :
                        Center(child: Text(((entry.name!).substring(0, 1)),
                            style: TextStyle(color : colors2[index % colors2.length], fontSize: 20))),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          height: 15,width: 15,
                          decoration: BoxDecoration(
                            color: AppColors.themeColor,
                            border: Border.all(width: 1.5,color: Colors.white),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Text('i',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontFamily: 'JacquesFrancois-Regular'),),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                         // height: 17,width: 17,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: AppColors.themeColor2,
                              borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              offset: Offset(
                                0,
                                3,
                              ),
                            )]
                          ),
                          child: const Center(
                            child: Text('17m',
                              style: TextStyle(
                                fontSize: 8,
                                  color: Colors.white,
                              ),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                title:
                entry.name == null || entry.name == '' ?
                Text(entry.number!,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400),):
                Text(entry.name!, style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400)),
                subtitle: Row(
                    children: [
                    entry.callType.toString() == 'CallType.incoming' ?
                    const Row(
                      children: [
                         Icon(Icons.call_received, size: 18, color: AppColors.themeColor,),
                         Text('Received Call'),
                      ],
                    ) :
                    entry.callType.toString() == 'CallType.outgoing' ?
                    const Row(
                      children: [
                         Icon(Icons.call_made, size: 18,),
                         Text('Outgoing Call'),
                      ],
                    ) :
                    entry.callType.toString() == 'CallType.missed' ?
                    const Row(
                      children: [
                         Icon(Icons.call_missed, size: 18, color: Colors.red),
                         Text('Missed Call'),
                      ],
                    ) :
                    entry.callType.toString() == 'CallType.blocked' ?
                    const Row(
                      children: [
                         Icon(Icons.block, size: 18, color: Colors.blue),
                         Text('Blocked Call'),
                      ],
                    ) :
                    entry.callType.toString() == 'CallType.rejected' ?
                    const Row(
                      children: [
                         Icon(Icons.call_missed, size: 18, color: Colors.red),
                         Text('Rejected call'),
                      ],
                    ) :
                    const SizedBox(),
                    const SizedBox(width: 8,),
                    //Text('${DateFormat("h:mm a").format(DateFormat("hh:mm").parse(DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)))}'),
                    Text('.  ${DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(entry.timestamp!))}'),
                  ],
                ),
                trailing: InkWell(
                    onTap: () {
                      Get.to(()=>UserProfile(
                          entry.name.toString(),
                          entry.number.toString(),
                          mycl,mycl2)
                      );
                    },
                    child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: AppColors.pattern1,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Icon(Icons.keyboard_arrow_right,size: 17,))),
              ),
            )
      );
      faves.add(Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    margin: const EdgeInsets.symmetric(
                        vertical: 6, horizontal: 15),
                    decoration: BoxDecoration(
                        // border: Border.all(
                        //     color: AppColors.themeColor),
                        borderRadius: BorderRadius.circular(25),
                        color: colors[index % colors.length]),
                    child: Center(child: entry.name == null || entry.name == '' ?
                     Text(
                      'U', style: TextStyle(color: colors2[index % colors2.length], fontSize: 20),)
                        : Text(((entry.name!).substring(0, 1)),
                      style:  TextStyle(color: colors2[index % colors2.length], fontSize: 20),)),
                  ),
                  Positioned(
                    bottom: 0,
                    //right: 14,
                    child: Container(
                      // height: 17,width: 17,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: AppColors.themeColor2,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              offset: Offset(
                                0,
                                3,
                              ),
                            )]
                      ),
                      child: const Center(
                        child: Text('17m',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.white,
                          ),),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5,),
              entry.name == null || entry.name == '' ?
              const Expanded(child: Text('Unknown'))
                  :Expanded(child: Text(
                  entry.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,))
            ],
          ));
      index++;
    }
    return SafeArea(
      child: isLoading == false ?
       const Scaffold(
          body: Center(child: CircularProgressIndicator(color: AppColors.themeColor,))) :
      Scaffold(
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () {
            return _pullRefresh(_refreshIndicatorKey);
          },
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => const SearchPage());
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
                  const SizedBox(height: 10),
                  // Center(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: ElevatedButton(
                  //       onPressed: () async {
                  //         final Iterable<CallLogEntry> result = await CallLog.query();
                  //         setState(() {
                  //           _callLogEntries = result;
                  //         });
                  //       },
                  //       child: const Text('Get all'),
                  //     ),
                  //   ),
                  // ),
                  // Center(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: ElevatedButton(
                  //       onPressed: () {
                  //         // Workmanager().registerOneOffTask(
                  //         //   DateTime.now().millisecondsSinceEpoch.toString(),
                  //         //   'simpleTask',
                  //         //   existingWorkPolicy: ExistingWorkPolicy.replace,
                  //         // );
                  //       },
                  //       child: const Text('Get all in background'),
                  //     ),
                  //   ),
                  // ),
                  faves.isEmpty?
                  const Text('Call logs is empty!!'):faves.length < 6?
                  Container():
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      itemCount: 10,
                      padding: const EdgeInsets.only(left: 10),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return faves[index];
                      },),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: children),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.themeColor,
          onPressed: () {
          _showFormDialog();
          },
          child: Image.asset(
              'assets/images/ion_keypad.png', scale: 22, color: Colors.white),),
      ),
    );
  }
  final TextEditingController _myController = TextEditingController();
  void _showFormDialog() {
    showModalBottomSheet<void>(
        context: context,
       // barrierColor: Colors.transparent,
        elevation: 10,
        isScrollControlled : true,
        builder: (BuildContext context) {
          return FractionallySizedBox(
           // heightFactor: 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // display the entered numbers
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _myController,
                    showCursor: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                        prefixIcon:  const Icon(Icons.add_circle_outline),
                        suffix: InkWell(
                          onLongPress: () {
                            _myController.text = '';
                          },
                            child:  IconButton(
                              onPressed: () {
                                _myController.text = _myController.text
                                    .substring(0, _myController.text.length - 1);
                              }, icon: const Icon(Icons.backspace_outlined),
                            ))),
                    style: const TextStyle(fontSize: 30),
                    // Disable the default soft keyBoard
                    keyboardType: TextInputType.none,
                  ),
                ),
                // implement the custom NumPad
                NumPad(
                  buttonSize: 50,
                  //buttonColor: Colors.purple,
                  iconColor: Colors.black,
                  controller: _myController,
                  delete: () {
                    // _myController.text = _myController.text
                    //     .substring(0, _myController.text.length - 1);
                  },
                  //do something with the input numbers
                  onSubmit: () {
                    // debugPrint('Your code: ${_myController.text}');
                    // showDialog(
                    //     context: context,
                    //     builder: (_) => AlertDialog(
                    //       content: Text(
                    //         "You code is ${_myController.text}",
                    //         style: const TextStyle(fontSize: 30),
                    //       ),
                    //   ));
                  },
                ),
                const SizedBox(height: 18,),
                InkWell(
                  onTap: () {
                     _callNumber(_myController.text);
                   },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00AF5B),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(Icons.call_outlined, size: 27,color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10,)
              ],
            ),
          );
        }
    );
  }
}
/*
      Column(
          children: <Widget>[
            const Divider(),
            Text('F. NUMBER  : ${entry.formattedNumber}', style: mono),
            Text('C.M. NUMBER: ${entry.cachedMatchedNumber}', style: mono),
            Text('NUMBER     : ${entry.number}', style: mono),
            Text('NAME       : ${entry.name}', style: mono),
            Text('TYPE       : ${entry.callType}', style: mono),
            Text('DATE       : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)}',
                style: mono),
            Text('DURATION   : ${entry.duration}', style: mono),
            Text('ACCOUNT ID : ${entry.phoneAccountId}', style: mono),
            Text('SIM NAME   : ${entry.simDisplayName}', style: mono),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
        ),
 */