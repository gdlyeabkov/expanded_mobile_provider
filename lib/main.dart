import 'package:flutter/material.dart';

import 'package:call_log/call_log.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mobileprovider/detalization.dart';
import 'package:mobile_number/mobile_number.dart';

import 'costs.dart';

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
      routes: {
        '/main': (context) => const MyHomePage(),
        '/costs': (context) => const CostsPage(),
        '/detalization': (context) => const DetalizationPage()
      }
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
  String phoneNumber = '';

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      String rawPhoneNumber = (await MobileNumber.mobileNumber)!;
      List<String> phoneParts = rawPhoneNumber.split('\+');
      phoneNumber = phoneParts[1];
      print('phoneNumber: ${phoneNumber}');
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }
  }

  @override
  void initState() {
    super.initState();
    initMobileNumberState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: DropdownButton<String>(
            value: phoneNumber,
            icon: const Icon(
              Icons.arrow_drop_down
            ),
            isExpanded: true,
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onTap: () {

            },
            onChanged: (String? newValue) {

              setState(() {
                phoneNumber = newValue!;
              });
            },
            items: [
              DropdownMenuItem(
                child: Text(
                  phoneNumber
                ),
                value: phoneNumber
              )
            ]
          ),
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
                      Navigator.pushNamed(context, '/costs');
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Март'
                              ),
                              Text(
                                '0 Р'
                              )
                            ]
                          ),
                          LinearProgressIndicator(
                            backgroundColor: Color.fromARGB(255, 253, 162, 79),
                            color: Color.fromARGB(255, 255, 0, 200),
                            value: 0.7,
                          ),
                          Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.circle,
                                  color: Color.fromARGB(255, 255, 0, 200)
                                ),
                                margin: EdgeInsets.only(
                                  left: 15
                                )
                              ),
                              Container(
                                child: Text(
                                  'Сообщения'
                                ),
                                margin: EdgeInsets.only(
                                    left: 15
                                )
                              ),
                              Container(
                                child: Icon(
                                  Icons.circle,
                                  color: Color.fromARGB(255, 253, 162, 79)
                                ),
                                margin: EdgeInsets.only(
                                  left: 15
                                )
                              ),
                              Container(
                                child: Text(
                                  'Звонки'
                                ),
                                margin: EdgeInsets.only(
                                  left: 15
                                )
                              )
                            ]
                          ),
                          Text(
                            'Подробнее',
                            textAlign: TextAlign.right,
                          )
                        ]
                      )
                    )
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
