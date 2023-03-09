import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:get/get.dart';
import 'package:i_calling/pages/search_page.dart';

import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

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
  int index = 0;

  //
  // static const _pageSize = 20;
  //
  // final PagingController<int, CharacterSummary> _pagingController =
  // PagingController(firstPageKey: 0);
  //
  // Future<void> _fetchPage(int pageKey) async {
  //   try {
  //     final newItems = await RemoteApi.getCharacterList(pageKey, _pageSize);
  //     final isLastPage = newItems.length < _pageSize;
  //     if (isLastPage) {
  //       _pagingController.appendLastPage(newItems);
  //     } else {
  //       final nextPageKey = pageKey + newItems.length;
  //       _pagingController.appendPage(newItems, nextPageKey);
  //     }
  //   } catch (error) {
  //     _pagingController.error = error;
  //   }
  // }
  @override
  void initState() {
    // TODO: implement initState
    getAllLogs();
    // _pagingController.addPageRequestListener((pageKey) {
    //   _fetchPage(pageKey);
    // });
    super.initState();
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
      dateFrom: from,
      dateTo: to,
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
      const Color(0x3300AF5B),
      const Color(0x331800AF),
      const Color(0x33AF4A00),
      const Color(0x33AF0000),
    ];

    final List<Widget> children = <Widget>[];
    final List<Widget> faves = <Widget>[];
    for (CallLogEntry entry in _callLogEntries) {
      //String nameInit = entry.name![0];
      // print(entry.callType.toString());
      index++;
        children.add(
            ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: colors[index % colors.length],
                ),
                child: entry.name == null || entry.name == ''?
                const Center(child: Text(
                    'U', style: TextStyle(color : Colors.white, fontSize: 20))) :
                Center(child: Text(((entry.name!).substring(0, 1)),
                    style: const TextStyle(color : Colors.white, fontSize: 20))),
              ),
              title:
              entry.name == null || entry.name == '' ?
              const Text('Unknown Number'):
              Text(entry.name!, style: const TextStyle(fontSize: 14)),
              subtitle: Row(
                children: [
                  entry.callType.toString() == 'CallType.incoming' ?
                  const Icon(
                    Icons.call_received, size: 18, color: Colors.green,) :
                  entry.callType.toString() == 'CallType.outgoing' ?
                  const Icon(Icons.call_made, size: 18,) :
                  entry.callType.toString() == 'CallType.missed' ?
                  const Icon(Icons.call_missed, size: 18, color: Colors.red) :
                  entry.callType.toString() == 'CallType.blocked' ?
                  const Icon(Icons.block, size: 18, color: Colors.blue) :
                  entry.callType.toString() == 'CallType.rejected' ?
                  const Icon(Icons.call_received, size: 18,
                      color: Colors.blue) :
                  const SizedBox(),
                  const SizedBox(width: 8,),
                  Text(entry.number!),
                ],
              ),
              trailing: InkWell(
                  onTap: () {
                    _callNumber(entry.number);
                  },
                  child: const Icon(Icons.call)),
            )
        );

      faves.add(
          Column(
            children: [
              Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: colors[index % colors.length]),
                child: Center(child: entry.name == null || entry.name == '' ?
                const Text(
                  'U', style: TextStyle(color: Colors.white, fontSize: 20),)
                    : Text(((entry.name!).substring(0, 1)),
                  style: const TextStyle(color: Colors.white, fontSize: 20),)),
              ),
              entry.name == null || entry.name == '' ? const Text('U'):Text(entry.name!)
            ],
          )
      );
    }
    return SafeArea(
      child: isLoading == false
          ?
      const Scaffold(
          body: Center(child: CircularProgressIndicator(color: Colors.green,)))
          :
      Scaffold(
        body: SingleChildScrollView(
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
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0x30818181),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Row(
                      children: const [
                        SizedBox(width: 15,),
                        Icon(Icons.search),
                        Text('     Search'),
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            _showFormDialog();
          },
          child: Image.asset(
              'assets/images/ion_keypad.png', scale: 18, color: Colors.white),),
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