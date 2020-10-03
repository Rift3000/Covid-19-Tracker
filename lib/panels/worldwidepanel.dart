import 'package:flutter/material.dart';

class WorldwidePanel extends StatelessWidget {
  final Map worldData;

  const WorldwidePanel({Key key, this.worldData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';

    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1),
        children: <Widget>[
          StatusPanel(
            title: 'CONFIRMED',
            panelColor: Colors.orangeAccent,
            textColor: Colors.white,
            count:
                worldData['cases'].toString().replaceAllMapped(reg, mathFunc),
          ),
          StatusPanel(
            title: 'ACTIVE',
            panelColor: Colors.blue,
            textColor: Colors.white,
            count:
                worldData['active'].toString().replaceAllMapped(reg, mathFunc),
          ),
          StatusPanel(
            title: 'RECOVERED',
            panelColor: Colors.green,
            textColor: Colors.white,
            count: worldData['recovered']
                .toString()
                .replaceAllMapped(reg, mathFunc),
          ),
          StatusPanel(
            title: 'DEATHS',
            panelColor: Colors.red,
            textColor: Colors.white,
            count:
                worldData['deaths'].toString().replaceAllMapped(reg, mathFunc),
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel(
      {Key key, this.panelColor, this.textColor, this.title, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(10),
      height: 50.0,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: panelColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: textColor),
          ),
          Text(
            count,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
          )
        ],
      ),
    );
  }
}
