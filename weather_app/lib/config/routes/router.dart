import 'package:go_router/go_router.dart';

import '../../infraestructure/presentation/common/views/views.dart';
import '../../infraestructure/presentation/screens/screens.dart';

final GoRouter routes = GoRouter(routes: [
  ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeView(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchView(),
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) => const RecentView(),
        ),
      ])

  /* GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(
            childView: HomeView(),
          )), */
]);
