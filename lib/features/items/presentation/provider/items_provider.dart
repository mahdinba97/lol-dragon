import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:lol_dragon/core/model/view_state.dart';

import '../../data/dto/item.dart';

class ItemsProvider with ChangeNotifier {
  final items = {};
  ViewState state = ViewState.loading;

  Future<void> loadItems() async {
    final String response = await rootBundle.loadString('assets/data/item.json');
    final res = await compute(parsItems, response);
    items.addAll(res);
    state = ViewState.idle;
    notifyListeners();
  }
}

Map<String, Item> parsItems(String responseBody) {
  final parsed = jsonDecode(responseBody);
  final data = (parsed['data'] as Map<String, dynamic>);
  return data.map((key, value) => MapEntry(key, Item.fromJson(value as Map<String, dynamic>)));
}
