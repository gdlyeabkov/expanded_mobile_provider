import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CostsPage extends StatefulWidget {

  const CostsPage({Key? key}) : super(key: key);

  @override
  State<CostsPage> createState() => CostsPageState();

}

class CostsPageState extends State<CostsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Расходы'
          )
        ),
        body: Column(
          children: [
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(
                  15
                ),
                margin: EdgeInsets.all(
                  15
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Color.fromARGB(255, 255, 0, 200)
                        ),
                        Container(
                          child: Text(
                            'Сообщения'
                          ),
                          margin: EdgeInsets.only(
                            left: 15
                          )
                        )
                      ]
                    ),
                    Row(
                      children: [
                        Container(
                          child: Text(
                            '26.4 Р'
                          ),
                          margin: EdgeInsets.only(
                            right: 15
                          ),
                        ),
                        Icon(
                          Icons.chevron_right
                        )
                      ]
                    )
                  ]
                )
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detalization',
                  arguments: {
                    'data': 'Сообщения'
                  }
                );
              }
            ),
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, '/detalization');
                Navigator.pushNamed(
                  context,
                  '/detalization',
                  arguments: {
                    'data': 'Звонки'
                  }
                );
              },
              child: Container(
                padding: EdgeInsets.all(
                  15
                ),
                margin: EdgeInsets.all(
                  15
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Color.fromARGB(255, 253, 162, 79)
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
                    Row(
                      children: [
                        Container(
                          child: Text(
                            '26.4 Р'
                          ),
                          margin: EdgeInsets.only(
                            right: 15
                          ),
                        ),
                        Icon(
                          Icons.chevron_right
                        )
                      ]
                    )
                  ]
                )
              )
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(
                  15
                ),
                margin: EdgeInsets.all(
                  15
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Color.fromARGB(255, 130, 57, 213)
                        ),
                        Container(
                          child: Text(
                            'Интернет'
                          ),
                          margin: EdgeInsets.only(
                            left: 15
                          )
                        )
                      ]
                    ),
                    Row(
                      children: [
                        Container(
                          child: Text(
                            '26.4 Р'
                          ),
                          margin: EdgeInsets.only(
                            right: 15
                          ),
                        ),
                        Icon(
                          Icons.chevron_right
                        )
                      ]
                    )
                  ]
                )
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detalization',
                  arguments: {
                    'data': 'Интернет'
                  }
                );
              }
            )
          ]
        )
    );
  }

}