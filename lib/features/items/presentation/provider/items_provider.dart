import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:lol_dragon/core/model/view_state.dart';

import '../../data/dto/item.dart';

class ItemsProvider with ChangeNotifier {
  final items = <String, Item>{};
  final filteredItems = <String, Item>{};
  ViewState state = ViewState.loading;

  Future<void> loadItems() async {
    final String response = await rootBundle.loadString('assets/data/item.json');
    final res = (await compute(parsItems, response));
    res.removeWhere((key, value) => value.gold!.purchasable == false);
    final temp = res;
    for (var element in temp.values) {
      if (element.into != null) {
        for (var itemId in element.into!) {
          if (res[itemId] != null) {
            element.toItems.add(res[itemId]!);
          }
        }
      }
      if (element.from != null) {
        for (var itemId in element.from!) {
          if (res[itemId] != null) {
            element.fromItems.add(res[itemId]!);
          }
        }
      }
    }
    items.addAll(res);
    filteredItems.addAll(res);
    log(filteredItems.length.toString());

    state = ViewState.idle;
    notifyListeners();
  }

  void filterItems(String value) {
    filteredItems.clear();
    if (value.isEmpty) {
      filteredItems.addAll(items);
      notifyListeners();
      return;
    }
    items.forEach((key, item) {
      // check if name contains value or any of the tags equals to value

      if (item.name!.toLowerCase().contains(value.toLowerCase()) ||
          item.tags!.any((element) => element.toLowerCase().contains(value.toLowerCase()))) {
        filteredItems[key] = item;
      }
    });
    log(filteredItems.length.toString());
    notifyListeners();
  }
}

Map<String, Item> parsItems(String responseBody) {
  final parsed = jsonDecode(responseBody);
  final data = (parsed['data'] as Map<String, dynamic>);
  return data.map((key, value) => MapEntry(key, Item.fromJson(value as Map<String, dynamic>)));
}
