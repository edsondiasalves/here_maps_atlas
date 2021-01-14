import 'dart:typed_data';

import 'package:atlas/atlas.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class FakePlatformHereMaps {
  FakePlatformHereMaps(int id, Map<dynamic, dynamic> params) {
    cameraPosition = params['initialCameraPosition'];
    channel = MethodChannel(
      'plugins/here_sdk',
      const StandardMethodCodec(),
    );
    channel.setMockMethodCallHandler(onMethodCall);
  }

  MethodChannel channel;

  CameraPosition cameraPosition;

  Future<dynamic> onMethodCall(MethodCall call) {
    switch (call.method) {
      case 'camera#move':
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
        final Map<dynamic, dynamic> params = _decodeParams(args['params']);
        lastCreatedView = FakePlatformHereMaps(
          args['id'],
          params,
        );
        return Future<int>.sync(() => 1);
      default:
        return Future<void>.sync(() {});
    }
  }

  void reset() {
    lastCreatedView = null;
  }
}

Map<dynamic, dynamic> _decodeParams(Uint8List paramsMessage) {
  final ByteBuffer buffer = paramsMessage.buffer;
  final ByteData messageBytes = buffer.asByteData(
    paramsMessage.offsetInBytes,
    paramsMessage.lengthInBytes,
  );
  return const StandardMessageCodec().decodeMessage(messageBytes);
}
