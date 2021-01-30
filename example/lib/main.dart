import 'package:atlas/atlas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:here_maps_atlas/here_atlas.dart';
import 'package:here_maps_atlas_example/utils/constants.dart';
import 'package:here_maps_atlas_example/widgets/settings_side_menu.dart';

import 'bloc/configuration_bloc.dart';

void main() {
  AtlasProvider.instance = HereAtlas();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (BuildContext context) => ConfigurationBloc(),
        child: HereAtlasSample(key: UniqueKey()),
      ),
    );
  }
}

class HereAtlasSample extends StatelessWidget {
  const HereAtlasSample({@required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationBloc, ConfigurationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Flutter Here Maps Provider'),
          ),
          drawer: SettingsSideMenu(),
          body: BlocBuilder<ConfigurationBloc, ConfigurationState>(
            builder: (context, state) {
              return Atlas(
                key: UniqueKey(),
                initialCameraPosition: CameraPosition(
                  target: getCityCoordinates(state.city),
                  zoom: 13,
                ),
              );
            },
          ),
        );
      },
    );
  }

  LatLng getCityCoordinates(City city) {
    switch (city) {
      case City.Lisbon:
        return LisbonCoordinates;
        break;
      case City.SaoPaulo:
        return SaoPauloCoordinates;
        break;
      case City.Tokyo:
        return TokyoCoordinates;
        break;
      default:
        return LisbonCoordinates;
        break;
    }
  }
}
