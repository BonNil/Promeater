import 'package:flutter/material.dart';
import 'package:promeater/screens/protein_slider.dart';
import 'package:promeater/models/protein.dart';
import 'package:promeater/utils/proteinProvider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State {
  ProteinProvider provider = ProteinProvider();
  List<Protein> _proteins;

  @override
  Widget build(BuildContext context) {
    if (_proteins == null) {
      _proteins = <Protein>[];
      loadProteinData();
    }

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children:_proteins.map((protein) => ProteinSlider(protein)).toList(),
      ),
    );
  }

  void loadProteinData() {
    final dbFuture = provider.db;
    dbFuture.then((result) {
      final proteinsFuture = provider.getProteins();
      proteinsFuture.then((result) {
        setState(() {
          _proteins = result;
        });
      });
    });
  }
}

