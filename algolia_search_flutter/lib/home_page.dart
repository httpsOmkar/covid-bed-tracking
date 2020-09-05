import 'package:algolia_search_flutter/HospitalInfo.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'algolia_service.dart';
import 'hospital.dart';
import 'widgets/statics.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 12,
          ),
          Image.asset("assets/satejpatil.jpg"),
          SizedBox(
            height: 12,
          ),
          Text(
            "Covid bed availability by Satej Patil",
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "Kolhapur Statistics",
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 12,
          ),
          Statics(),
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[],
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("WHO"),
              trailing: Icon(Icons.open_in_new),
              onTap: () {
                launch(
                    "https://www.who.int/emergencies/diseases/novel-coronavirus-2019");
              },
            ),
            ListTile(
              title: Text("Satej Patil Website"),
              trailing: Icon(Icons.open_in_new),
              onTap: () {
                launch("https://www.satejpatil.com");
              },
            ),
            ListTile(
              title: Text("Kolhapur covid dashboard"),
              trailing: Icon(Icons.open_in_new),
              onTap: () {
                launch(
                    "https://public.tableau.com/views/CollectorOfficeKolhapur/DistrictMap?:embed=y&:toolbar=n&:embed_code_version=3&:loadOrderID=0&:display_count=y&:tabs=y&:origin=viz_share_link");
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                _scafoldKey.currentState.openDrawer();
              },
              icon: Icon(
                Icons.menu,
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showSearch(context: context, delegate: DataSearch());
        },
        label: Text(
          "Search",
        ),
        icon: Icon(Icons.search),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final algoliaService = AlgoliaService.instance;

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the app bar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Hospital>>(
      future: algoliaService.performMovieQuery(text: query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data.map((f) {
            return ListTile(
              title: Text(f.title),
              subtitle: Text(f.location),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  HospitalInfo.pathName,
                  arguments: f,
                );
              },
            );
          }).toList();

          return ListView(children: movies);
        } else if (snapshot.hasError) {
          return Center(
            child: Text("${snapshot.error.toString()}"),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
