import 'package:call_log/call_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class DetalizationPage extends StatefulWidget {

  const DetalizationPage({Key? key}) : super(key: key);

  @override
  State<DetalizationPage> createState() => DetalizationPageState();

}

class DetalizationPageState extends State<DetalizationPage> {

  List<GestureDetector> logs = [];
  List<GestureDetector> messages = [];
  String data = '';

  addMessage(SmsMessage record, context) {
    String? contactName = record.sender;
    SmsMessageKind? smsType = record.kind;
    bool isIncomingCall = true;
    if (smsType == SmsMessageKind.received) {
      isIncomingCall = true;
    } else if (smsType == SmsMessageKind.sent) {
      isIncomingCall = false;
    }
    DateTime? smsDate = record.date;
    String smsDateLabel = DateFormat('dd.MM.yyyy в hh:mm').format(smsDate!);
    GestureDetector award = GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 15
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '$contactName',
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          child: Icon(
                            Icons.show_chart,
                            color: (
                              isIncomingCall ?
                                Color.fromARGB(255, 255, 0, 0)
                              :
                                Color.fromARGB(255, 0, 150, 0)
                            )
                          ),
                          margin: EdgeInsets.only(
                              left: 15
                          )
                        )
                      ]
                    ),
                    Text(
                      'Исходящие SMS/MMS Домашнего\nрегиона',
                      textAlign: TextAlign.left,
                    )
                  ]
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        '1,5 Р'
                    ),
                    Text(
                      smsDateLabel
                    )
                  ]
                )
              ]
            ),
            Divider()
          ]
        )
      )
    );
    messages.add(award);
  }

  addLog(CallLogEntry record, context) {
    String? contactName = record.name;
    String? awardDesc = record.name;
    CallType? callType = record.callType;
    bool isIncomingCall = true;
    if (callType == CallType.incoming) {
      isIncomingCall = true;
    } else if (callType == CallType.outgoing) {
      isIncomingCall = false;
    }
    int? callTimeStamp = record.timestamp;
    DateTime callDate = DateTime.fromMillisecondsSinceEpoch(callTimeStamp!);
    String callDateLabel = DateFormat('dd.MM.yyyy в hh:mm').format(callDate);
    String? weekDayLabel = "weekDayLabels[weekDayKey]";
    GestureDetector award = GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 15
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '$contactName',
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          child: Icon(
                            Icons.show_chart,
                            color: (
                              isIncomingCall ?
                                Color.fromARGB(255, 255, 0, 0)
                              :
                                Color.fromARGB(255, 0, 150, 0)
                            )
                          ),
                          margin: EdgeInsets.only(
                            left: 15
                          ),
                        )
                      ]
                    ),
                    Text(
                      'Исходящие звонки Домашнего\nрегиона',
                      textAlign: TextAlign.left,
                    )
                  ]
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '1,5 Р'
                    ),
                    Text(
                      callDateLabel
                    )
                  ]
                )
              ]
            ),
            Divider()
          ]
        )
      )
    );
    logs.add(award);
  }

  Future<Iterable<CallLogEntry>> getCallLogs() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    return entries;
  }

  Future<List<SmsMessage>> getMessages() async {
    // var status = await Permission.sms.status;
    var status = await Permission.sms.request();
    print('status: ${status}');
    if (status.isGranted) {
      SmsQuery query = SmsQuery();
      List<SmsMessage> messages = await query.getAllSms;
      for (SmsMessage message in messages) {
        print('message.sender: ${message.sender}');
      }
      return messages;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      if (arguments != null) {
        print(arguments['foodType']);
        data = arguments['data'];
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$data'
        )
      ),
      body: (
        data == 'Звонки' ?
          FutureBuilder(
            future: getCallLogs(),
            builder: (BuildContext context, AsyncSnapshot<Iterable<CallLogEntry>> snapshot) {
              int snapshotsCount = 0;
              if (snapshot.data != null) {
                snapshotsCount = snapshot.data!.length;
                logs = [];
                for (int snapshotIndex = 0; snapshotIndex < snapshotsCount; snapshotIndex++) {
                  addLog(snapshot.data!.elementAt(snapshotIndex), context);
                }
              }
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height - 100,
                      child: SingleChildScrollView(
                        child: Column(
                          children: logs
                        )
                      )
                    )
                  ]
                );
              } else {
                return Column(

                );
              }
              return Column(

              );
            }
          )
        : data == 'Сообщения' ?
          FutureBuilder(
            future: getMessages(),
            builder: (BuildContext context, AsyncSnapshot<List<SmsMessage>> snapshot) {
              int snapshotsCount = 0;
              if (snapshot.data != null) {
                snapshotsCount = snapshot.data!.length;
                logs = [];
                for (int snapshotIndex = 0; snapshotIndex < snapshotsCount; snapshotIndex++) {
                  addMessage(snapshot.data!.elementAt(snapshotIndex), context);
                }
              }
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height - 100,
                      child: SingleChildScrollView(
                        child: Column(
                          children: messages
                        )
                      )
                    )
                  ]
                );
              } else {
                return Column(

                );
              }
              return Column(

              );
            }
          )
        :
          FutureBuilder(
            future: getCallLogs(),
            builder: (BuildContext context, AsyncSnapshot<Iterable<CallLogEntry>> snapshot) {
              int snapshotsCount = 0;
              if (snapshot.data != null) {
                snapshotsCount = snapshot.data!.length;
                logs = [];
                for (int snapshotIndex = 0; snapshotIndex < snapshotsCount; snapshotIndex++) {
                  addLog(snapshot.data!.elementAt(snapshotIndex), context);
                }
              }
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height - 100,
                      child: SingleChildScrollView(
                        child: Column(
                          children: logs
                        )
                      )
                    )
                  ]
                );
              } else {
                return Column(

                );
              }
              return Column(

              );
            }
          )
      )
    );
  }

}