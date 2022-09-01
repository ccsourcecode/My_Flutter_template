// ignore_for_file: prefer_const_constructors
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:my_template/features/module_A/bloc/theme/theme_bloc.dart';
import 'package:my_template/features/module_A/screen/login/components/switch_mode_button.dart';
import 'package:my_template/features/module_A/service/weatherAPI_provider.dart';

class CounterPage extends StatelessWidget {
  void fetch() async {
    String service = "";
    var params = {};
    var data = await WeatherAPIProvider().fetchFilm(service);

    // var wx = data.director;
    debugPrint("Fetched");
  }

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
                      debugPrint("XSSS1111 fetch");
                      fetch();
                      AutoRouter.of(context).replaceNamed("/login");
                    },
                    tooltip: 'Increment',
                    backgroundColor: state.themeData.shadowColor,
                    child: Icon(Icons.add),
                  ),
                  SizedBox(width: 20.0),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () {},
                    tooltip: 'Decrement',
                    backgroundColor: state.themeData.backgroundColor,
                    child: Icon(Icons.remove),
                  ),
                  SwitchModeButton(),
                ],
              )
            ],
          )));
    });
  }
}
