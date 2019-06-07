import 'package:flutter/material.dart';
import 'package:promeater/screens/protein_bar.dart';
import 'package:promeater/models/protein.dart';
import 'package:promeater/utils/protein_provider.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  ProteinProvider provider = ProteinProvider();
  List<Protein> _proteins;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if (_proteins == null) {
      _proteins = <Protein>[];
      loadProteinData();
    }

    return Container(
      padding: const EdgeInsets.only(
          left: 20.0, top: 0.0, right: 20.0, bottom: 10.0),
      child: ListView(
        children: _proteins.map((protein) => ProteinBar(protein)).toList(),
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
