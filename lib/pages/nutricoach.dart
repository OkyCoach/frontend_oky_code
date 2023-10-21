import 'package:flutter/material.dart';

class NutricoachPage extends StatefulWidget {
  const NutricoachPage({Key? key}) : super(key: key);

  @override
  State<NutricoachPage> createState() => _NutricoachState();
}

class _NutricoachState extends State<NutricoachPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Nutricoach'),
          ],
        ),
      ),
    );
  }
}
