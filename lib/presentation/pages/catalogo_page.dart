// lib/presentation/pages/catalogo_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/producto_viewmodel.dart';
import '../viewmodels/producto_state.dart';
import '../widgets/nav_drawer.dart';

class CatalogoPage extends StatefulWidget {
  const CatalogoPage({super.key});

  @override
  State<CatalogoPage> createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductoViewModel>().cargarProductos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Productos'),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<ProductoViewModel>().cargarProductos(),
          ),
        ],
      ),
      drawer: const NavDrawer(),
      body: Consumer<ProductoViewModel>(
        builder: (context, vm, _) {
          switch (vm.state.status) {
            case ProductoStatus.loading:
              return const Center(child: CircularProgressIndicator(color: Color(0xFF1A237E)));

            case ProductoStatus.error:
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wifi_off, size: 60, color: Colors.grey),
                    const SizedBox(height: 12),
                    Text(vm.state.errorMessage ?? 'Error', style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: vm.cargarProductos,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A237E), foregroundColor: Colors.white),
                    ),
                  ],
                ),
              );

            case ProductoStatus.empty:
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.inventory_2_outlined, size: 60, color: Colors.grey),
                    SizedBox(height: 12),
                    Text('No hay productos en el catálogo', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              );

            case ProductoStatus.loaded:
              final productos = vm.state.productos;
              return Column(
                children: [
                  Container(
                    color: const Color(0xFF1A237E).withOpacity(0.05),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.inventory_2_outlined, size: 16, color: Color(0xFF1A237E)),
                        const SizedBox(width: 6),
                        Text(
                          '${productos.length} producto(s) encontrado(s)',
                          style: const TextStyle(color: Color(0xFF1A237E), fontWeight: FontWeight.w500, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: productos.length,
                      itemBuilder: (ctx, i) {
                        final p = productos[i];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A237E).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.devices, color: Color(0xFF1A237E)),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(p.nombre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                      const SizedBox(height: 3),
                                      Text(p.codigo, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          _Chip(label: p.categoria, color: Colors.blue),
                                          const SizedBox(width: 6),
                                          _Chip(label: 'Stock: ${p.stock}', color: p.stock > 0 ? Colors.green : Colors.red),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'S/ ${p.precio.toStringAsFixed(2)}',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1A237E)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );

            default:
              return const Center(child: Text('Cargando catálogo...'));
          }
        },
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;

  const _Chip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w500)),
    );
  }
}
