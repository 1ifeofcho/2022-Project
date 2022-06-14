import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/provider/loginprovider.dart';
import 'package:provider/provider.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    setState(() {
      _markers.clear();
      for (final mountain in provider.mountains) {
        final marker = Marker(
          markerId: MarkerId(mountain.name),
          position: LatLng(mountain.lat, mountain.lng),
          infoWindow: InfoWindow(
            title: mountain.name,
          ),
        );
        _markers[mountain.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.56667, 126.97806),
          zoom: 8.0,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }
}
