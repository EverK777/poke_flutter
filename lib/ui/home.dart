import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:poke_flutter/ui/regions.dart';
import 'package:poke_flutter/ui/teams.dart';


import 'friends.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Key keyRegions = PageStorageKey('keyRegions');
  final Key keyTeam = PageStorageKey('keyTeams');
  final Key keyFriends = PageStorageKey('keyFriends');

  int currentTab = 0;

  Regions regions;

  Teams teams;

  Friends friends;

  final titles = ['Regions', 'Teams', 'Friends'];
  final PageStorageBucket bucket = PageStorageBucket();
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    regions = Regions(
      key: keyRegions,
    );
    teams = Teams(key: keyTeam);
    friends = Friends(key: keyFriends);
    pages = [regions, teams, friends];
    currentPage = regions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _bottomMenuWidget = CurvedNavigationBar(
      index: currentTab,
      onTap: (index) {
        setState(() {
          currentTab = index;
          currentPage = pages[index];
        });
      },
      backgroundColor: Colors.white,
      color: Colors.lightBlue,
      items: <Widget>[
        Icon(
          Icons.location_on,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.group_work,
          size: 30,
          color: Colors.white,
        ),
        Icon(Icons.group, size: 30, color: Colors.white),
      ],
    );

    return Scaffold(
        bottomNavigationBar: _bottomMenuWidget,
        backgroundColor: Colors.white,
        body: Column(
            children: <Widget>[
              Container(
                  color: Colors.lightBlue,
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0,
                              (MediaQuery.of(context).padding.top) + 25, 0, 10),
                          child: Image.asset(
                            'assets/images/main_logo.png',
                            scale: 7,
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              titles[currentTab],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
              PageStorage(
                child: currentPage,
                bucket: bucket,
              )
            ],
        ));
  }
}
