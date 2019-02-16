class Protein {
  Protein(this.title, this.current, this.maximum) {
    if (current > maximum)
      current = maximum;
  }

  String title;
  int maximum;
  int current;

  double get decimalPercentage => current.toDouble() / maximum.toDouble();
}