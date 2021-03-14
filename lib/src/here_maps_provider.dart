import 'package:atlas/atlas.dart' as Atlas;
import 'package:flutter/material.dart';
import 'package:here_maps_atlas/src/here_maps_atlas_controller.dart';
import 'package:here_sdk/core.dart' as HereSdkCore;
import 'package:here_sdk/mapview.dart' as HereSdkMapView;

import 'utils.dart';

class HereMapsProvider extends StatefulWidget {
  final Atlas.CameraPosition initialCameraPosition;
  final Atlas.ArgumentCallback<Atlas.AtlasController> onMapCreated;
  final Set<Atlas.Marker> markers;

  HereMapsProvider({
    this.initialCameraPosition,
    this.onMapCreated,
    this.markers,
  });

  @override
  _HereMapsProviderState createState() => _HereMapsProviderState();
}

class _HereMapsProviderState extends State<HereMapsProvider> {
  Atlas.CameraPosition get initialCameraPosition =>
      widget.initialCameraPosition;

  Atlas.ArgumentCallback<Atlas.AtlasController> get onMapCreated =>
      widget.onMapCreated;

  Set<Atlas.Marker> get markers => widget.markers;

  @override
  void initState() {
    super.initState();
    HereSdkCore.SdkContext.init(HereSdkCore.IsolateOrigin.main);
  }

  @override
  Widget build(BuildContext context) {
    return HereSdkMapView.HereMap(
      onMapCreated: _onMapCreated,
    );
  }

  Future<void> _onMapCreated(
    HereSdkMapView.HereMapController hereMapController,
  ) async {
    final hereAtlasController = HereMapsAtlasController(
      controller: hereMapController,
    );

    if (markers?.isEmpty == true) {
      await hereAtlasController.moveCamera(initialCameraPosition);
    }
    onMapCreated?.call(hereAtlasController);
    addMarkers(hereMapController);
  }

  Future<void> addMarkers(
    HereSdkMapView.HereMapController hereMapController,
  ) async {
    final hereMapMarkers = await markers.toHereSetMapMarkers();

    hereMapMarkers.forEach(
      (hereMapMarker) => hereMapController.mapScene.addMapMarker(hereMapMarker),
    );
  }
}
