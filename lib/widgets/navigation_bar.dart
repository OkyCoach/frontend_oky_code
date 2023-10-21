import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  final int currentIndex; // Agrega esta variable
  final Function(int) onUpdateIndex; // Agrega esta variable

  CustomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onUpdateIndex,
  }) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 60,
      selectedIndex: widget.currentIndex, // Usa el currentIndex pasado como propiedad
      onDestinationSelected: (index) {
        widget.onUpdateIndex(index); // Llama a la función de callback para actualizar el _currentIndex
      },
      destinations: const [
        NavigationDestination(
            icon: Icon(Icons.home),
            selectedIcon: Icon(Icons.home_outlined),
            label: "Home"),
        NavigationDestination(
            icon: Icon(Icons.update),
            selectedIcon: Icon(Icons.update_outlined),
            label: "Recs"),
        NavigationDestination(
            icon: Icon(Icons.photo_camera),
            selectedIcon: Icon(Icons.photo_camera_outlined),
            label: "Scan"),
        NavigationDestination(
            icon: Icon(Icons.pie_chart),
            selectedIcon: Icon(Icons.pie_chart_outline),
            label: "Overview"),
        NavigationDestination(
            icon: Icon(Icons.help),
            selectedIcon: Icon(Icons.help_outline),
            label: "Nutricoach")
      ],
    );
  }
}
