import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:lol_dragon/context_extension.dart';
import 'package:lol_dragon/core/model/view_state.dart';
import 'dart:ui' as ui;

import 'package:lol_dragon/core/utils/app_images.dart';
import 'package:lol_dragon/core/widget/animated_open_container.dart';
import 'package:lol_dragon/features/items/presentation/item_details_screen.dart';
import 'package:lol_dragon/features/items/presentation/provider/items_provider.dart';
import 'package:provider/provider.dart';

import '../data/dto/item.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<ItemsProvider>(builder: (context, provider, _) {
          return Scaffold(
            body: AnimationLimiter(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    title: const Text('Items'),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SearchWidget(provider: provider),
                  ),
                  if (provider.state == ViewState.loading)
                    SliverToBoxAdapter(
                      child: Center(
                        child: SizedBox(
                          width: 40.r,
                          height: 40.r,
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: EdgeInsets.all(20.r),
                      sliver: SliverGrid.builder(
                        itemCount: provider.filteredItems.length,
                        itemBuilder: (context, index) {
                          final key = provider.filteredItems.keys.elementAt(index);
                          return AnimationConfiguration.staggeredGrid(
                            // delay: const Duration(milliseconds: 500),
                            columnCount: 5,
                            position: index,
                            duration: const Duration(milliseconds: 800),
                            child: ScaleAnimation(
                              // verticalOffset: 40.0,
                              child: FadeInAnimation(
                                child: buildItem(key, provider.filteredItems[key]!),
                              ),
                            ),
                          );
                        },
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                      ),
                    ),

                  // SliverAnimatedGrid(itemBuilder: itemBuilder, gridDelegate: gridDelegate)
                  // SliverLayoutBuilder(
                  //   builder: (context, constraints) {
                  //     return SearchBar();
                  //   },
                  // )
                  // buildBody()
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget buildBody() {
    return Consumer<ItemsProvider>(builder: (context, provider, _) {
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
        key: key,
        child: GridView.builder(
          padding: EdgeInsets.all(20.r),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
          shrinkWrap: true,
          itemCount: provider.filteredItems.length,
          itemBuilder: (BuildContext context, int index) {
            final key = provider.filteredItems.keys.elementAt(index);
            return AnimationConfiguration.staggeredGrid(
              delay: Duration(milliseconds: 100),
              columnCount: 5,
              position: index,
              duration: const Duration(milliseconds: 800),
              child: ScaleAnimation(
                // verticalOffset: 40.0,
                child: FadeInAnimation(
                  child: buildItem(key, provider.filteredItems[key]!),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  buildItem(String key, Item item) {
    return AnimatedOpenContainer(
      closedBuilder: (context, action) => Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image(
            image: AppImages.itemImage(key),
            fit: BoxFit.cover,
          ),
        ),
      ),
      openBuilder: (context, action) => ItemDetailsScreen(
        item: item,
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

class SearchWidget extends StatelessWidget {
  final ItemsProvider provider;
  const SearchWidget({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: TextField(
        onChanged: (value) {
          provider.filterItems(value);
        },
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }
}
