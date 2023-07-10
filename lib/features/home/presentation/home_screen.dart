import 'package:animate_do/animate_do.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lol_dragon/context_extension.dart';
import 'package:lol_dragon/core/utils/app_images.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FadeIn(
                    duration: const Duration(milliseconds: 800),
                    child: Image(
                      image: AppImages.leagueLogo,
                      width: 150.w,
                      height: 150.h,
                    ),
                  )
                ],
              ),
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
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: buildItems()[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildItems() {
    return [
      OpenContainerWrapper(
        openBuilder: (context, action) => const ItemsScreen(),
        closedBuilder: (context, action) => const HomeCard(
          image: AppImages.chmapBg,
          title: 'Champions',
        ),
      ),
      OpenContainerWrapper(
        openBuilder: (context, action) => const ItemsScreen(),
        closedBuilder: (context, action) => const HomeCard(
          image: AppImages.runeBg,
          title: 'Runes',
        ),
      ),
      OpenContainerWrapper(
        openBuilder: (context, action) => const ItemsScreen(),
        closedBuilder: (context, action) => const HomeCard(
          image: AppImages.itemBg,
          title: 'items',
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
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: .6,
              image: image,
              fit: BoxFit.cover,
            ),
          ),
          child: ListTile(
            title: Text(
              title,
            ),
          ),
        ),
      ),
    );
  }
}

class OpenContainerWrapper extends StatefulWidget {
  const OpenContainerWrapper({super.key, required this.closedBuilder, required this.openBuilder});
  final CloseContainerBuilder closedBuilder;
  final OpenContainerBuilder openBuilder;

  @override
  State<OpenContainerWrapper> createState() => _OpenContainerWrapperState();
}

class _OpenContainerWrapperState extends State<OpenContainerWrapper> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openBuilder: widget.openBuilder,
      closedColor: Colors.transparent,
      middleColor: context.theme.colorScheme.background,
      openColor: context.theme.colorScheme.background,
      closedElevation: 0,
      closedBuilder: widget.closedBuilder,
    );
  }
}
