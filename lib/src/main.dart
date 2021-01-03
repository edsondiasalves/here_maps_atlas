import 'package:atlas/atlas.dart';
import 'package:flutter/material.dart';
import 'package:here_maps_atlas/src/here_atlas.dart';

void main() {
  AtlasProvider.instance = HereAtlas();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HERE SDK for Flutter - Hello Map!',
      home: Atlas(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            latitude: 52.530932,
            longitude: 13.384915,
          ),
        ),
      ),
    );
  }
}
