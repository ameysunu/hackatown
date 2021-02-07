import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

final firestoreInstance = FirebaseFirestore.instance;
DateTime now = DateTime.now();
String newDate = DateFormat('EEE d MMM, kk:mm').format(now);

class QR extends StatefulWidget {
  @override
  _QRState createState() => _QRState();
}

class _QRState extends State<QR> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text(
              'QR Scan',
              style:
                  TextStyle(fontFamily: 'Roboto Medium', color: Colors.white),
            )),
        body: Builder(builder: (BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.asset('images/QR.png'),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  color: HexColor('#A470C5'),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Scan",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Roboto Medium",
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    scanQR();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SelectableText(
                  "Scan Result: $_scanBarcode\n",
                  style: TextStyle(
                      fontFamily: 'Roboto', color: Colors.white, fontSize: 20),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  color: HexColor('#FFFFFF'),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Roboto Medium",
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () async {
                    firestoreInstance
                        .collection('saved')
                        .doc(
                            '${now.hour.toString()}${now.minute.toString()}${now.second.toString()}')
                        .set({
                      "title": _scanBarcode,
                    }).then((_) {
                      print("success!");
                    });
                  },
                ),
              ),
            ],
          );
          // return Container(
          //     alignment: Alignment.center,
          //     child: Flex(
          //         direction: Axis.vertical,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: <Widget>[
          //           RaisedButton(
          //               onPressed: () => scanQR(),
          //               child: Text("Start QR scan")),
          //           Padding(
          //             padding: const EdgeInsets.all(10.0),
          //             child: SelectableText('Scan result : $_scanBarcode\n',
          //                 style: TextStyle(fontSize: 20)),
          //           )
          //         ]));
        }));
  }
}
