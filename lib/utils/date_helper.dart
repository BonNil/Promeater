import 'package:intl/intl.dart';

// Calculates week number from a date as per https://en.wikipedia.org/wiki/ISO_week_date#Calculation
int weekNumber(DateTime date) {
  final dayOfYear = int.parse(DateFormat('D').format(date));
  final week = ((dayOfYear - date.weekday + 10) / 7).floor();

  return week;
}