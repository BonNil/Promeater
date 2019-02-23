import 'package:flutter/material.dart';
import 'package:promeater/models/protein.dart';
import 'package:promeater/utils/protein_provider.dart';
import 'package:promeater/style_variables.dart';

class ProteinBar extends StatefulWidget {
  const ProteinBar(this._protein);

  final Protein _protein;

  @override
  State<StatefulWidget> createState() {
    return _ProteinBarState(_protein);
  }
}

class _ProteinBarState extends State with TickerProviderStateMixin {
  _ProteinBarState(this._protein);

  Animation<double> initAnimation;
  AnimationController initAnimController;
  Animation<double> increaseAnimation;
  AnimationController increaseAnimController;
  Animation<double> decreaseAnimation;
  AnimationController decreaseAnimController;

  final ProteinProvider provider = ProteinProvider();
  Protein _protein;
  double barValue;

  @override
  void initState() {
    super.initState();
    initAnimController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    initAnimation = CurvedAnimation(
      parent: initAnimController,
      curve: Curves.easeInOut,
    )..addListener(() {
        setState(() {
          barValue = _protein.decimalPercentage * initAnimation.value;
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
                  (_protein.decimalPercentage - barValue));
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
                  (barValue - _protein.decimalPercentage));
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
    provider.updateProtein(_protein);

    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
        child: Row(children: <Widget>[
          Text(
            _protein.title,
            textAlign: TextAlign.start,
            style: StylingVariables.labelStyle,
          ),
          Expanded(
            child: Text(
              '${_protein.current} out of ${_protein.maximum}',
              textAlign: TextAlign.end,
              style: StylingVariables.smallLabelStyle,
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
                iconSize: 40.0,
                icon: const Icon(
                  Icons.remove,
                ),
                onPressed: decrease,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(_protein.color),
                  value: barValue,
                  backgroundColor: StylingVariables.lightgreyBgColor,
                ),
              ),
            ),
            Container(
              child: IconButton(
                iconSize: 40.0,
                icon: const Icon(Icons.add),
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
      if (_protein.current < _protein.maximum) {
        _protein.current++;
        increaseAnimController.forward();
      }
    });
  }

  void decrease() {
    setState(() {
      if (_protein.current > 0) {
        _protein.current--;
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
