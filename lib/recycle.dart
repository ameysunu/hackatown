import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    );
  }
}
