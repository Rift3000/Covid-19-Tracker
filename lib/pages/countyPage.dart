import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:covid19tracker/pages/search.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData;

  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: Search(countryData));
            },
          )
        ],
        title: Text('Country Stats'),
      ),
      body: countryData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF58439A)),
                  height: 130,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 200,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Image.network(
                              countryData[index]['countryInfo']['flag'],
                              height: 80,
                              width: 130,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  countryData[index]['country'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'CONFIRMED:' +
                                  countryData[index]['cases']
                                      .toString()
                                      .replaceAllMapped(reg, mathFunc),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'ACTIVE:' +
                                  countryData[index]['active']
                                      .toString()
                                      .replaceAllMapped(reg, mathFunc),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'RECOVERED:' +
                                  countryData[index]['recovered']
                                      .toString()
                                      .replaceAllMapped(reg, mathFunc),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'DEATHS:' +
                                  countryData[index]['deaths']
                                      .toString()
                                      .replaceAllMapped(reg, mathFunc),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                );
              },
              itemCount: countryData == null ? 0 : countryData.length,
            ),
    );
  }
}
