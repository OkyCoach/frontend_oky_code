import 'package:geolocator/geolocator.dart';

Future<Position?> getCurrentLocation() async {
  try {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si el GPS está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("El GPS está desactivado.");
      return null;
    }

    // Verificar permisos de ubicación
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Permisos denegados.");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Permisos permanentemente denegados.");
      return null;
    }

    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    // Obtener la ubicación actual
    Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    print(position);
    return position;
  } catch (error){
    return null;
  }
}
