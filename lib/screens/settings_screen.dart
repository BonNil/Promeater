import 'package:flutter/material.dart';
import 'package:promeater/screens/protein_slider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Row(children: const <Widget>[
            Text('Red Meat'),
            ProteinSlider(0, Colors.red)
          ]),
          Row(children: const <Widget>[
            Text('Poultry'),
            ProteinSlider(0, Colors.orange)
          ]),
          Row(children: const <Widget>[
            Text('Seafood'),
            ProteinSlider(0, Colors.blue)
          ]),
          Row(children: const <Widget>[
            Text('Vegetarian'),
            ProteinSlider(0, Colors.yellow)
          ]),
          Row(children: const <Widget>[
            Text('Vegan'),
            ProteinSlider(0, Colors.green)
          ]),
        ],
      ),
    );
  }
}
