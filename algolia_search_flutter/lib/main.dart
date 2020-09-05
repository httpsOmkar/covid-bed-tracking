import 'package:algolia_search_flutter/HospitalInfo.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid BED Search',
      routes: {
        HomePage.routeName: (context) => HomePage(),
        HospitalInfo.pathName: (context) => HospitalInfo(),
      },
      initialRoute: HomePage.routeName,
    );
  }
}
