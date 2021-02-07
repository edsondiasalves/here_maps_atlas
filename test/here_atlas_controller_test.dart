import 'package:atlas/atlas.dart' as atlas;
import 'package:flutter_test/flutter_test.dart';
import 'package:here_maps_atlas/src/here_atlas_controller.dart';
import 'package:here_sdk/mapview.dart';
import 'package:mockito/mockito.dart';

class MockHereMapsController extends Mock implements HereMapController {}

main() {
  group('HereAtlasController', () {
    HereMapController hereMapsController;
    HereAtlasController hereAtlasController;

    setUp(() {
      hereMapsController = MockHereMapsController();
      hereAtlasController = HereAtlasController(
        controller: hereMapsController,
      );
    });

    test('throws error when HereMapsController is null', () {
      try {
        HereAtlasController(controller: null);
      } catch (ex) {
        expect(ex, isAssertionError);
      }
    });

    test('calls HereMapsController moveCamera method', () async {
      final cameraPosition = atlas.CameraPosition(
        target: atlas.LatLng(latitude: 1.0, longitude: 2.0),
        zoom: 3.0,
      );

      await hereAtlasController.moveCamera(cameraPosition);
      verify(
        hereMapsController.camera.lookAtPointWithDistance(
          any,
          any,
        ),
      ).called(1);
    });
  });
}
