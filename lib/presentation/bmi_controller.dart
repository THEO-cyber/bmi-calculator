import 'package:flutter/foundation.dart';
import '../domain/bmi_usecase.dart';

class BmiController extends ChangeNotifier {
  final CalculateBMI _usecase;

  double _height = 170;
  double _weight = 65;
  BmiResult? _lastResult;

  BmiController(this._usecase);

  double get height => _height;
  double get weight => _weight;
  BmiResult? get lastResult => _lastResult;

 
  BmiResult? preview() {
    if (_height <= 0 || _weight <= 0) return null;
    return _usecase.call(weightKg: _weight, heightCm: _height);
  }

  void updateHeight(double cm) {
    _height = cm;
    notifyListeners();
  }

  void updateWeight(double kg) {
    _weight = kg;
    notifyListeners();
  }

  void calculate() {
    _lastResult = _usecase.call(weightKg: _weight, heightCm: _height);
    notifyListeners();
  }

  void reset() {
    _height = 170;
    _weight = 65;
    _lastResult = null;
    notifyListeners();
  }
}
