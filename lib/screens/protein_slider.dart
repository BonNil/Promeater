import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:promeater/style_variables.dart';

class ProteinSlider extends StatefulWidget {
  const ProteinSlider(this._initialValue, this._label, this._color);

  final int _initialValue;
  final String _label;
  final Color _color;

  @override
  State<StatefulWidget> createState() {
    return _ProteinSliderState(_initialValue, _label, _color);
  }
}

class _ProteinSliderState extends State {
  _ProteinSliderState(this._currentValue, this._label, this._color);

  int _currentValue;
  String _label;
  Color _color;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
        child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Text(
                _label,
                textAlign: TextAlign.left,
                style: StylingVariables.labelStyle,
              ),
              Row(children: <Widget>[
                Expanded(
                    child: Slider(
                  min: 0,
                  max: 20,
                  value: _currentValue.toDouble(),
                  onChanged: (double newValue) => setValue(newValue),
                  label: '$_currentValue',
                  activeColor: _color,
                  inactiveColor: StylingVariables.lightgreyBgColor,
                )),
                _currentValue != 20 ? Text(
                  _currentValue.toString(),
                  style: StylingVariables.smallLabelStyle,
                ) : const Icon(Icons.all_inclusive),
              ])
            ])));
  }

  void setValue(double newValue) {
    setState(() {
      _currentValue = newValue.toInt();
    });
  }
}
