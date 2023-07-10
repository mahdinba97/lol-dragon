import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lol_dragon/context_extension.dart';
import 'package:lol_dragon/core/model/view_state.dart';
import 'dart:ui' as ui;

import 'package:lol_dragon/core/utils/app_images.dart';
import 'package:lol_dragon/features/items/presentation/provider/items_provider.dart';
import 'package:provider/provider.dart';

import '../../home/presentation/home_screen.dart';
import '../data/dto/item.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ...buildBackground(),
          ChangeNotifierProvider(
            create: (_) => ItemsProvider()..loadItems(),
            lazy: false,
            child: Consumer<ItemsProvider>(builder: (context, provider, _) {
              if (provider.state == ViewState.loading) {
                return Center(
                  child: SizedBox(
                    width: 40.r,
                    height: 40.r,
                    child: const CircularProgressIndicator(),
                  ),
                );
              }
              return AnimationLimiter(
                child: GridView.builder(
                  padding: EdgeInsets.all(20.r),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                  shrinkWrap: true,
                  itemCount: provider.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredGrid(
                      columnCount: 5,
                      position: index,
                      duration: const Duration(milliseconds: 800),
                      child: SlideAnimation(
                        verticalOffset: 40.0,
                        child: FadeInAnimation(
                          child: buildItem(provider.items.keys.elementAt(index)),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  buildItem(String name) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image(
          image: AssetImage('assets/images/items/$name.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  List<Widget> buildBackground() {
    return [
      Image(
        image: AppImages.itemBg,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.fitHeight,
      ),
      BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(
          color: context.theme.colorScheme.background.withOpacity(0.8),
        ),
      )
    ];
  }
}
