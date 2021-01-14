import 'package:atlas/atlas.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class FakePlatformHereMaps {
  FakePlatformHereMaps(int id) {
    channel = MethodChannel(
      'com.here.flutter/here_sdk_$id',
      const StandardMethodCodec(),
    );
    channel.setMockMethodCallHandler(onMethodCall);
  }

  MethodChannel channel;
  CameraPosition cameraPosition;

  Future<dynamic> onMethodCall(MethodCall call) {
    switch (call.method) {
      case 'initialize':
        return Future<void>.sync(() {});
      default:
        return Future<void>.sync(() {});
    }
  }
}

class FakePlatformViewsController {
  FakePlatformHereMaps lastCreatedView;

  Future<dynamic> fakePlatformViewsMethodHandler(MethodCall call) {
    switch (call.method) {
      case 'create':
        final Map<dynamic, dynamic> args = call.arguments;
        lastCreatedView = FakePlatformHereMaps(args['id']);
        return Future<int>.sync(() => 1);
      default:
        return Future<void>.sync(() {});
    }
  }

  void reset() {
    lastCreatedView = null;
  }
}
