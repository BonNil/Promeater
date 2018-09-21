import 'package:flutter/material.dart';
import 'package:promeater/screens/protein_bar.dart';
import 'package:promeater/models/protein.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Promeater',
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: new MyHomePage(title: 'Promeater'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListView(
          children: <Widget>[
            ProteinBar(Colors.red, Protein('Read Meat', 1, 2)),
            ProteinBar(Colors.orange, Protein('Poultry', 4, 5)),
            ProteinBar(Colors.blue, Protein('Seafood', 3, 7)),
            ProteinBar(Colors.yellow, Protein('Vegetarian', 5, 6)),
            ProteinBar(Colors.lightGreen, Protein('Vegan', 4, 12)),
          ],
        ),
      ),
    );
  }
}
