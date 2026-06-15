// lib/presentation/viewmodels/producto_state.dart

import '../../domain/entities/producto.dart';

enum ProductoStatus { initial, loading, loaded, empty, error }

class ProductoState {
  final ProductoStatus   status;
  final List<Producto>   productos;
  final String?          errorMessage;

  const ProductoState({
    this.status       = ProductoStatus.initial,
    this.productos    = const [],
    this.errorMessage,
  });

  ProductoState copyWith({
    ProductoStatus? status,
    List<Producto>? productos,
    String?         errorMessage,
  }) {
    return ProductoState(
      status:       status       ?? this.status,
      productos:    productos    ?? this.productos,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
