import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'qr.dart';

AsyncSnapshot<DocumentSnapshot> snapshot;
Stream<QuerySnapshot> newStream;

class Saved extends StatefulWidget {
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  void initState() {
    super.initState();
    newStream = firestoreInstance.collection('saved').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Saved Trash",
          style: TextStyle(fontFamily: 'Roboto Medium'),
        ),
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: Container(
          child: StreamBuilder(
            stream: newStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              var totalgroupCount = 0;
              List<DocumentSnapshot> groupUsers;
              if (snapshot.hasData) {
                groupUsers = snapshot.data.documents;
                totalgroupCount = groupUsers.length;
                return (Container(
                  child: ListView.builder(
                      itemCount: groupUsers.length,
                      itemBuilder: (context, int index) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: SelectableText(
                                                groupUsers[index]
                                                    .data()['title'],
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 20,
                                                    color:
                                                        HexColor('#000000'))),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
