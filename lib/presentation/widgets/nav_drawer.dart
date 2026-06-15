// lib/presentation/widgets/nav_drawer.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_viewmodel.dart';
import '../pages/home_page.dart';
import '../pages/institucional_page.dart';
import '../pages/catalogo_page.dart';
import '../pages/buscar_page.dart';
import '../pages/login_page.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF1A237E)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 28,
                  child: Icon(Icons.store, color: Color(0xFF1A237E), size: 32),
                ),
                SizedBox(height: 10),
                Text(
                  'TechStore S.A.C.',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Gestión de Productos',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          _DrawerItem(
            icon: Icons.home_outlined,
            label: 'Inicio',
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
            },
          ),
          _DrawerItem(
            icon: Icons.info_outline,
            label: 'Institucional',
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const InstitucionalPage()));
            },
          ),
          _DrawerItem(
            icon: Icons.inventory_2_outlined,
            label: 'Catálogo de Productos',
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const CatalogoPage()));
            },
          ),
          _DrawerItem(
            icon: Icons.search,
            label: 'Buscador de Productos',
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BuscarPage()));
            },
          ),
          const Spacer(),
          const Divider(),
          _DrawerItem(
            icon: Icons.logout,
            label: 'Cerrar sesión',
            color: Colors.red.shade700,
            onTap: () {
              context.read<LoginViewModel>().reset();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (_) => false,
              );
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String   label;
  final VoidCallback onTap;
  final Color?   color;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? const Color(0xFF1A237E);
    return ListTile(
      leading: Icon(icon, color: c),
      title: Text(label, style: TextStyle(color: c, fontWeight: FontWeight.w500)),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
