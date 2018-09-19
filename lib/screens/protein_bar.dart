import 'package:flutter/material.dart';

class ProteinBar extends StatefulWidget {
  final Color barColor;
  final String title;

  ProteinBar(this.title, this.barColor);

  @override
  State<StatefulWidget> createState() {
    return _ProteinBarState(barColor, title);
  } 
}

class _ProteinBarState extends State {
  Color barColor;
  String title;

  _ProteinBarState(this.barColor, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40.0),
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            child: FittedBox(
              fit: BoxFit.fill,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(barColor),
                value: 0.8,
                strokeWidth: 8.0,
                backgroundColor: barColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
