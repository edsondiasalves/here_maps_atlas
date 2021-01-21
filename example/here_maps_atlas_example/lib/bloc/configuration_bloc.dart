import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:here_maps_atlas_example/utils/constants.dart';
import 'package:meta/meta.dart';

part 'configuration_event.dart';
part 'configuration_state.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  ConfigurationBloc() : super(ConfigurationInitial());

  @override
  Stream<ConfigurationState> mapEventToState(
    ConfigurationEvent event,
  ) async* {
    if (event is ChangeCityStarted) {
      yield CityChangedState(city: event.city);
    }
  }
}