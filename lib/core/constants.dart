// lib/core/constants.dart
import 'package:flutter/foundation.dart';

class AppConstants {
  // Detecta automáticamente el entorno (local/producción y web/móvil)
  static const String baseUrl = kIsWeb 
      ? (kDebugMode ? 'http://localhost:5000' : 'https://backend-techstore-1zjv.onrender.com')
      : 'http://10.0.2.2:5000';

  static const String loginEndpoint     = '$baseUrl/api/login';
  static const String productosEndpoint = '$baseUrl/api/productos';
  static const String buscarEndpoint    = '$baseUrl/api/productos/buscar';
}
