import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:lol_dragon/context_extension.dart';
import 'package:lol_dragon/core/utils/app_images.dart';
import 'package:lol_dragon/router/app_router.dart';

import '../../../router/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bottomNavigationKey = GlobalKey();
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    // final iconColor = context.theme.iconTheme.color;
    return Scaffold(
      // bottomNavigationBar: buildNavBar(context, iconColor),
      body: Padding(
        padding: EdgeInsets.all(20.r).copyWith(top: 40.r),
        child: AnimationLimiter(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1000),
                    child: SlideAnimation(
                      verticalOffset: 40.0,
                      child: FadeInAnimation(
                        child: buildItems()[index],
                      ),
                    ),
                  );
                },
              ),
              Spacer(),
              Image(
                image: AppImages.appIcon,
                width: 100.w,
                height: 100.h,
              ),
              SizedBox(height: 20.h)
            ],
          ),
        ),
      ),
    );
  }

  CurvedNavigationBar buildNavBar(BuildContext context, Color? iconColor) {
    return CurvedNavigationBar(
      backgroundColor: context.theme.colorScheme.background,
      color: const Color(0xff3D4143),
      key: _bottomNavigationKey,
      index: _page,
      items: [
        Icon(Icons.add, size: 30, color: iconColor),
        Icon(Icons.list, size: 30, color: iconColor),
        Icon(Icons.compare_arrows, size: 30, color: iconColor),
      ],
      animationDuration: Duration(milliseconds: 400),
      height: 60,
      onTap: (index) {
        setState(() {
          _page = index;
        });
      },
    );
  }

  Column buildBody(BuildContext context) {
    return Column(
      children: [],
    );
  }

  buildItems() {
    return [
      Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AppImages.chmapBg,
                fit: BoxFit.cover,
                opacity: .5,
              ),
            ),
            child: ListTile(
              title: Text(
                'Champions',
              ),
            ),
          ),
        ),
      ),
      Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: .5,
                image: AppImages.runeBg,
                fit: BoxFit.cover,
              ),
            ),
            child: ListTile(
              title: Text(
                'Runes',
              ),
            ),
          ),
        ),
      ),
      Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: .2,
                image: AppImages.itemBg,
                fit: BoxFit.cover,
              ),
            ),
            child: GestureDetector(
              onTap: () => appRouter.push(AppRoutes.items),
              child: ListTile(
                title: Text(
                  'Items',
                ),
              ),
            ),
          ),
        ),
      ),
    ];
  }
}
