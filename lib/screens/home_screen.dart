import 'package:flutter/material.dart';
import 'package:promeater/screens/protein_bar.dart';
import 'package:promeater/models/protein.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: <Widget>[
            ProteinBar(Colors.red, Protein('Red Meat', 1, 2)),
            ProteinBar(Colors.orange, Protein('Poultry', 4, 5)),
            ProteinBar(Colors.blue, Protein('Seafood', 3, 7)),
            ProteinBar(Colors.yellow, Protein('Vegetarian', 5, 6)),
            ProteinBar(Colors.lightGreen, Protein('Vegan', 4, 12)),
          ],
        ),
      );
  }
}