import 'package:algolia_search_flutter/hospital.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalInfo extends StatelessWidget {
  static const pathName = "/hospital";

  @override
  Widget build(BuildContext context) {
    final Hospital args = ModalRoute.of(context).settings.arguments;
    final theme = Theme.of(context).textTheme;

    Widget floatingActionButton;

    if (args.contactNumber.length > 0) {
      floatingActionButton = FloatingActionButton.extended(
        onPressed: () {
          launch("tel:+91${args.contactNumber[0]}");
        },
        icon: Icon(Icons.phone),
        label: Text("Enquiry"),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      floatingActionButton: floatingActionButton,
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Available Beds",
                        textAlign: TextAlign.center,
                        style: theme.headline6,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Normal Beds",
                            style: theme.headline5.copyWith(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            args.availableBedsNormal.toString(),
                            style: theme.headline5,
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "ICU Beds",
                            style: theme.headline5.copyWith(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            args.availableBedsICU.toString(),
                            style: theme.headline5,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ...args.contactNumber.map(
            (e) => ListTile(
              leading: Icon(
                Icons.phone,
              ),
              title: Text(
                e.toString(),
              ),
              onTap: () {
                launch("tel:+91${e.toString()}");
              },
            ),
          ),
          if (args.url != null)
            ListTile(
              leading: Icon(
                Icons.web,
              ),
              title: Text(
                "Website",
              ),
              onTap: () {
                launch(args.url);
              },
            ),
          if (args.longitude != null && args.latitude != null)
            ListTile(
              leading: Icon(
                Icons.map,
              ),
              title: Text(
                "View on Maps",
              ),
              onTap: () {
                launch(
                    "https://www.google.com/maps/search/?api=1&query=${args.latitude},${args.longitude}");
              },
            ),
        ],
      ),
    );
  }
}
