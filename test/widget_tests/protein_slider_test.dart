import 'package:flutter_test/flutter_test.dart';
import 'package:promeater/widgets/protein_slider.dart';
import 'package:promeater/models/protein.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('proteinslider displays title and max value', (WidgetTester tester) async {
    final protein = Protein(Colors.blue, 'Test Slider', 5, 20);
    final proteinSliderComposition = MaterialApp(home: Scaffold(body: ProteinSlider(protein)));

    
    await tester
        .pumpWidget(proteinSliderComposition);

    // Create our Finders
    final titleFinder = find.text('Test Slider');
    final maxFinder = find.text('20');

    expect(titleFinder, findsOneWidget);
    expect(maxFinder, findsOneWidget);
  });

  testWidgets('proteinsliders max value is updated', (WidgetTester tester) async {
    final protein = Protein(Colors.blue, 'Test Slider', 5, 15);
    final proteinSliderComposition = MaterialApp(home: Scaffold(body: ProteinSlider(protein)));

    await tester
        .pumpWidget(proteinSliderComposition);

    expect(protein.maximum, equals(15));

    // Find the inner slider widget
    final slider = find.byType(Slider).first;

    /*
     * tester.tap attempts to tap in the center of the widget, 
     * i.e. at the center of the Slider.
     * The protein_slider widget is (hard)coded to max out at 20,
     * so clicking the center of it should set the protein value to 10.
     */
    await tester.tap(slider);
    expect(protein.maximum, equals(10));

    final Offset topLeft = tester.getTopLeft(slider);
    await tester.tapAt(topLeft);
    expect(protein.maximum, equals(0));

    await tester.drag(slider, const Offset(112.0, 0.0));
    expect(protein.maximum, closeTo(12, 3));
  });
}
