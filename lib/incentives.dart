import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Incentive extends StatefulWidget {
  @override
  _IncentiveState createState() => _IncentiveState();
}

class _IncentiveState extends State<Incentive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 300,
                child: Text(
                  "Redeem your points by going to these restraunts for free food!",
                  style: TextStyle(
                      fontFamily: 'Roboto Medium',
                      color: Colors.white,
                      fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset('images/incentive.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Text("200",
                    style: TextStyle(
                        fontFamily: 'Roboto Medium',
                        color: Colors.white,
                        fontSize: 30)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _popup(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: HexColor('#A04E8A')),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "McDonald's",
                                    style: TextStyle(
                                        fontFamily: 'Roboto Medium',
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "120",
                                    style: TextStyle(
                                        fontFamily: 'Roboto Medium',
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: HexColor('#E65546')),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "KFC",
                                  style: TextStyle(
                                      fontFamily: 'Roboto Medium',
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                                Text(
                                  "120",
                                  style: TextStyle(
                                      fontFamily: 'Roboto Medium',
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: HexColor('#5B9512')),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Subway",
                                  style: TextStyle(
                                      fontFamily: 'Roboto Medium',
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                                Text(
                                  "100",
                                  style: TextStyle(
                                      fontFamily: 'Roboto Medium',
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: HexColor('#12BEBC')),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Burger King",
                                  style: TextStyle(
                                      fontFamily: 'Roboto Medium',
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                                Text(
                                  "100",
                                  style: TextStyle(
                                      fontFamily: 'Roboto Medium',
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _popup(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: HexColor('#FFFFFF'),
            ),
            height: MediaQuery.of(context).size.height * 0.25,
            child: Container(
              child: Image.asset('images/qrdummy.PNG'),
            ),
          ),
          contentPadding: EdgeInsets.all(0.0),
        );
      });
}
