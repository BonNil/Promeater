import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';

class ProteinSlider extends StatefulWidget {
  const ProteinSlider(this._initialValue, this._color);

  final int _initialValue;
  final Color _color;

  @override
  State<StatefulWidget> createState() {
    return _ProteinSliderState(_initialValue, _color);
  }
}

class _ProteinSliderState extends State {
  _ProteinSliderState(int initialValue, Color color) {
    _currentValue = initialValue;
    _color = color;
  }

  int _currentValue;
  Color _color;

  @override
  Widget build(BuildContext context) {
    return FluidSlider(
      min: 0,
      max: 20,
      value: _currentValue.toDouble(),
      onChanged: (double newValue) => setValue(newValue),
      sliderColor: _color,
    );
  }

  void setValue(double newValue) {
    setState(() {
      _currentValue = newValue.toInt();
    });
  }
}
