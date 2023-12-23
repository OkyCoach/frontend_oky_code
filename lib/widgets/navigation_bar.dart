import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onUpdateIndex;

  const CustomNavigationBar({
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
      height: 70,
      backgroundColor: const Color(0xFF201547),
      selectedIndex: widget.currentIndex,
      onDestinationSelected: (index) {
        widget.onUpdateIndex(index);
      },
      destinations: [
        NavigationDestination(
          icon: Container(
            margin: const EdgeInsets.fromLTRB(
                0, 12, 0, 0), // Ajusta el margen según sea necesario
            height: 60,
            child: Image.asset('lib/assets/logos/logo_blanco.png'),
          ),
          label: "",
        ),
        NavigationDestination(
          icon: SizedBox(
            width: 40,
            height: 40,
            child: Image.asset('lib/assets/perfil.png'),
          ),
          label: "PERFIL",
        ),
        NavigationDestination(
          icon: SizedBox(
            width: 40,
            height: 40,
            child: Image.asset('lib/assets/scanner.png'),
          ),
          label: "SCANNER",
        ),
        NavigationDestination(
          icon: SizedBox(
            width: 40,
            height: 40,
            child: Image.asset('lib/assets/preguntas.png'),
          ),
          label: "NUTRICOACH",
        ),
        NavigationDestination(
          icon: SizedBox(
            width: 40,
            height: 40,
            child: Image.asset('lib/assets/lupa.png'),
          ),
          label: "BUSCAR",
          
        ),
      ],
    );
  }
}
