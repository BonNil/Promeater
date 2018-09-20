import 'package:flutter/material.dart';

class ProteinBar extends StatefulWidget {
  final Color barColor;
  final String title;
  final double value;

  ProteinBar(this.title, this.barColor, this.value);

  @override
  State<StatefulWidget> createState() {
    return _ProteinBarState(barColor, title, value);
  }
}

class _ProteinBarState extends State {
  Color barColor;
  String title;
  double value;

  _ProteinBarState(this.barColor, this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
            ),
          ),
          Container(
            height: 60.0,
            padding: EdgeInsets.only(
                top: 10.0, left: 10.0, right: 10.0, bottom: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  alignment: Alignment.center,
                  icon: Icon(
                    Icons.remove_circle_outline,
                  ),
                  onPressed: remove,
                ),
                Expanded(
                  child: Center(
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(barColor),
                      value: this.value,
                      backgroundColor: Color.fromRGBO(0, 0, 0, 0.10),
                    ),
                  ),
                ),
                IconButton(
                  alignment: Alignment.center,
                  icon: Icon(
                    Icons.add_circle_outline,
                  ),
                  onPressed: add,
                ),
              ],
            ),
          ),
        ]);
  }

  void add() {
    setState(() {
      if (this.value <= 0.9){
        this.value += 0.1;
      }
    });
  }

  void remove() {
    setState(() {
      if (this.value >= 0.1){
        this.value -= 0.1;        
      }
    });
  }
}
