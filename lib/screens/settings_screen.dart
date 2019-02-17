import 'package:flutter/material.dart';
import 'package:promeater/screens/protein_slider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(children: const <Widget>[
        ProteinSlider(0, 'Red Meat', Colors.red),
        ProteinSlider(0, 'Poultry', Colors.orange),
        ProteinSlider(0, 'Seafood', Colors.blue),
        ProteinSlider(0, 'Vegetarian', Colors.yellow),
        ProteinSlider(0, 'Vegan', Colors.green)
      ]),
    );
  }
}
