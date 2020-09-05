import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppData {
  int cases;
  int recovered;
  int death;

  AppData({
    this.cases,
    this.recovered,
    this.death,
  });
}

class Statics extends StatefulWidget {
  @override
  _StaticsState createState() => _StaticsState();
}

class _StaticsState extends State<Statics> {
  Future data;

  @override
  void initState() {
    super.initState();
    data = http
        .get("https://elegant-jepsen-938066.netlify.app/data.json")
        .then<AppData>((value) {
      final data = jsonDecode(value.body);
      return AppData(
        cases: data["cases"],
        recovered: data["recovered"],
        death: data["death"],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return FutureBuilder<AppData>(
        future: data,
        builder: (ctx, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Cases",
                        style: theme.headline5.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "123",
                        style: theme.headline5,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Recovered",
                        style: theme.headline5.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "123",
                        style: theme.headline5,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Deaths",
                        style: theme.headline5.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "123",
                        style: theme.headline5,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
