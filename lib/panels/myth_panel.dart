import 'package:flutter/material.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/rendering.dart';
import 'package:covid19tracker/datasorce.dart';

class MythBusters extends StatefulWidget {
  @override
  _MythBustersState createState() => _MythBustersState();
}

class _MythBustersState extends State<MythBusters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: DataSource.questionAnswers.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: ExpansionCard(
                borderRadius: 25,
                background: Image.asset(
                  DataSource.questionAnswers[index]['photo'],
                  fit: BoxFit.cover,
                ),
                title: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        DataSource.questionAnswers[index]['question'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 7),
                    child: Text(DataSource.questionAnswers[index]['answer'],
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            );
          }),
    );
  }
}
