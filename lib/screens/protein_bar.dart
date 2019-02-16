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

class _ProteinBarState extends State with TickerProviderStateMixin {
  _ProteinBarState(this.barColor, this.protein);

  Animation<double> initAnimation;
  AnimationController initAnimController;
  Animation<double> increaseAnimation;
  AnimationController increaseAnimController;
  Animation<double> decreaseAnimation;
  AnimationController decreaseAnimController;

  Color barColor;
  Protein protein;
  double barValue;

  @override
  void initState() {
    super.initState();
    initAnimController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    initAnimation = CurvedAnimation(
      parent: initAnimController,
      curve: Curves.easeInOut,
    )..addListener(() {
        setState(() {
          barValue = protein.decimalPercentage * initAnimation.value;
        });
      });

    initAnimController.forward();

    increaseAnimController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    increaseAnimation = CurvedAnimation(
      parent: increaseAnimController,
      curve: Curves.linear,
    )
      ..addListener(() {
        setState(() {
          barValue = barValue +
              (increaseAnimation.value *
                  (protein.decimalPercentage - barValue));
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          increaseAnimController.reset();
        }
      });

    decreaseAnimController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    decreaseAnimation = CurvedAnimation(
      parent: decreaseAnimController,
      curve: Curves.linear,
    )
      ..addListener(() {
        setState(() {
          barValue = barValue -
              (decreaseAnimation.value *
                  (barValue - protein.decimalPercentage));
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          decreaseAnimController.reset();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
        child: Row(children: <Widget>[
          Text(
            protein.title,
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
          Expanded(
            child: Text(
              '${protein.current} out of ${protein.maximum}',
              textAlign: TextAlign.end,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
        ]),
      ),
      Container(
        height: 60.0,
        padding:
            const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              child: IconButton(
                icon: const Icon(
                  Icons.remove,
                ),
                onPressed: decrease,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(barColor),
                  value: barValue,
                  backgroundColor: const Color.fromRGBO(0, 0, 0, 0.10),
                ),
              ),
            ),
            Container(
              child: IconButton(
                icon: const Icon(
                  Icons.add,
                ),
                onPressed: increase,
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  void increase() {
    setState(() {
      if (protein.current < protein.maximum) {
        protein.current++;
        increaseAnimController.forward();
      }
    });
  }

  void decrease() {
    setState(() {
      if (protein.current > 0) {
        protein.current--;
        decreaseAnimController.forward();
      }
    });
  }

  @override
  void dispose() {
    initAnimController.dispose();
    decreaseAnimController.dispose();
    increaseAnimController.dispose();
    super.dispose();
  }
}
