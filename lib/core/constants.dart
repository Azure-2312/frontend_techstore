// lib/core/constants.dart
import 'package:flutter/foundation.dart';

class AppConstants {
  // Detecta automáticamente si está en web (localhost) o en emulador Android (10.0.2.2)
  static const String baseUrl = kIsWeb 
      ? 'http://localhost:5000' 
      : 'http://10.0.2.2:5000';

  static const String loginEndpoint     = '$baseUrl/api/login';
  static const String productosEndpoint = '$baseUrl/api/productos';
  static const String buscarEndpoint    = '$baseUrl/api/productos/buscar';
}
