import 'dart:typed_data';

import 'package:atlas/atlas.dart' as Atlas;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  void _onMapCreated(HereSdkMapView.HereMapController hereMapController) {
    HereMapsAtlasController hereAtlasController = HereMapsAtlasController(
      controller: hereMapController,
    );

    onMapCreated?.call(hereAtlasController);
    hereAtlasController.moveCamera(widget.initialCameraPosition);

    addMarkers(hereMapController);
  }

  Future<void> addMarkers(
      HereSdkMapView.HereMapController hereMapController) async {
    for (Atlas.Marker atlasMarker in markers) {
      final coordinates = atlasMarker.position.toHereMapsGeoCoordinate();
      final iconData = await _loadAsset(atlasMarker.icon.assetName);

      final iconMapImage = HereSdkMapView.MapImage.withPixelDataAndImageFormat(
        iconData,
        HereSdkMapView.ImageFormat.png,
      );

      final anchor2D = HereSdkCore.Anchor2D.withHorizontalAndVertical(0.5, 1);

      final mapMarker = HereSdkMapView.MapMarker.withAnchor(
        coordinates,
        iconMapImage,
        anchor2D,
      );
      mapMarker.drawOrder = 1;

      final metadata = new HereSdkCore.Metadata();
      metadata.setString("key_poi", "Metadata: This is a POI.");
      mapMarker.metadata = metadata;
      hereMapController.mapScene.addMapMarker(mapMarker);
    }
  }

  Future<Uint8List> _loadAsset(assetName) async {
    ByteData fileData = await rootBundle.load(assetName);
    return Uint8List.view(fileData.buffer);
  }
}
