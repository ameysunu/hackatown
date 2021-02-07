import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share/share.dart';

class Recycle extends StatefulWidget {
  @override
  _RecycleState createState() => _RecycleState();
}

class _RecycleState extends State<Recycle> {
  MapType _currentMapType = MapType.normal;
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAsset('images/marker.bmp');
  }

  @override
  LatLng pinPosition = LatLng(45.525714, -73.577330);
  LatLng pinPosition1 = LatLng(45.526258, -73.580345);
  LatLng pinPosition2 = LatLng(45.520337, -73.576275);
  LatLng pinPosition3 = LatLng(40.7265969, -74.00541);

  CameraPosition initialLocation = CameraPosition(
      zoom: 12, bearing: 30, target: LatLng(45.525714, -73.577330));

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          "Recycle Bins",
          style: TextStyle(fontFamily: 'Roboto Medium'),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () {
                Share.share(
                    'Hey, come help me trash this garbage and earn points!, Download GreenTown from here: https://drive.google.com/drive/u/0/folders/16b6BgwR5uL6Wu3I0DmxWHBeswNQ_U5XQ',
                    subject: 'GreenTown');
              })
        ],
      ),
      body: GoogleMap(
        mapType: _currentMapType,
        myLocationEnabled: true,
        markers: _markers,
        initialCameraPosition: initialLocation,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          setState(() {
            _markers.add(Marker(
                markerId: MarkerId("Trash Can"),
                position: pinPosition,
                infoWindow: InfoWindow(
                  title: 'Trash Can',
                ),
                icon: pinLocationIcon));

            _markers.add(Marker(
                markerId: MarkerId("Trash Can"),
                position: pinPosition1,
                infoWindow: InfoWindow(
                  title: 'Trash Can',
                ),
                icon: pinLocationIcon));

            _markers.add(Marker(
                markerId: MarkerId("Trash Can"),
                position: pinPosition2,
                infoWindow: InfoWindow(
                  title: 'Trash Can',
                ),
                icon: pinLocationIcon));
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(
          Icons.map,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            _currentMapType = _currentMapType == MapType.normal
                ? MapType.satellite
                : MapType.normal;
          });
        },
      ),
    );
  }
}
