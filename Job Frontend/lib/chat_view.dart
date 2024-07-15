import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 71, 119, 122),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 80, 0, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Icon(Icons.line_axis),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Messages',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    'Online',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    'Groups',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 150,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      Column(
                        children: [
                          ClipOval(
                            child: Container(
                              width: 95,
                              height: 95,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/image1.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Roshan',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          ClipOval(
                            child: Container(
                              width: 95,
                              height: 95,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/image2.jpeg'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Zayn',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          ClipOval(
                            child: Container(
                              width: 95,
                              height: 95,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/image3.jpeg'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Jake',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          ClipOval(
                            child: Container(
                              width: 95,
                              height: 95,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/image4.jpeg'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Paul',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            )),
        Positioned(
            top: 310,
            bottom: 0,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 194, 225, 223),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    Row(
                      children: [
                        ClipOval(
                            child: Container(
                              width: 95,
                              height: 95,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/image1.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Roshan',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  width: 140,
                                ),
                                Text(
                                  '10:10',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                                child: Text('Hello, Sir can i apply for Job?')),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        ClipOval(
                            child: Container(
                              width: 95,
                              height: 95,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/image2.jpeg'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Zayn',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  width: 160,
                                ),
                                Text(
                                  '10:10',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                                child: Text('Hello, Sir can i apply for Job?')),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        ClipOval(
                            child: Container(
                              width: 95,
                              height: 95,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/image3.jpeg'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Jake',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  width: 160,
                                ),
                                Text(
                                  '10:10',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                                child: Text('Hello, Sir can i apply for Job?')),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        ClipOval(
                            child: Container(
                              width: 95,
                              height: 95,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/image4.jpeg'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Paul',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  width: 160,
                                ),
                                Text(
                                  '10:10',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                                child: Text('Hello, Sir can i apply for Job?')),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        ClipOval(
                            child: Container(
                              width: 95,
                              height: 95,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/image4.jpeg'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Paul',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  width: 160,
                                ),
                                Text(
                                  '10:10',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                                child: Text('Hello, Sir can i apply for Job?')),
                          ],
                        )
                      ],
                    ),
                  ]),
                ),
              ),
            )),
      ]),
    );
  }
}
