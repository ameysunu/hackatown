import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

import 'qr.dart';

AsyncSnapshot<DocumentSnapshot> snapshot;
Stream<QuerySnapshot> newStream;

class Serial extends StatefulWidget {
  @override
  _SerialState createState() => _SerialState();
}

class _SerialState extends State<Serial> {
  File pickedImage;
  var text = '';

  bool imageLoaded = false;

  Future pickImage() async {
    var awaitImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = awaitImage;
      imageLoaded = true;
    });
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await textRecognizer.processImage(visionImage);

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          setState(() {
            text = text + word.text + ' ';
          });
        }
        text = text + '\n';
      }
    }
    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text("Serial Number",
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
            )),
      ),
      backgroundColor: HexColor('#000000'),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30.0),
            imageLoaded
                ? Center(
                    child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(blurRadius: 20),
                      ],
                    ),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    height: 250,
                    child: Image.file(
                      pickedImage,
                      fit: BoxFit.cover,
                    ),
                  ))
                : Container(),
            SizedBox(height: 10.0),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ButtonTheme(
                  height: 50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: HexColor('#000000'))),
                    onPressed: () {
                      pickImage();
                    },
                    color: HexColor('#EF7696'),
                    textColor: HexColor('#000000'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text("Upload".toUpperCase(),
                              style: TextStyle(
                                  fontFamily: 'Roboto Medium',
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            SizedBox(height: 10.0),
            text == ''
                ? Text(
                    'Upload an image',
                    style: TextStyle(fontFamily: 'Roboto'),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SelectableText(
                          text,
                          style: TextStyle(
                              fontFamily: 'Roboto', color: Colors.white),
                        ),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ButtonTheme(
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onPressed: () async {
                    firestoreInstance
                        .collection('saved')
                        .doc(
                            '${now.hour.toString()}${now.minute.toString()}${now.second.toString()}')
                        .set({
                      "title": text,
                    }).then((_) {
                      print("success!");
                    });
                    setState(() {
                      text = "";
                    });
                  },
                  color: HexColor('#FF967B'),
                  textColor: HexColor('#FFFFFF'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text("Save".toUpperCase(),
                            style: TextStyle(fontFamily: 'Roboto Medium')),
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
