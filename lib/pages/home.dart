import 'package:flutter/material.dart';
import 'package:frontend_oky_code/widgets/navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('OKY CODE'),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
