// lib/presentation/pages/buscar_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/producto_viewmodel.dart';
import '../viewmodels/producto_state.dart';
import '../widgets/nav_drawer.dart';

class BuscarPage extends StatefulWidget {
  const BuscarPage({super.key});

  @override
  State<BuscarPage> createState() => _BuscarPageState();
}

class _BuscarPageState extends State<BuscarPage> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    context.read<ProductoViewModel>().limpiar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscador de Productos'),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
      ),
      drawer: const NavDrawer(),
      body: Column(
        children: [
          // Barra de búsqueda
          Container(
            color: const Color(0xFF1A237E).withOpacity(0.05),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    decoration: InputDecoration(
                      hintText: 'Buscar por código, nombre o categoría...',
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF1A237E)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      suffixIcon: _searchCtrl.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchCtrl.clear();
                                context.read<ProductoViewModel>().limpiar();
                                setState(() {});
                              },
                            )
                          : null,
                    ),
                    onChanged: (v) {
                      setState(() {});
                      if (v.trim().length >= 2) {
                        context.read<ProductoViewModel>().buscarProductos(v);
                      } else if (v.trim().isEmpty) {
                        context.read<ProductoViewModel>().limpiar();
                      }
                    },
                    onSubmitted: (v) => context.read<ProductoViewModel>().buscarProductos(v),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => context.read<ProductoViewModel>().buscarProductos(_searchCtrl.text),
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),

          // Resultados
          Expanded(
            child: Consumer<ProductoViewModel>(
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
                        ],
                      ),
                    );

                  case ProductoStatus.empty:
                    return const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search_off, size: 60, color: Colors.grey),
                          SizedBox(height: 12),
                          Text('No se encontraron productos', style: TextStyle(color: Colors.grey, fontSize: 16)),
                          SizedBox(height: 6),
                          Text('Intente con otro término de búsqueda', style: TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    );

                  case ProductoStatus.loaded:
                    final productos = vm.state.productos;
                    return Column(
                      children: [
                        Container(
                          color: const Color(0xFF1A237E).withOpacity(0.05),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle_outline, size: 16, color: Color(0xFF1A237E)),
                              const SizedBox(width: 6),
                              Text(
                                '${productos.length} resultado(s) para "${_searchCtrl.text}"',
                                style: const TextStyle(color: Color(0xFF1A237E), fontSize: 13, fontWeight: FontWeight.w500),
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
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(14),
                                  leading: Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1A237E).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(Icons.devices, color: Color(0xFF1A237E)),
                                  ),
                                  title: Text(p.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${p.codigo} • ${p.categoria}',
                                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                                      const SizedBox(height: 2),
                                      Text(p.descripcion,
                                          style: const TextStyle(fontSize: 12),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'S/ ${p.precio.toStringAsFixed(2)}',
                                        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A237E), fontSize: 15),
                                      ),
                                      Text('Stock: ${p.stock}', style: TextStyle(color: p.stock > 0 ? Colors.green.shade700 : Colors.red.shade700, fontSize: 12)),
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
                    return const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search, size: 80, color: Colors.grey),
                          SizedBox(height: 16),
                          Text('Ingrese un término para buscar productos',
                              style: TextStyle(color: Colors.grey, fontSize: 15)),
                        ],
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
