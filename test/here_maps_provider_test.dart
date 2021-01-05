import 'package:atlas/atlas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:here_maps_atlas/src/here_atlas.dart';
import 'package:here_sdk/core.dart';

main() {
  setUpAll(() async {
    SdkContext.init(IsolateOrigin.main);
  });

  group('Here Atlas Provider', () {
    HereAtlas hereAtlas;
    CameraPosition initialCameraPosition;

    setUp(() {
      hereAtlas = HereAtlas();
      AtlasProvider.instance = hereAtlas;
      initialCameraPosition = CameraPosition(
        target: LatLng(
          latitude: 41.8781,
          longitude: -87.6298,
        ),
        zoom: 12,
      );
    });

    testWidgets('should return correct initial camera position', (
      WidgetTester tester,
    ) async {
      final expectedPosition = LatLng(
        latitude: initialCameraPosition.target.latitude,
        longitude: initialCameraPosition.target.longitude,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Atlas(initialCameraPosition: initialCameraPosition),
        ),
      );
      await tester.pumpAndSettle();

      //expect(expectedPosition, ???);
    });
  });
}
