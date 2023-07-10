class Item {
  String? name;
  String? description;
  String? colloq;
  String? plaintext;
  List<String>? into;
  ItemImage? image;
  Gold? gold;
  List<String>? from;
  List<String>? tags;
  Maps? maps;
  Stats? stats;

  Item({
    this.name,
    this.description,
    this.colloq,
    this.plaintext,
    this.into,
    this.image,
    this.gold,
    this.tags,
    this.maps,
    this.stats,
  });

  Item.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    colloq = json['colloq'];
    plaintext = json['plaintext'];
    into = json['into'] != null ? (json['into'] as List<dynamic>).toList().cast<String>() : null;
    from = json['from'] != null ? (json['from'] as List<dynamic>).toList().cast<String>() : null;
    image = json['image'] != null ? ItemImage.fromJson(json['image']) : null;
    gold = json['gold'] != null ? Gold.fromJson(json['gold']) : null;
    into = json['tags'] != null ? (json['tags'] as List<dynamic>).toList().cast<String>() : null;
    maps = json['maps'] != null ? Maps.fromJson(json['maps']) : null;
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['description'] = description;
    data['colloq'] = colloq;
    data['plaintext'] = plaintext;
    data['into'] = into;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    if (gold != null) {
      data['gold'] = gold!.toJson();
    }
    data['tags'] = tags;
    if (maps != null) {
      data['maps'] = maps!.toJson();
    }
    if (stats != null) {
      data['stats'] = stats!.toJson();
    }
    return data;
  }
}

class ItemImage {
  String? full;
  String? sprite;
  String? group;
  int? x;
  int? y;
  int? w;
  int? h;

  ItemImage({this.full, this.sprite, this.group, this.x, this.y, this.w, this.h});

  ItemImage.fromJson(Map<String, dynamic> json) {
    full = json['full'];
    sprite = json['sprite'];
    group = json['group'];
    x = json['x'];
    y = json['y'];
    w = json['w'];
    h = json['h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['full'] = full;
    data['sprite'] = sprite;
    data['group'] = group;
    data['x'] = x;
    data['y'] = y;
    data['w'] = w;
    data['h'] = h;
    return data;
  }
}

class Gold {
  int? base;
  bool? purchasable;
  int? total;
  int? sell;

  Gold({this.base, this.purchasable, this.total, this.sell});

  Gold.fromJson(Map<String, dynamic> json) {
    base = json['base'];
    purchasable = json['purchasable'];
    total = json['total'];
    sell = json['sell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['base'] = base;
    data['purchasable'] = purchasable;
    data['total'] = total;
    data['sell'] = sell;
    return data;
  }
}

class Maps {
  bool? b11;
  bool? b12;
  bool? b21;
  bool? b22;

  Maps({this.b11, this.b12, this.b21, this.b22});

  Maps.fromJson(Map<String, dynamic> json) {
    b11 = json['11'];
    b12 = json['12'];
    b21 = json['21'];
    b22 = json['22'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['11'] = b11;
    data['12'] = b12;
    data['21'] = b21;
    data['22'] = b22;
    return data;
  }
}

class Stats {
  int? flatMovementSpeedMod;

  Stats({this.flatMovementSpeedMod});

  Stats.fromJson(Map<String, dynamic> json) {
    flatMovementSpeedMod = json['FlatMovementSpeedMod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['FlatMovementSpeedMod'] = flatMovementSpeedMod;
    return data;
  }
}
