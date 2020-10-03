import 'dart:convert';
import 'package:covid19tracker/pages/countyPage.dart';
import 'package:covid19tracker/panels/mosteffectedcountries.dart';
import 'package:covid19tracker/panels/show_news.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'datasorce.dart';
import 'panels/worldwidepanel.dart';
import 'package:http/http.dart' as http;
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'panels/myth_panel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
    print('fetchData called');
  }

  @override
  void initState() {
    fetchData();
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Theme.of(context).brightness == Brightness.light
                  ? Icons.lightbulb_outline
                  : Icons.highlight),
              onPressed: () {
                DynamicTheme.of(context).setBrightness(
                    Theme.of(context).brightness == Brightness.light
                        ? Brightness.dark
                        : Brightness.light);
              })
        ],
        centerTitle: false,
        title: Text(
          'COVID-19 TRACKER',
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: <Widget>[
          RefreshIndicator(
            onRefresh: fetchData,
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.deepPurpleAccent,
                  ),
                  child: Text(
                    "WORLDWIDE",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 4.0),
                  ),
                ),
                worldData == null
                    ? Container(
                        height: 200.0,
                        child: Center(child: CircularProgressIndicator()))
                    : WorldwidePanel(
                        worldData: worldData,
                      ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.deepPurpleAccent,
                  ),
                  child: Text(
                    "TOP TEN COUNTRIES",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                countryData == null
                    ? Container(
                        height: 170.0,
                        child: Center(child: CircularProgressIndicator()))
                    : MostAffectedPanel(
                        countryData: countryData,
                      ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  margin: EdgeInsets.only(left: 120.0),
                  child: RaisedButton(
                    elevation: 20.0,
                    padding: EdgeInsets.all(20.0),
                    color: Colors.lightBlueAccent,
                    splashColor: Colors.blueAccent,
                    hoverElevation: 10.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    onPressed: () {
                      final snackBar = SnackBar(
                        content: Row(
                          children: [
                            (Text(
                              "Remember to wear your  ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            )),
                            Icon(
                              Icons.masks,
                              size: 35.0,
                            ),
                          ],
                        ),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      _scaffoldKey.currentState.showSnackBar(snackBar);
                    },
                    child: Text(
                      "Touch for a Surprise",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )),
          ),
          CountryPage(),
          NewsLine(),
          MythBusters(),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: primaryBlack,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Home'), icon: Icon(LineAwesomeIcons.home)),
          BottomNavyBarItem(
            title: Text('Countries'),
            icon: Icon(LineAwesomeIcons.globe_with_europe_shown),
          ),
          BottomNavyBarItem(
              title: Text('News'), icon: Icon(LineAwesomeIcons.newspaper)),
          BottomNavyBarItem(
              title: Text('FAQS'), icon: Icon(LineAwesomeIcons.info)),
        ],
      ),
    );
  }
}
