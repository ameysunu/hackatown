import 'package:flutter/material.dart';

class Saved extends StatefulWidget {
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
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
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
