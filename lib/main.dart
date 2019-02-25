import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  build(context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  var money;
  var banknotes;

  build(context) {

    return Scaffold(
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text("Wrike Bankomat", style: TextStyle(fontSize: 16),),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: CupertinoTextField(
                placeholder: "input money",
                onChanged: (text){
                  money = int.parse(text);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: CupertinoTextField(
                placeholder: "input banknotes splited by ,",
                onChanged: (text){
                  banknotes = text.split(",").map((banknote){
                    return int.parse(banknote);
                  }).toList();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: RaisedButton(
                  child: Text("Give ma money!"),
                  onPressed: (){
                    if(banknotes != null && money!=null && money > 0)
                      bag(banknotes : banknotes, money : money, context : context);
                  }),
            ),
          ],
        )
      )
    );
  }

  bag({List banknotes, money, context}){
    banknotes.sort((a,b) => b.compareTo(a));
    final counterMass = {};
    for(int i in banknotes){
      var counter = 0;
      do{
        money -= i;
        if(money < 0){
          money += i;
          break;
        }
        counter++;
        counterMass[i] = counter;
      }while(money > i);
    }
    if(context != null)
      _showDialog(context, counterMass);
    return counterMass;
  }

  void _showDialog(context, text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Wrike Bankomat"),
          content: Text("You have got: $text".replaceAll("{", "").replaceAll("}", "")),
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
