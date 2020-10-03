import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:covid19tracker/datasorce.dart';

class Search extends SearchDelegate {
  final List countryList;

  Search(this.countryList);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        primaryColor: primaryBlack,
        brightness: DynamicTheme.of(context).brightness);
  }

  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(context);
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where((element) =>
                element['country'].toString().toLowerCase().startsWith(query))
            .toList();

    return ListView.builder(
        itemCount: suggestionList.length,
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
                        suggestionList[index]['countryInfo']['flag'],
                        height: 80,
                        width: 130,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            suggestionList[index]['country'],
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
                            suggestionList[index]['cases']
                                .toString()
                                .replaceAllMapped(reg, mathFunc),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        'ACTIVE:' +
                            suggestionList[index]['active']
                                .toString()
                                .replaceAllMapped(reg, mathFunc),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        'RECOVERED:' +
                            suggestionList[index]['recovered']
                                .toString()
                                .replaceAllMapped(reg, mathFunc),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        'DEATHS:' +
                            suggestionList[index]['deaths']
                                .toString()
                                .replaceAllMapped(reg, mathFunc),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          );
        });
  }
}
