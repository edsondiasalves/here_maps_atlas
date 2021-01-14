import 'package:atlas/atlas.dart';
import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';

class HereMapsProvider extends StatefulWidget {
  final CameraPosition initialCameraPosition;

  HereMapsProvider({this.initialCameraPosition});

  @override
  _HereMapsProviderState createState() => _HereMapsProviderState();
}

class _HereMapsProviderState extends State<HereMapsProvider> {
  @override
  Widget build(BuildContext context) {
    return HereMap(onMapCreated: _onMapCreated);
  }

  @override
  void initState() {
    super.initState();
    SdkContext.init(IsolateOrigin.main);
  }

  void _onMapCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError error) {
      if (error != null) {
        print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }

      const double distanceToEarthInMeters = 8000;
      hereMapController.camera.lookAtPointWithDistance(
          GeoCoordinates(
            widget.initialCameraPosition.target.latitude,
            widget.initialCameraPosition.target.longitude,
          ),
          distanceToEarthInMeters);
    });
  }
}
