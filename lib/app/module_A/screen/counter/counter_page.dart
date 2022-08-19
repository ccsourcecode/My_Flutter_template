// ignore_for_file: prefer_const_constructors
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../../module_A/bloc/theme/theme_bloc.dart';

import '../../model/filmModel.dart';
import '../../service/weatherAPI_provider.dart';
import '../login/components/switch_mode_button.dart';
import '../../../module_A/service/weatherAPI_service.dart';

class CounterPage extends StatelessWidget {
final _weatherAPIservice = WeatherAPIservice();


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Counter App'),
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '0',
                style: TextStyle(fontSize: 80.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      log("counter pagee onPressed fetchFilm");
                      _weatherAPIservice.fetchFilm();
                      AutoRouter.of(context).replaceNamed("/login");
                    },
                    child: Icon(Icons.add),
                    tooltip: 'Increment',
                    backgroundColor: state.themeData.shadowColor,
                  ),
                  SizedBox(width: 20.0),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () {},
                    child: Icon(Icons.remove),
                    tooltip: 'Decrement',
                    backgroundColor: state.themeData.backgroundColor,
                  ),
                  SwitchModeButton(),
                ],
              )
            ],
          )));
    });
  }
}
