import 'package:flutter/material.dart';

class RangeBar extends StatelessWidget {
  final double valor;
  final List<double> intervalos;

  RangeBar({required this.valor, required this.intervalos});

  @override
  Widget build(BuildContext context) {
    double anchoPantalla = MediaQuery.of(context).size.width;
    double anchoBarra = anchoPantalla * 0.9;
    double valorMaximo = intervalos.last;
    double posicionFlecha = ((valor > valorMaximo) ? valorMaximo : valor) / valorMaximo * anchoBarra;
    double leftPosition = (anchoPantalla - anchoBarra) / 2;

    return Container(
      width: anchoPantalla,
      height: 50,
      color: Colors.transparent,
      child: Stack(
        children: _buildSegments(anchoBarra, leftPosition, valorMaximo) +
          // Flecha
          [
            Positioned(
              top: 0,
              left: posicionFlecha + 8,
              child: const Icon(
                Icons.arrow_drop_down,
                color: Colors.red,
              ),
            ),
          ],
      ),
    );
  }

  List<Widget> _buildSegments(double anchoBarra, double leftPosition, double valorMaximo) {
    double anchoActual = 0;

    return List.generate(
      intervalos.length - 1,
      (index) {
        double inicio = intervalos[index];
        double fin = intervalos[index + 1];
        double anchoSegmento = (fin - inicio) / valorMaximo * anchoBarra;

        double left = leftPosition + anchoActual;
        anchoActual += anchoSegmento;

        return Positioned(
          top: 15,
          left: left,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 10,
                width: anchoSegmento,
                color: _getColorForSegment(index),
              ),
              const SizedBox(height: 5), // Espacio entre la barra y el texto
              Text(
                inicio.toInt().toString(), // Valor inicial del intervalo como entero
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }



  Color _getColorForSegment(int segmentIndex) {
    // Función para obtener colores para cada segmento
    List<Color> colores = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.yellow,
      Colors.teal,
      Colors.pink,
    ];

    return colores[segmentIndex % colores.length];
  }
}
