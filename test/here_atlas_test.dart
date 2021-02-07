import 'package:atlas/atlas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:here_maps_atlas/src/here_atlas.dart';

import 'fake_maps_controller.dart';

main() {
  final FakePlatformViewsController fakePlatformViewsController =
      FakePlatformViewsController();

  setUpAll(() {
    SystemChannels.platform_views.setMockMethodCallHandler(
      fakePlatformViewsController.fakePlatformViewsMethodHandler,
    );
  });

  group('Here Atlas', () {
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
      fakePlatformViewsController.reset();
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

      final FakePlatformHereMaps platformHereMaps =
          fakePlatformViewsController.lastCreatedView;

      expect(expectedPosition, platformHereMaps.cameraPosition?.target);
      expect(12.0, platformHereMaps.cameraPosition?.zoom);
    });
  });
}
