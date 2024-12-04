import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NutritionalValues extends StatelessWidget {
  final List<dynamic> values;

  const NutritionalValues({
    Key? key,
    required this.values,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        
      ]
    );
  }
}
