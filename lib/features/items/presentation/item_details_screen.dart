import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lol_dragon/context_extension.dart';
import 'package:lol_dragon/core/utils/app_images.dart';
import 'package:lol_dragon/features/items/data/dto/item.dart';
import 'dart:ui' as ui;

class ItemDetailsScreen extends StatelessWidget {
  final Item item;
  const ItemDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name!),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          // ...buildBackground(context, AppImages.itemImageWithFullName(item.image!.full!)),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image(
                          image: AppImages.itemImageWithFullName(item.image!.full!),
                          fit: BoxFit.cover,
                          width: 70.r,
                          height: 70.r,
                        ),
                      ),
                    ),
                  ],
                ),
                ItemDescriptionWidget(item: item),
                SizedBox(height: 10.h),
                if (item.fromItems.isNotEmpty)
                  Text.rich(
                    TextSpan(children: [
                      const TextSpan(text: 'Recipe: '),
                      ...item.fromItems
                          .map(
                            (e) => TextSpan(
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Card(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.r),
                                      child: Image(
                                        image: AppImages.itemImageWithFullName(e.image!.full!),
                                        fit: BoxFit.cover,
                                        width: 30.r,
                                        height: 30.r,
                                      ),
                                    ),
                                  ),
                                ),
                                const TextSpan(text: '+')
                              ],
                            ),
                          )
                          .toList(),
                      TextSpan(text: ' ${item.gold!.base} Gold')
                    ]),
                  ),
                if (item.toItems.isNotEmpty) const Text('Builds into:'),
                SizedBox(height: 10.h),
                Wrap(
                  children: item.toItems.map(
                    (e) {
                      return Tooltip(
                        decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10.r)),
                        triggerMode: TooltipTriggerMode.tap,
                        margin: EdgeInsets.symmetric(horizontal: 50.w),
                        // message: e.name!,
                        padding: EdgeInsets.all(10.r),
                        showDuration: const Duration(seconds: 10),
                        richMessage: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Image(
                                height: 35.r,
                                width: 35.r,
                                image: AppImages.itemImageWithFullName(e.image!.full!),
                              ),
                            ),
                            const TextSpan(text: '\n'),
                            TextSpan(
                                text: e.name!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: context.theme.colorScheme.onBackground)),
                            WidgetSpan(
                              child: ItemDescriptionWidget(
                                fontSize: 11.sp,
                                item: e,
                              ),
                            ),
                          ],
                        ),
                        child: Card(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image(
                              image: AppImages.itemImageWithFullName(e.image!.full!),
                              fit: BoxFit.cover,
                              width: 40.r,
                              height: 40.r,
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildBackground(BuildContext context, ImageProvider image) {
    return [
      Image(
        image: image,
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

class ItemDescriptionWidget extends StatelessWidget {
  final double? fontSize;

  const ItemDescriptionWidget({
    super.key,
    required this.item,
    this.fontSize,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Html(
      style: {'body': Style(margin: Margins.zero, padding: HtmlPaddings.zero, fontSize: FontSize(fontSize ?? 14.sp))},
      data: item.description!
          .replaceAll('mainText', 'p')
          .replaceAll('stats', 'p')
          .replaceAll('<li>', '<br>')
          .replaceAll('<br><br>', '<br>'),
      extensions: [
        TagExtension(
          tagsToExtend: {'attention'},
          builder: (p0) {
            return Text(
              '+${p0.innerHtml}',
              style: TextStyle(fontSize: fontSize),
            );
          },
        ),
        TagExtension(
          tagsToExtend: {'magicdamage'},
          builder: (p0) {
            return Text(p0.innerHtml,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize, color: Colors.deepPurple[300]));
          },
        ),
        TagExtension(
          tagsToExtend: {'passive', 'raritylegendary', 'keywordstealth', 'onhit'},
          builder: (p0) {
            return Text(p0.innerHtml, style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize));
          },
        ),
        TagExtension(
          tagsToExtend: {'raritymythic'},
          builder: (p0) {
            return Text(p0.innerHtml, style: TextStyle(color: Colors.deepOrange, fontSize: fontSize));
          },
        ),
        TagExtension(
          tagsToExtend: {'OnHit'},
          builder: (p0) {
            return Html(
              style: {'body': Style(margin: Margins.zero, padding: HtmlPaddings.zero)},
              data: p0.innerHtml,
              extensions: [
                TagExtension(
                  tagsToExtend: {'status'},
                  builder: (p0) {
                    return Text('${p0.innerHtml}:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize));
                  },
                ),
              ],
            );
          },
        ),
        TagExtension(
          tagsToExtend: {'status'},
          builder: (p0) {
            return Text('${p0.innerHtml}',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: p0.innerHtml.contains('Grievous Wounds') ? Colors.yellow[800] : null));
          },
        ),
        TagExtension(
          tagsToExtend: {'rules'},
          builder: (p0) {
            return Html(
              style: {
                'body': Style(margin: Margins.zero, padding: HtmlPaddings.zero, fontSize: FontSize(fontSize ?? 14.sp))
              },
              data: p0.innerHtml,
              extensions: [
                TagExtension(
                  tagsToExtend: {'status'},
                  builder: (p0) {
                    return Text('${p0.innerHtml}:', style: const TextStyle(fontWeight: FontWeight.bold));
                  },
                ),
              ],
            );
          },
        ),
        TagExtension.inline(
          tagsToExtend: {'active'},
          builder: (p0) {
            return TextSpan(
              text: p0.innerHtml,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                // color: Colors.blue,
              ),
            );
          },
        )
      ],
      // onlyRenderTheseTags: {'mainText', 'stats', 'attention', 'passive', 'OnHit', 'rules'},
      // doNotRenderTheseTags: {'br'},
    );
  }
}
