import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
 const PlaceholderScreen(this.color);
 
 final Color color;

 @override
 Widget build(BuildContext context) {
   return Container(
     color: color,
   );
 }
}