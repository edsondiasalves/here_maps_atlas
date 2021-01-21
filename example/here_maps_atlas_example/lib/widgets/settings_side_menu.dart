import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:here_maps_atlas_example/bloc/configuration_bloc.dart';
import 'package:here_maps_atlas_example/utils/constants.dart';

class SettingsSideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 320,
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Here Maps Settings'),
            onTap: () => {},
          ),
          Container(
            margin: EdgeInsets.only(
              left: 15,
            ),
            child: Text('City'),
          ),
          BlocBuilder<ConfigurationBloc, ConfigurationState>(
            builder: (context, state) {
              return Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Radio(
                          value: City.Lisbon,
                          groupValue: state.city,
                          onChanged: (value) {
                            BlocProvider.of<ConfigurationBloc>(context)
                                .add(ChangeCityStarted(city: value));
                          },
                        ),
                        Text('Lisbon'),
                        Radio(
                          value: City.SaoPaulo,
                          groupValue: state.city,
                          onChanged: (value) {
                            BlocProvider.of<ConfigurationBloc>(context)
                                .add(ChangeCityStarted(city: value));
                          },
                        ),
                        Text('São Paulo'),
                        Radio(
                          value: City.Tokyo,
                          groupValue: state.city,
                          onChanged: (value) {
                            BlocProvider.of<ConfigurationBloc>(context)
                                .add(ChangeCityStarted(city: value));
                          },
                        ),
                        Text('Tokyo'),
                      ],
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
