import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.green,
          buttonColor: Colors.green,
          primarySwatch: Colors.green,
          backgroundColor: Colors.green,
          accentColor: Colors.green),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  var money;
  var banknotes;

  final banknotesViews = [
    "1",
    "5",
    "10",
    "20",
    "50",
    "100",
    "500",
    "1000",
    "5000",
  ];

  build(context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Center(
            child: ListView(
          padding: EdgeInsets.all(16.0),
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text("Wrike Bankomat", style: TextStyle(fontSize: 24)),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: CupertinoTextField(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.green)),
                placeholder: "input money",
                onChanged: (text) {
                  money = int.parse(text);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: CupertinoTextField(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.green)),
                placeholder: "Input banknotes splited by ,",
                onChanged: (text) {
                  banknotes = text.split(",").map((banknote) {
                    return int.parse(banknote).abs();
                  }).toList();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: RaisedButton(
                  child: Text("Give ma money!",
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    if (banknotes != null && money != null && money > 0) {
                      bag(banknotes: banknotes, money: money, context: context);
                    }
                  }),
            ),
          ],
        )));
  }

  bag({List<int> banknotes, money, context}) {
    try {
      banknotes.toSet();
      banknotes.sort((a, b) => b - a);
      final checksum = banknotes.reduce((value, element) => value + element);

      final counterMap = {};

      if (checksum <= money) {
        banknotes.forEach((banknote) {
          counterMap[banknote] = 1;
        });

        money -= checksum;

        for (int i = 0; i < banknotes.length; i++) {
          var counter = 0;
          while (money >= banknotes[i]) {
            money -= banknotes[i];
            counter++;
          }
          counterMap[banknotes[i]] += counter;
        }
      }
      if (context != null) _showDialog(context, counterMap);

      ///for test
      return counterMap;
    } catch (e) {
      _showDialog(context, "error");
    }
  }

  _showDialog(context, text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Wrike Bankomat"),
          content: Text(
              "You have got: $text".replaceAll("{", "").replaceAll("}", "")),
          actions: [
            FlatButton(
              child: Text("Thanks!"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
