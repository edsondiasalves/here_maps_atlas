part of 'configuration_bloc.dart';

@immutable
abstract class ConfigurationEvent {}

class ChangeCityStarted extends ConfigurationEvent {
  final City city;

  ChangeCityStarted({this.city});
}
