import 'package:flutter/material.dart';

class OkyTips extends StatefulWidget {
  const OkyTips({
    Key? key,
  }) : super(key: key);

  @override
  _OkyTipsState createState() => _OkyTipsState();
}

class _OkyTipsState extends State<OkyTips> {
  @override
  Widget build(BuildContext context) {
    double margins = 0.04;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * margins),
      child: const Expanded(
        child: Center(
          child: Text("Hola"),
        ),
      ),
    );
  }
}
