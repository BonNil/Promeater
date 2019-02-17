import 'package:promeater/models/protein.dart';

class Eater {
  factory Eater() {
    return _eater;
  }
  Eater._internal();

  static final Eater _eater = Eater._internal();
  Protein redMeat;
  Protein poultry;
  Protein seafood;
  Protein vegetarian;
  Protein vegan;

  int get currentTotal {
    return redMeat.current +
        poultry.current +
        seafood.current +
        vegetarian.current +
        vegan.current;
  }

  int get maximumTotal {
    return redMeat.maximum +
        poultry.maximum +
        seafood.maximum +
        vegetarian.maximum +
        vegan.maximum;
  }
}
