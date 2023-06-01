import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheater_app/infraestructure/presentation/common/utils/styles.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: gradientStyle,
      child: NavigationBar(
        selectedIndex: _getCurrentIndex(context),
        onDestinationSelected: (index) {
          _onItemTapped(context, index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.search_outlined), label: 'Búsqueda'),
          NavigationDestination(icon: Icon(Icons.receipt_outlined), label: 'Recientes'),
        ],
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    switch (location) {
      case '/':
        return 0;
      case '/search':
        return 1;
      case '/favorites':
        return 2;
      default:
        return 0;
    }
  }

  _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        return context.go('/');
      case 1:
        return context.go('/search');
      case 2:
        return context.go('/favorites');
    }
  }
}
