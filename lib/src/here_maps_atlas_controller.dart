import 'package:atlas/atlas.dart';
import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart' as HereMaps;

import 'utils.dart';

class HereMapsAtlasController implements AtlasController {
  HereMaps.HereMapController _controller;

  HereMapsAtlasController({
    @required HereMaps.HereMapController controller,
  }) : assert(controller != null) {
    _controller = controller;
    _controller.mapScene?.loadSceneForMapScheme(
      HereMaps.MapScheme.normalDay,
      _loadSceneCallback,
    );
  }

  @override
  void changeUserLocationIcon(String asset) {}

  @override
  Future<CameraPosition> getCameraPosition() {
    throw UnimplementedError();
  }

  @override
  Future<LatLng> getLatLng(ScreenCoordinates screenCoordinates) {
    throw UnimplementedError();
  }

  @override
  Future<ScreenCoordinates> getScreenCoordinate(LatLng latLng) {
    throw UnimplementedError();
  }

  @override
  Future<LatLngBounds> getVisibleArea() {
    throw UnimplementedError();
  }

  @override
  Future<void> moveCamera(CameraPosition cameraPosition) {
    const distanceToZoomMagicNumber = 1500;
    double distanceToEarthInMeters = 8000;

    if (cameraPosition.zoom > 0) {
      distanceToEarthInMeters = distanceToZoomMagicNumber * cameraPosition.zoom;
    }

    _controller.camera?.lookAtPointWithDistance(
      cameraPosition.toGeoCoordinates(),
      distanceToEarthInMeters,
    );

    return null;
  }

  @override
  Future<void> updateBounds(LatLngBounds bounds, double padding) {
    final geoBox = GeoBox(
      bounds.southwest.toHereMapsGeoCoordinate(),
      bounds.northeast.toHereMapsGeoCoordinate(),
    );
    _controller.camera.lookAtAreaWithOrientation(
      geoBox,
      HereMaps.MapCameraOrientationUpdate(10, 20),
    );

    return null;
  }

  @override
  Future<void> updateBoundsWithPaddingToAllSides(
    LatLngBounds bounds,
    double north,
    double east,
    double south,
    double west,
  ) {
    throw UnimplementedError();
  }

  void _loadSceneCallback(HereMaps.MapError error) {
    if (error != null) {
      print('Map scene not loaded. MapError: ${error.toString()}');
      return;
    }
  }
}
