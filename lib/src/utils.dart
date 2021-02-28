import 'dart:typed_data';

import 'package:atlas/atlas.dart' as Atlas;
import 'package:flutter/services.dart';
import 'package:here_sdk/core.dart' as HereMaps;
import 'package:here_sdk/core.dart' as HereSdkCore;
import 'package:here_sdk/mapview.dart' as HereSdkMapView;
import 'package:image/image.dart' as Image;

extension AtlasLatLngToHereGeoCoordinate on Atlas.LatLng {
  HereMaps.GeoCoordinates toHereMapsGeoCoordinate() {
    return HereMaps.GeoCoordinates(
      this.latitude,
      this.longitude,
    );
  }
}

extension AtlasCameraPositionToHereGeoCoordinate on Atlas.CameraPosition {
  HereMaps.GeoCoordinates toGeoCoordinates() {
    final geoCoordinates = HereMaps.GeoCoordinates(
      this.target.latitude,
      this.target.longitude,
    );
    return geoCoordinates;
  }
}

extension AtlasMarkerToHereMapMarker on Atlas.Marker {
  Future<HereSdkMapView.MapMarker> toHereMarker() async {
    final coordinates = this.position.toHereMapsGeoCoordinate();
    final anchor2D = HereSdkCore.Anchor2D.withHorizontalAndVertical(0.5, 1);
    final imagePixelData = await _loadAsset(this);
    final iconMapImage = HereSdkMapView.MapImage.withPixelDataAndImageFormat(
      imagePixelData,
      HereSdkMapView.ImageFormat.png,
    );

    final mapMarker = HereSdkMapView.MapMarker.withAnchor(
      coordinates,
      iconMapImage,
      anchor2D,
    );
    mapMarker.drawOrder = 1;

    final metadata = new HereSdkCore.Metadata();
    metadata.setString("key_poi", "Metadata: This is a POI.");
    mapMarker.metadata = metadata;

    return mapMarker;
  }
}

extension AtlasSetMarkerToSetHereMarkers on Set<Atlas.Marker> {
  Future<Set<HereSdkMapView.MapMarker>> toHereSetMapMarkers() async {
    List<HereSdkMapView.MapMarker> hereMapMarkers = [];

    for (Atlas.Marker marker in this) {
      final markers = await marker.toHereMarker();
      hereMapMarkers.add(markers);
    }

    return Set.from(hereMapMarkers);
  }
}

Future<Uint8List> _loadAsset(Atlas.Marker marker) async {
  final fileData = await rootBundle.load(marker.icon.assetName);
  Uint8List resizedData = Uint8List.view(fileData.buffer);

  final img = Image.decodeImage(resizedData);
  final resized = Image.copyResize(
    img,
    width: marker.icon.width,
    height: marker.icon.width,
  );
  resizedData = Image.encodePng(resized);
  return resizedData;
}
