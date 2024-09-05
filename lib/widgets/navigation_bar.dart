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
    double screenHeight = MediaQuery.of(context).size.height;
    
    return NavigationBar(
      overlayColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      height: screenHeight * 0.07,
      backgroundColor: const Color(0xFF201547),
      selectedIndex: widget.currentIndex,
      onDestinationSelected: (index) {
        widget.onUpdateIndex(index);
      },
      destinations: [
        /*
        NavigationDestination(
          icon: Container(
            margin: const EdgeInsets.fromLTRB(
                0, 14, 0, 0),
            height: 60,
            child: Image.asset('lib/assets/logos/logo_borde_morado.png'),
          ),
          label: "",
        ),
         */
        NavigationDestination(
          icon: Icon(
            Icons.history,
            size: screenHeight * 0.035,
            color: Colors.white,
          ),
          label: "Historial",
        ),
        NavigationDestination(
          icon: Icon(
            Icons.favorite,
            size: screenHeight * 0.035,
            color: Colors.white,
          ),
          label: "Favoritos",
        ),
        NavigationDestination(
          icon: SizedBox(
            width: screenHeight * 0.035,
            child: Image.asset('lib/assets/scanner.png'),
          ),
          label: "Scanner",
        ),
        NavigationDestination(
          icon: SizedBox(
            width: screenHeight * 0.035,
            child: Image.asset('lib/assets/lupa.png'),
          ),
          label: "Buscar",
        ),
        NavigationDestination(
          icon: SizedBox(
            width: screenHeight * 0.035,
            child: Image.asset('lib/assets/perfil.png'),
          ),
          label: "Perfil",
        ),
        /*
        NavigationDestination(
          icon: SizedBox(
            width: screenHeight * 0.035,
            child: Image.asset('lib/assets/preguntas.png'),
          ),
          label: "Nutricoach",
        ),

         */


      ],
    );
  }
}
