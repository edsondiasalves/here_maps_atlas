import 'package:atlas/atlas.dart' as Atlas;
import 'package:flutter/material.dart';
import 'package:here_maps_atlas/src/here_atlas_controller.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';

class HereMapsProvider extends StatefulWidget {
  final Atlas.CameraPosition initialCameraPosition;
  final Atlas.ArgumentCallback<Atlas.AtlasController> onMapCreated;

  HereMapsProvider({this.initialCameraPosition, this.onMapCreated});

  @override
  _HereMapsProviderState createState() => _HereMapsProviderState();
}

class _HereMapsProviderState extends State<HereMapsProvider> {
  Atlas.CameraPosition get initialCameraPosition =>
      widget.initialCameraPosition;

  Atlas.ArgumentCallback<Atlas.AtlasController> get onMapCreated =>
      widget.onMapCreated;

  @override
  void initState() {
    super.initState();
    SdkContext.init(IsolateOrigin.main);
  }

  @override
  Widget build(BuildContext context) {
    return HereMap(
      onMapCreated: _onMapCreated,
    );
  }

  void _onMapCreated(HereMapController hereMapController) {
    HereAtlasController hereAtlasController = HereAtlasController(
      controller: hereMapController,
    );

    onMapCreated?.call(hereAtlasController);
    hereAtlasController.moveCamera(widget.initialCameraPosition);
  }
}
