import 'package:atlas/atlas.dart';
import 'package:flutter/material.dart';

import 'here_maps_provider.dart';

class HereAtlas extends Provider {
  @override
  Widget build({
    CameraPosition initialCameraPosition,
    Set<Marker> markers,
    Set<Circle> circles,
    Set<Polygon> polygons,
    Set<Polyline> polylines,
    onTap,
    onPoiTap,
    onLongPress,
    onMapCreated,
    onCameraPositionChanged,
    onLocationChanged,
    onPan,
    bool showMyLocation,
    bool showMyLocationButton,
    bool followMyLocation,
    MapType mapType,
    bool showTraffic,
    MapLanguage mapLanguage,
  }) {
    return HereMapsProvider(
      initialCameraPosition: initialCameraPosition,
      onMapCreated: onMapCreated,
    );
  }
}
