// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:loggy/loggy.dart';

class LoginPage extends StatelessWidget with UiLoggy {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login App'),
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
                    logDebug("message   1111");
                    AutoRouter.of(context).replaceNamed("/counter");
                  },
                  child: Icon(Icons.add),
                  tooltip: 'Increment',
                ),
                SizedBox(width: 20.0),
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {},
                  child: Icon(Icons.remove),
                  tooltip: 'Decrement',
                ),
              ],
            )
          ],
        )));
  }
}
