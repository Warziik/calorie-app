import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  bool gender = true; // true = Homme, false = Femme
  double age;
  Color interfaceColor = Colors.blue;
  List<String> sportActivityList = ['Faible', 'Modere', 'Forte'];
  int sportActivity;
  double weight;
  double height = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Calorie app'),
            backgroundColor: interfaceColor),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(20),
                child: Text(
                    'Remplissez tous les champs pour obtenir votre besoin journalier en calories.',
                    style: TextStyle(color: Colors.grey[900], fontSize: 16),
                    textAlign: TextAlign.center)),
            Card(
              elevation: 10,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('Femme',
                            style: TextStyle(color: Colors.pink, fontSize: 16)),
                        Switch(
                            value: gender,
                            activeColor: interfaceColor,
                            onChanged: (bool value) {
                              setState(() {
                                interfaceColor =
                                    value ? Colors.blue : Colors.pink;
                                gender = value;
                              });
                            }),
                        Text('Homme',
                            style: TextStyle(color: Colors.blue, fontSize: 16))
                      ],
                    ),
                    Center(
                        child: RaisedButton(
                            child: Text(age != null
                                ? 'Vous avez ${age.toInt()}ans'
                                : 'Indiquez votre date de naissance'),
                            color: interfaceColor,
                            textColor: Colors.white,
                            onPressed: showAgeWindow)),
                    Text(
                        height != 100
                            ? "Votre taille est de ${height.toInt()}cm"
                            : "Veuillez indiquer votre taille",
                        style: TextStyle(color: interfaceColor, fontSize: 16)),
                    Slider(
                        value: height,
                        activeColor: interfaceColor,
                        min: 100,
                        max: 230,
                        onChanged: (double d) {
                          setState(() => height = d);
                        }),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        setState(() => weight = double.tryParse(value));
                      },
                      decoration: InputDecoration(
                          focusColor: interfaceColor,
                          labelText: 'Indiquez votre poids en kilos'),
                    ),
                    Center(
                      child: Text('Quelle est votre activité sportive ?',
                          style:
                              TextStyle(color: interfaceColor, fontSize: 16)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Radio(
                                value: 1,
                                groupValue: sportActivity,
                                activeColor: interfaceColor,
                                onChanged: (int i) {
                                  setState(() => sportActivity = i);
                                }),
                            Text(sportActivityList[0],
                                style: TextStyle(fontSize: 16))
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Radio(
                                value: 2,
                                groupValue: sportActivity,
                                activeColor: interfaceColor,
                                onChanged: (int i) {
                                  setState(() => sportActivity = i);
                                }),
                            Text(sportActivityList[1],
                                style: TextStyle(fontSize: 16))
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Radio(
                                value: 3,
                                groupValue: sportActivity,
                                activeColor: interfaceColor,
                                onChanged: (int i) {
                                  setState(() => sportActivity = i);
                                }),
                            Text(sportActivityList[2],
                                style: TextStyle(fontSize: 16))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Center(
                child: Container(
                    padding: EdgeInsets.all(30),
                    child: RaisedButton(
                        child: Text('Calculer'),
                        color: interfaceColor,
                        textColor: Colors.white,
                        onPressed: calculCalorie)))
          ],
        )),
        backgroundColor: Colors.grey[200]);
  }

  Future showAgeWindow() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.year);

    setState(() => age = (DateTime.now().difference(date).inDays / 365));
  }

  Future calculCalorie() async {
    double sportActivityMultiplicator;
    switch (sportActivity) {
      case 1:
        sportActivityMultiplicator = 1.2;
        break;
      case 2:
        sportActivityMultiplicator = 1.5;
        break;
      case 3:
        sportActivityMultiplicator = 1.8;
        break;
      default:
        break;
    }

    double result = gender
        ? (66.4730 + (13.7516 * weight) + (5.0033 * height) - (6.7550 * age)) *
            sportActivityMultiplicator
        : (655.0955 + (9.5634 * weight) + (1.8496 * height) - (4.6756 * age)) *
            sportActivityMultiplicator;
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Besoin calorique journalier'),
            children: <Widget>[
              Text(
                  "Votre besoin calorique journalier est de ${result.toInt()} calories.")
            ],
          );
        });
  }
}
