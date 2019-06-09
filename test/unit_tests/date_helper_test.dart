import 'package:flutter_test/flutter_test.dart';
import 'package:promeater/utils/date_helper.dart';

void main() {
    test('should return correct week', () {
      final weekNr = weekNumber(DateTime.utc(2019, 06, 09));

      expect(weekNr, 23);
    });
}
