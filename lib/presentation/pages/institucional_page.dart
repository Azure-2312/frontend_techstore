// lib/presentation/pages/institucional_page.dart

import 'package:flutter/material.dart';
import '../widgets/nav_drawer.dart';

class InstitucionalPage extends StatelessWidget {
  const InstitucionalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información Institucional'),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
      ),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header empresa
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A237E),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.store, color: Colors.white, size: 48),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'TechStore S.A.C.',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)),
                  ),
                  const Text(
                    'Soluciones Tecnológicas • Lima, Perú • Desde 2018',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _SeccionCard(
              titulo: '📋 Descripción',
              contenido: 'TechStore S.A.C. es una empresa peruana orientada a la venta y distribución de productos tecnológicos. '
                  'Fundada en 2018 en la ciudad de Lima, ofrece una amplia línea de productos que incluye laptops, '
                  'computadoras, smartphones, tablets, periféricos y accesorios electrónicos. '
                  'La empresa atiende tanto a clientes corporativos como a consumidores finales.',
            ),
            const SizedBox(height: 16),

            _SeccionCard(
              titulo: '🎯 Misión',
              contenido: 'Proveer soluciones tecnológicas de calidad a los clientes, ofreciendo una experiencia de compra '
                  'digital ágil, confiable y personalizada, apoyada en herramientas modernas de gestión interna.',
            ),
            const SizedBox(height: 16),

            _SeccionCard(
              titulo: '🔭 Visión',
              contenido: 'Convertirse en la plataforma de comercio tecnológico líder en el Perú para el año 2030, '
                  'reconocida por su innovación digital y excelencia en la atención al cliente.',
            ),
            const SizedBox(height: 16),

            _SeccionCard(
              titulo: '📦 Línea de Productos',
              contenido: '• Laptops y Computadoras\n'
                  '• Smartphones y Tablets\n'
                  '• Monitores\n'
                  '• Almacenamiento (SSD, HDD)\n'
                  '• Periféricos (teclados, mouse, auriculares)\n'
                  '• Accesorios electrónicos',
            ),
            const SizedBox(height: 16),

            _SeccionCard(
              titulo: '📞 Contacto',
              contenido: '📍 Av. Javier Prado Este 123, Lima, Perú\n'
                  '📧 contacto@techstore.pe\n'
                  '📱 (+51) 01-234-5678\n'
                  '🌐 www.techstore.pe',
            ),
          ],
        ),
      ),
    );
  }
}

class _SeccionCard extends StatelessWidget {
  final String titulo;
  final String contenido;

  const _SeccionCard({required this.titulo, required this.contenido});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
          const SizedBox(height: 8),
          Text(contenido, style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.5)),
        ],
      ),
    );
  }
}
