import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lol_dragon/core/utils/app_images.dart';
import 'package:lol_dragon/features/items/presentation/provider/items_provider.dart';
import 'package:lol_dragon/router/app_routes.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ItemsProvider>().loadItems();

    Timer(const Duration(seconds: 3), () {
      context.go(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AppImages.splashImg)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: FadeInImage(
                placeholder: AppImages.leagueLogo,
                image: AppImages.leagueLogo,
                height: 100.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
