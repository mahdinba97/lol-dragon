import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:lol_dragon/context_extension.dart';
import 'package:lol_dragon/core/utils/app_images.dart';
import 'package:lol_dragon/router/app_routes.dart';

import '../../../core/widget/animated_open_container.dart';
import '../../items/presentation/items_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AppImages.homeBackground,
          fit: BoxFit.cover,
        )),
        padding: EdgeInsets.all(20.r),
        child: AnimationLimiter(
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                delay: Duration(milliseconds: 100),
                position: index,
                duration: const Duration(milliseconds: 1000),
                child: SlideAnimation(
                  verticalOffset: 40.0,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 5.h),
                      child: buildItems()[index],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  buildItems() {
    return [
      AnimatedOpenContainer(
        openBuilder: (context, action) => const ItemsScreen(),
        closedBuilder: (context, action) => Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: const HomeCard(
                  image: AppImages.chmapBg,
                  title: 'Champions',
                ),
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: Image(
                  image: AppImages.caitChamp,
                  height: 200,
                  opacity: AlwaysStoppedAnimation(.8),
                ))
          ],
        ),
      ),
      AnimatedOpenContainer(
        openBuilder: (context, action) => const ItemsScreen(),
        closedBuilder: (context, action) => Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: const HomeCard(
                  image: AppImages.chmapBg,
                  title: 'Runes',
                ),
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: Image(
                  image: AppImages.redRune,
                  height: 200,
                  opacity: AlwaysStoppedAnimation(.7),
                ))
          ],
        ),
      ),
      AnimatedOpenContainer(
        openBuilder: (context, action) => const ItemsScreen(),
        closedBuilder: (context, action) => Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: const HomeCard(
                  image: AppImages.chmapBg,
                  title: 'Items',
                ),
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: Image(
                  image: AppImages.prawler,
                  height: 200,
                  opacity: AlwaysStoppedAnimation(.5),
                ))
          ],
        ),
      ),
    ];
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.image,
    required this.title,
  });

  final ImageProvider image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          height: 150,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     opacity: .6,
          //     image: image,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp),
            ),
          ),
        ),
      ),
    );
  }
}
