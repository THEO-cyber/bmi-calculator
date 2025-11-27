class BmiResult {
  final double value;
  final String category;
  final String interpretation;

  BmiResult(this.value, this.category, this.interpretation);
}

class CalculateBMI {
  /// Calculate BMI given weight(kg) and height(cm)
  BmiResult call({required double weightKg, required double heightCm}) {
    final heightM = heightCm / 100.0;
    final bmiValue = weightKg / (heightM * heightM);
    final v = double.parse(bmiValue.toStringAsFixed(1));

    String cat;
    String interp;

    if (v < 18.5) {
      cat = 'Underweight';
      interp = 'You are below the normal weight. Consider gaining weight.';
    } else if (v < 25) {
      cat = 'Normal';
      interp = 'Great — your weight is within the normal range.';
    } else if (v < 30) {
      cat = 'Overweight';
      interp = 'You are above the normal weight. Consider lifestyle changes.';
    } else {
      cat = 'Obese';
      interp = 'Health risk is elevated. Seek medical advice.';
    }

    return BmiResult(v, cat, interp);
  }
}
