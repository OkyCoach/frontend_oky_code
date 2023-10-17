import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera),
          label: 'Scanner',
        ),
      ],
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      unselectedLabelStyle: TextStyle(color: Colors.grey),
      selectedLabelStyle: TextStyle(color: Colors.blue),
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          switch (index) {
            case 0:
              // Navegar a la vista de inicio
              Navigator.of(context).pushReplacementNamed('/scanner');
              break;
            case 1:
              // Navegar a la vista de búsqueda
              Navigator.of(context).pushReplacementNamed('/scanner');
              break;
            case 2:
              // Navegar a la vista de perfil
              Navigator.of(context).pushReplacementNamed('/scanner');
              break;
            case 3:
              // Navegar a la vista de escáner
              Navigator.of(context).pushReplacementNamed('/scanner');
              break;
          }
        });
      },
    );
  }
}
