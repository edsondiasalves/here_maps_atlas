import 'package:atlas/atlas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:here_maps_atlas/here_atlas.dart';
import 'package:here_maps_atlas_example/widgets/settings_side_menu.dart';

import 'bloc/configuration_bloc.dart';
import 'utils/extensions.dart';

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
    AtlasController _atlasController;

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Here Maps Provider'),
      ),
      drawer: SettingsSideMenu(),
      body: BlocListener<ConfigurationBloc, ConfigurationState>(
        listener: (context, state) {
          if (state is CameraChangedState) {
            _atlasController.moveCamera(
              state.currentPosition.toCameraPosition(),
            );
          }
        },
        child: BlocBuilder<ConfigurationBloc, ConfigurationState>(
          buildWhen: (previous, current) => current is InitialPositionState,
          builder: (context, state) {
            return Atlas(
              key: UniqueKey(),
              initialCameraPosition: state.initialPosition.toCameraPosition(),
              onMapCreated: (AtlasController atlasController) {
                _atlasController = atlasController;
              },
            );
          },
        ),
      ),
    );
  }
}
