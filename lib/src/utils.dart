import 'package:atlas/atlas.dart' as Atlas;
import 'package:here_sdk/core.dart' as HereMaps;

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
