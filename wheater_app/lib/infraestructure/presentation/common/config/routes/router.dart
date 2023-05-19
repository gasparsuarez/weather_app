import 'package:go_router/go_router.dart';

import '../../../screens/screens.dart';

final GoRouter routes = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
  )
]);
