// lib/presentation/viewmodels/producto_viewmodel.dart

import 'package:flutter/foundation.dart';
import '../../domain/repositories/producto_repository.dart';
import 'producto_state.dart';

class ProductoViewModel extends ChangeNotifier {
  final ProductoRepository _productoRepository;

  ProductoState _state = const ProductoState();
  ProductoState get state => _state;

  ProductoViewModel(this._productoRepository);

  Future<void> cargarProductos() async {
    _state = _state.copyWith(status: ProductoStatus.loading);
    notifyListeners();

    try {
      final lista = await _productoRepository.listarProductos();
      _state = lista.isEmpty
          ? _state.copyWith(status: ProductoStatus.empty, productos: [])
          : _state.copyWith(status: ProductoStatus.loaded, productos: lista);
    } catch (e) {
      _state = _state.copyWith(
        status: ProductoStatus.error,
        errorMessage: 'Error al cargar productos. Verifique el servidor.',
      );
    }

    notifyListeners();
  }

  Future<void> buscarProductos(String query) async {
    if (query.trim().isEmpty) {
      _state = _state.copyWith(status: ProductoStatus.initial, productos: []);
      notifyListeners();
      return;
    }

    _state = _state.copyWith(status: ProductoStatus.loading);
    notifyListeners();

    try {
      final lista = await _productoRepository.buscarProductos(query.trim());
      _state = lista.isEmpty
          ? _state.copyWith(status: ProductoStatus.empty, productos: [])
          : _state.copyWith(status: ProductoStatus.loaded, productos: lista);
    } catch (e) {
      _state = _state.copyWith(
        status: ProductoStatus.error,
        errorMessage: 'Error al buscar productos.',
      );
    }

    notifyListeners();
  }

  void limpiar() {
    _state = const ProductoState();
    notifyListeners();
  }
}
