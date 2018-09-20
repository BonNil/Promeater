import 'package:flutter/material.dart';
import 'package:promeater/screens/protein_bar.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
            ProteinBar('Red Meat', Colors.red, 0.2),
            ProteinBar('Poultry', Colors.yellow, 0.4),
            ProteinBar('Seafood', Colors.blue, 0.8),
            ProteinBar('Vegetarian', Colors.lightGreen, 0.7),
            ProteinBar('Vegan', Colors.green, 0.5),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
