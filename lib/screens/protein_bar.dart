import 'package:flutter/material.dart';
import 'package:promeater/models/protein.dart';

class ProteinBar extends StatefulWidget {
  const ProteinBar(this.barColor, this.protein);

  final Color barColor;
  final Protein protein;


  @override
  State<StatefulWidget> createState() {
    return _ProteinBarState(barColor, protein);
  }
}

class _ProteinBarState extends State with SingleTickerProviderStateMixin {
  _ProteinBarState(this.barColor, this.protein);

  Animation<double> animation;
  AnimationController controller;

  Color barColor;
  Protein protein;
  double value;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );
      animation.addListener(() {
      setState(() {
        value = protein.decimalPercentage * animation.value;
      });
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, right:20.0),
            child: Row(children: <Widget>[
              Text(
                protein.title,
                textAlign: TextAlign.start,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
              Expanded(
                child: Text(
                  '${protein.current} out of ${protein.maximum}',
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
            ]),
          ),
          Container(
            height: 60.0,
            padding: const EdgeInsets.only(
                top: 10.0, left: 10.0, right: 10.0, bottom: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: IconButton(
                    icon: const Icon(
                      Icons.remove,
                    ),
                    onPressed: remove,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(barColor),
                      value: value,
                      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.10),
                    ),
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                    ),
                    onPressed: add,
                  ),
                ),
              ],
            ),
          ),
        ]);
  }

  void add() {
    setState(() {
      if (protein.current < protein.maximum) {
        protein.current++;
        value = protein.decimalPercentage;
      }
    });
  }

  void remove() {
    setState(() {
      if (protein.current > 0) {
        protein.current--;
        value = protein.decimalPercentage;
      }
    });
  }
}
