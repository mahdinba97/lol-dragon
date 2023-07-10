import 'package:go_router/go_router.dart';
import 'package:lol_dragon/features/home/presentation/home_screen.dart';
import 'package:lol_dragon/features/items/presentation/items_screen.dart';
import 'package:lol_dragon/router/app_routes.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: AppRoutes.home,
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: AppRoutes.items,
    builder: (context, state) => const ItemsScreen(),
  ),
]);
