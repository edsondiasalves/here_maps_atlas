import 'package:atlas/atlas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:here_maps_atlas/here_atlas.dart';
import 'package:here_maps_atlas_example/utils/constants.dart';
import 'package:here_maps_atlas_example/widgets/settings_side_menu.dart';

import 'bloc/configuration_bloc.dart';

void main() {
  AtlasProvider.instance = HereAtlas();
  runApp(
    BlocProvider(
      create: (BuildContext context) => ConfigurationBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Here Maps Provider'),
        ),
        drawer: SettingsSideMenu(),
        body: BlocBuilder<ConfigurationBloc, ConfigurationState>(
          builder: (context, state) {
            print(state.city.toString());
            return Atlas(
              initialCameraPosition: getCityLatitude(state.city),
            );
          },
        ),
      ),
    );
  }

  CameraPosition getCityLatitude(City city) {
    switch (city) {
      case City.Lisbon:
        return CameraPosition(
          target: LisbonLatitude,
        );
        break;
      case City.SaoPaulo:
        return CameraPosition(
          target: SaoPauloLatitude,
        );
        break;
      case City.Tokyo:
        return CameraPosition(
          target: TokyoLatitude,
        );
        break;
      default:
        return CameraPosition(
          target: LisbonLatitude,
        );
        break;
    }
  }
}
