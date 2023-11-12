import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/range_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RangeBar(valor: 3, intervalos: const [
          0,
          1,
          3,
          7,
          14
        ]), // Puedes cambiar el valor aquí
      ),
    );
  }
}
