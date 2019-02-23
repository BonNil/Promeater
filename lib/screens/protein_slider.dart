import 'package:flutter/material.dart';
import 'package:promeater/style_variables.dart';
import 'package:promeater/models/protein.dart';
import 'package:promeater/utils/proteinProvider.dart';

class ProteinSlider extends StatefulWidget {
  const ProteinSlider(this._protein);

  final Protein _protein;

  @override
  State<StatefulWidget> createState() {
    return _ProteinSliderState(_protein);
  }
}

class _ProteinSliderState extends State {
  _ProteinSliderState(this._protein);

  final ProteinProvider _provider = ProteinProvider();
  Protein _protein;

  @override
  Widget build(BuildContext context) {
    _provider.updateProtein(_protein);

    return Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
        child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Text(
                _protein.title,
                textAlign: TextAlign.left,
                style: StylingVariables.labelStyle,
              ),
              Row(children: <Widget>[
                Expanded(
                    child: Slider(
                  min: 0,
                  max: 20,
                  value: _protein.maximum.toDouble(),
                  onChanged: (double newValue) => setValue(newValue),
                  label: '${_protein.maximum}',
                  activeColor: _protein.color,
                  inactiveColor: StylingVariables.lightgreyBgColor,
                )),
                _protein.maximum != 20
                    ? Text(
                        _protein.maximum.toString(),
                        style: StylingVariables.smallLabelStyle,
                      )
                    : const Icon(Icons.all_inclusive),
              ])
            ])));
  }

  void setValue(double newValue) {
    setState(() {
      _protein.maximum = newValue.toInt();
    });
  }
}
