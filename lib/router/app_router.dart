import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lol_dragon/features/home/presentation/home_screen.dart';
import 'package:lol_dragon/features/items/presentation/items_screen.dart';
import 'package:lol_dragon/features/splash/presentation/splash_screen.dart';
import 'package:lol_dragon/router/app_routes.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: HomeScreen()),
    ),
    GoRoute(
      path: AppRoutes.items,
      pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: ItemsScreen()),
    ),
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: SplashScreen()),
    )
  ],
);
