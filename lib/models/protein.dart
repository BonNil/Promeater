import 'package:flutter/material.dart';

class Protein {
  Protein(this.color, this._title, this._current, this._maximum) {
    if (_current > _maximum) _current = _maximum;
    show = _maximum > 0;
  }
  
  Protein.fromObject(dynamic o) {
    _id = o['id'];
    _title = o['title'];
    _maximum = o['maximum'];
    _current = o['current'];
    color = Color(o['color']);
    show = o['show'] == 1;
  }

  Color color;
  int _id;
  String _title;
  int _maximum;
  int _current;
  bool show;

  int get id => _id;
  String get title => _title;
  int get maximum => _maximum;
  int get current => _current;

  double get decimalPercentage => _current.toDouble() / _maximum.toDouble();

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      _title = newTitle;
    }
  }

  set maximum(int newMax) {
    if (newMax > 20) {
      _maximum = 20;
    } else {
      _maximum = newMax;
    }
  }

  set current(int newCurrent) {
    if (newCurrent <= maximum) {
      _current = newCurrent;
    } else {
      _current = maximum;
    }
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'title': _title,
      'maximum': _maximum,
      'current': _current,
      'show': show ? 1 : 0,
      'color': color.value
    };

    if (_id != null) {
      map['id'] = _id;
    }
    return map;
  }
}
