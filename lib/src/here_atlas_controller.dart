import 'package:atlas/atlas.dart';
import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart' as HereMaps;

class HereAtlasController implements AtlasController {
  HereMaps.HereMapController _controller;

  HereAtlasController({
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
    const double distanceToEarthInMeters = 8000;
    final geoCoordinate = _cameraPositionToGeoCoordinates(cameraPosition);

    _controller.camera?.lookAtPointWithDistance(
      geoCoordinate,
      distanceToEarthInMeters,
    );

    return null;
  }

  @override
  Future<void> updateBounds(LatLngBounds bounds, double padding) {
    throw UnimplementedError();
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

  GeoCoordinates _cameraPositionToGeoCoordinates(
      CameraPosition cameraPosition) {
    final geoCoordinates = GeoCoordinates(
      cameraPosition.target.latitude,
      cameraPosition.target.longitude,
    );
    print(geoCoordinates.toString());
    return geoCoordinates;
  }

  void _loadSceneCallback(HereMaps.MapError error) {
    if (error != null) {
      print('Map scene not loaded. MapError: ${error.toString()}');
      return;
    }
  }
}
