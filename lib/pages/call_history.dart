
import 'dart:async';

import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:get/get.dart';
import 'package:i_calling/pages/search_page.dart';

import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
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

  Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();


  int index = 0;
  @override
  void initState() {

      getAllLogs();

    super.initState();
  }

  Future<void> _pullRefresh(var refreshIndicatorKey) async {
    // _refreshIndicatorKey.currentState?.show();
    getAllLogs();
  }
  bool isLoading = false;


  Future<void> getAllLogs() async {
    var now = DateTime.now();
    int from = now
        .subtract(const Duration(days: 2))
        .millisecondsSinceEpoch;
    int to = now
        .subtract(const Duration(days: 0))
        .millisecondsSinceEpoch;
    final Iterable<CallLogEntry> result = await CallLog.query(
      // dateFrom: from,
      // dateTo: to,
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
      // const Color(0x3300AF5B),
       AppColors.pattern1,
       AppColors.pattern2,
       AppColors.pattern3,
       AppColors.pattern4,
    ];
     List<Color> colors2 = [
      // const Color(0x3300AF5B),
       const Color(0xFF00AF5B),
       Color(0xFF1800AF),
       Color(0xFFAF4A00),
       Color(0xFF13828A),
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
      var mycl2 = colors2[index % colors.length];
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
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.themeColor,),
                      borderRadius: BorderRadius.circular(25),
                      color: colors[index % colors.length],
                    ),
                    child: entry.name == null || entry.name == ''?
                     Center(child: Text(
                        'U', style: TextStyle(color : colors2[index % colors.length], fontSize: 20))) :
                    Center(child: Text(((entry.name!).substring(0, 1)),
                        style: TextStyle(color : colors2[index % colors.length], fontSize: 20))),
                  ),
                ),
                title:
                entry.name == null || entry.name == '' ?
                const Text('Unknown Number',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),):
                Text(entry.name!, style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400)),
                subtitle: Row(
                  children: [
                    entry.callType.toString() == 'CallType.incoming' ?
                    Row(
                      children: [
                        Icon(Icons.call_received, size: 18, color: AppColors.themeColor,),
                        const Text('Received Call'),
                      ],
                    ) :
                    entry.callType.toString() == 'CallType.outgoing' ?
                    Row(
                      children: const [
                         Icon(Icons.call_made, size: 18,),
                         Text('Outgoing Call'),
                      ],
                    ) :
                    entry.callType.toString() == 'CallType.missed' ?
                    Row(
                      children: const [
                         Icon(Icons.call_missed, size: 18, color: Colors.red),
                         Text('Missed Call'),
                      ],
                    ) :
                    entry.callType.toString() == 'CallType.blocked' ?
                    Row(
                      children: const [
                         Icon(Icons.block, size: 18, color: Colors.blue),
                         Text('Blocked Call'),
                      ],
                    ) :
                    entry.callType.toString() == 'CallType.rejected' ?
                    Row(
                      children: const [
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
                    child: const Padding(
                      padding:  EdgeInsets.all(5.0),
                      child:  Icon(Icons.keyboard_arrow_right),
                    )),
              ),
            )
      );
      faves.add(Column(
            children: [
              Container(
                height: 45,
                width: 45,
                margin: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.themeColor),
                    borderRadius: BorderRadius.circular(25),
                    color: colors[index % colors.length]),
                child: Center(child: entry.name == null || entry.name == '' ?
                 Text(
                  'U', style: TextStyle(color: colors2[index % colors.length], fontSize: 20),)
                    : Text(((entry.name!).substring(0, 1)),
                  style:  TextStyle(color: colors2[index % colors.length], fontSize: 20),)),
              ),
              entry.name == null || entry.name == '' ? const Text('Unknown'):Text(entry.name!)
            ],
          ));
      index++;
    }
    return


      SafeArea(
      child: isLoading == false
          ?
       Scaffold(
          body: Center(child: CircularProgressIndicator(color: AppColors.themeColor,)))
          :
      Scaffold(
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () {
            return _pullRefresh(_refreshIndicatorKey);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const SearchPage());
                    },
                    child: Container(
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Color(0x30818181),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Row(
                        children:  [
                          //const SizedBox(width: 15,),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/logo.png'))),
                          ),
                          const Text('Search numbers, names & more'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.themeColor,
          onPressed: () {
          //  _showFormDialog();
          },
          child: Image.asset(
              'assets/images/ion_keypad.png', scale: 22, color: Colors.white),),
      ),
    );
  }

  void _showFormDialog() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              height: 300,
              width: 300,
              color: Colors.black,
              child: DialPad(
                  enableDtmf: true,
                  outputMask: "00000 00000",
                  hideSubtitle: false,
                  backspaceButtonIconColor: Colors.red,
                  buttonTextColor: Colors.white,
                  dialOutputTextColor: Colors.white,
                  keyPressed: (value){
                    print('$value was pressed');
                  },
                  makeCall: (number){
                    print(number);
                  }
              ),
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