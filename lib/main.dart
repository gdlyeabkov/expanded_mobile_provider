import 'package:flutter/material.dart';

import 'package:call_log/call_log.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Softtrack мобильный оператор связи',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int currentTab = 0;
  List<GestureDetector> logs = [];

  addLog(CallLogEntry record, context) {
    String? contactName = record.name;
    String? awardDesc = record.name;
    String? awardType = record.name;
    // List<String> rawAwardDateTime = awardDesc.split(' ');
    // String rawAwardDate = rawAwardDateTime[0];
    // List<String> rawAwardDateParts = rawAwardDate.split('.');
    // String rawAwardDateDay = rawAwardDateParts[0];
    // String rawAwardDateMonth = rawAwardDateParts[1];
    // String rawAwardDateYear = rawAwardDateParts[2];
    // int awardDateMonth = int.parse(rawAwardDateMonth);
    // String awardDateMonthLabel = "monthsLabels[awardDateMonth]!";
    // String correctAwardDateMonth = rawAwardDateMonth;
    // if (correctAwardDateMonth.length == 1) {
    //   correctAwardDateMonth = '0${correctAwardDateMonth}';
    // }
    // DateTime pickedDate = DateTime.parse('${rawAwardDateYear}-${correctAwardDateMonth}-${rawAwardDateDay}');
    // String weekDayKey = DateFormat('EEEE').format(pickedDate);
    String? weekDayLabel = "weekDayLabels[weekDayKey]";
    String awardWeekDay = weekDayLabel;
    String awardDate = '{awardWeekDay}, {rawAwardDateDay} {awardDateMonthLabel}';
    GestureDetector award = GestureDetector(
        child: Column(
            children: [
              Image.network(
                  'https://cdn2.iconfinder.com/data/icons/flat-pack-1/64/Trophy-256.png',
                  width: 75
              ),
              Text(
                '$contactName',
                textAlign: TextAlign.center,
              ),
              Text(
                awardDate,
                textAlign: TextAlign.center,
              ),
            ]
        )
    );
    logs.add(award);
  }

  Future<Iterable<CallLogEntry>> getCallLogs() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    return entries;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Softtrack Мобильный оператор связи'),
          bottom: TabBar(
            onTap: (index) {
              print('currentTabIndex: ${index}');
              setState(() {
                currentTab = index;
              });
            },
            tabs: <Widget>[
              Tab(
                text: 'Связь'
              ),
              Tab(
                text: 'Финансы'
              ),
              Tab(
                text: 'Услуги'
              ),
              Tab(
                text: 'Для меня'
              ),
              Tab(
                  text: 'Другое'
              )
            ]
          )
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Расходы'
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      margin: EdgeInsets.all(
                        15
                      ),
                      padding: EdgeInsets.all(
                        15
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255)
                      ),
                    )
                  ),
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
                              height: 250,
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
                ]
              )
            ),
            SingleChildScrollView(
              child: Column(
                children: []
              )
            ),
            SingleChildScrollView(
              child: Column(
                children: []
              )
            ),
            SingleChildScrollView(
              child: Column(
                children: []
              )
            ),
            SingleChildScrollView(
              child: Column(
                children: []
              )
            )
          ]
        )
      )
    );
  }
}
