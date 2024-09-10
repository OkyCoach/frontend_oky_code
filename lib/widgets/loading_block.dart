import 'package:flutter/material.dart';

class LoadingBlock extends StatelessWidget {
  final double width;
  final double height;

  const LoadingBlock({
    Key? key,
    required this.width,
    required this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: const Color(0xFFE8E4F4),
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
    );
  }
}
