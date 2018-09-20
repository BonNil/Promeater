class Protein {
  String title;
  int maximum;
  int current;

  double get decimalPercentage => current.toDouble() / maximum.toDouble();

  Protein(this.title, this.current, this.maximum) {
    if (this.current > this.maximum)
      this.current = this.maximum;
  }
}