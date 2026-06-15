// lib/data/repositories/producto_repository_impl.dart

import '../../domain/entities/producto.dart';
import '../../domain/repositories/producto_repository.dart';
import '../datasources/api_service.dart';
import '../models/producto_model.dart';
import '../../core/constants.dart';

class ProductoRepositoryImpl implements ProductoRepository {
  final ApiService _api;

  ProductoRepositoryImpl(this._api);

  @override
  Future<List<Producto>> listarProductos() async {
    final data = await _api.get(AppConstants.productosEndpoint);
    return (data as List)
        .map((json) => ProductoModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Producto>> buscarProductos(String query) async {
    final url = '${AppConstants.buscarEndpoint}?q=${Uri.encodeComponent(query)}';
    final data = await _api.get(url);
    return (data as List)
        .map((json) => ProductoModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
