// For the data being pulled from the Pokemon TCG API

class PokemonData {
  PokemonData({
    required this.data,
    required this.page,
    required this.pageSize,
    required this.count,
    required this.totalCount,
  });

  factory PokemonData.fromJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List<dynamic>;
    final pokemonList = dataList
        .map((item) => Pokemon.fromJson(item as Map<String, dynamic>))
        .toList();

    return PokemonData(
      data: pokemonList,
      page: json['page'] as int,
      pageSize: json['pageSize'] as int,
      count: json['count'] as int,
      totalCount: json['totalCount'] as int,
    );
  }
  List<Pokemon> data;
  int page;
  int pageSize;
  int count;
  int totalCount;
}

class Pokemon {
  Pokemon({
    required this.id, 
    required this.name, 
    required this.supertype, 
    required this.subtypes, 
    required this.hp, 
    required this.types, 
    required this.evolvesTo, 
    required this.rules,
    required this.attacks,
    required this.weaknesses,
    required this.retreatCost,
    required this.convertedRetreatCost,
    required this.set,
    required this.number, 
    required this.artist, 
    required this.rarity, 
    required this.nationalPokedexNumbers, 
    required this.legalities,
    required this.images, 
    required this.tcgplayer,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] as String,
      name: json['name'] as String,
      supertype: json['supertype'] as String,
      subtypes: List<String>.from(json['subtypes'] as List<dynamic>? ?? []),
      hp: json['hp'] as String? ?? '',
      types: List<String>.from(json['types'] as List<dynamic>? ?? []),
      evolvesTo: List<String>.from(json['evolvesTo'] as List<dynamic>? ?? []),
      rules: List<String>.from(json['rules'] as List<dynamic>? ?? []),
      attacks: (json['attacks'] as List<dynamic>? ?? [])
          .map((item) => Attack.fromJson(item as Map<String, dynamic>))
          .toList(),
      weaknesses: (json['weaknesses'] as List<dynamic>? ?? [])
          .map((item) => Weakness.fromJson(item as Map<String, dynamic>))
          .toList(),
      retreatCost:
          List<String>.from(json['retreatCost'] as List<dynamic>? ?? []),
      convertedRetreatCost: json['convertedRetreatCost'] as int? ?? 0,
      set: SetData.fromJson(json['set'] as Map<String, dynamic>),
      number: json['number'] as String,
      artist: json['artist'] as String? ?? '',
      rarity: json['rarity'] as String? ?? '',
      nationalPokedexNumbers: List<int>.from(
        json['nationalPokedexNumbers'] as List<dynamic>? ?? [],
      ),
      legalities:
          Legalities.fromJson(json['legalities'] as Map<String, dynamic>),
      images: Images.fromJson(json['images'] as Map<String, dynamic>),
      tcgplayer:
          TcgPlayer.fromJson(json['tcgplayer'] as Map<String, dynamic>? ?? {}),
    );
  }
  String id;
  String name;
  String supertype;
  List<String> subtypes;
  String hp;
  List<String> types;
  List<String> evolvesTo;
  List<String> rules;
  List<Attack> attacks;
  List<Weakness> weaknesses;
  List<String> retreatCost;
  int convertedRetreatCost;
  SetData set;
  String number;
  String artist;
  String rarity;
  List<int> nationalPokedexNumbers;
  Legalities legalities;
  Images images;
  TcgPlayer tcgplayer;
}

class Attack {
  Attack({
    required this.name,
    required this.cost,
    required this.convertedEnergyCost,
    required this.damage,
    required this.text,
  });

  factory Attack.fromJson(Map<String, dynamic> json) {
    return Attack(
      name: json['name'] as String,
      cost: List<String>.from(json['cost'] as List<dynamic>),
      convertedEnergyCost: json['convertedEnergyCost'] as int,
      damage: json['damage'] as String? ?? '',
      text: json['text'] as String? ?? '',
    );
  }
  String name;
  List<String> cost;
  int convertedEnergyCost;
  String damage;
  String text;
}

class Weakness {
  Weakness({
    required this.type,
    required this.value,
  });

  factory Weakness.fromJson(Map<String, dynamic> json) {
    return Weakness(
      type: json['type'] as String,
      value: json['value'] as String,
    );
  }
  String type;
  String value;
}

class Legalities {
  Legalities({
    required this.unlimited,
    required this.expanded,
  });

  factory Legalities.fromJson(Map<String, dynamic> json) {
    return Legalities(
      unlimited: json['unlimited'] as String,
      expanded: json['expanded'] as String? ?? '',
    );
  }
  String unlimited;
  String expanded;
}

class Images {
  Images({
    required this.small,
    required this.large,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      small: json['small'] as String,
      large: json['large'] as String,
    );
  }
  String small;
  String large;
}

class SetImages {
  SetImages({
    required this.symbol,
    required this.logo,
  });

  factory SetImages.fromJson(Map<String, dynamic> json) {
    return SetImages(
      symbol: json['symbol'] as String,
      logo: json['logo'] as String,
    );
  }
  String symbol;
  String logo;
}

class SetData {
  SetData({
    required this.id,
    required this.name,
    required this.series,
    required this.printedTotal,
    required this.total,
    required this.legalities,
    required this.ptcgoCode,
    required this.releaseDate,
    required this.updatedAt,
    required this.images,
  });

  factory SetData.fromJson(Map<String, dynamic> json) {
    return SetData(
      id: json['id'] as String,
      name: json['name'] as String,
      series: json['series'] as String,
      printedTotal: json['printedTotal'] as int,
      total: json['total'] as int,
      legalities:
          Legalities.fromJson(json['legalities'] as Map<String, dynamic>),
      ptcgoCode: json['ptcgoCode'] as String? ?? '',
      releaseDate: json['releaseDate'] as String,
      updatedAt: json['updatedAt'] as String,
      images: SetImages.fromJson(json['images'] as Map<String, dynamic>),
    );
  }
  String id;
  String name;
  String series;
  int printedTotal;
  int total;
  Legalities legalities;
  String ptcgoCode;
  String releaseDate;
  String updatedAt;
  SetImages images;
}

class TcgPlayer {
  TcgPlayer({
    required this.url,
    required this.updatedAt,
    required this.prices,
  });

  factory TcgPlayer.fromJson(Map<String, dynamic> json) {
    return TcgPlayer(
      url: json['url'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      prices: TcgPlayerPriceTypes.fromJson(
        json['prices'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
  String url;
  String updatedAt;
  TcgPlayerPriceTypes prices;
}

class TcgPlayerPriceTypes {
  TcgPlayerPriceTypes({this.holofoil, this.reverseHolofoil, this.normal});

  factory TcgPlayerPriceTypes.fromJson(Map<String, dynamic> json) {
    return TcgPlayerPriceTypes(
      holofoil: json['holofoil'] != null
          ? TcgPlayerPrices.fromJson(json['holofoil'] as Map<String, dynamic>)
          : null,
      reverseHolofoil: json['reverseHolofoil'] != null
          ? TcgPlayerPrices.fromJson(
              json['reverseHolofoil'] as Map<String, dynamic>,
            )
          : null,
      normal: json['normal'] != null
          ? TcgPlayerPrices.fromJson(json['normal'] as Map<String, dynamic>)
          : null,
    );
  }

  TcgPlayerPrices? holofoil;
  TcgPlayerPrices? reverseHolofoil;
  TcgPlayerPrices? normal;
}

class TcgPlayerPrices {
  TcgPlayerPrices({this.low, this.mid, this.high, this.market, this.directLow});

  factory TcgPlayerPrices.fromJson(Map<String, dynamic> json) {
    return TcgPlayerPrices(
      low: json['low'] as double?,
      mid: json['mid'] as double?,
      high: json['high'] as double?,
      market: json['market'] as double?,
      directLow: json['directLow'] as double?,
    );
  }
  double? low;
  double? mid;
  double? high;
  double? market;
  double? directLow;

  Map<String, dynamic> toJson() {
    return {
      'low': low,
      'mid': mid,
      'high': high,
      'market': market,
    };
  }
}

class MySetData {
  MySetData({
    required this.id,
    required this.name,
    required this.series,
    required this.printedTotal,
    required this.total,
    required this.legalities,
    required this.ptcgoCode,
    required this.releaseDate,
    required this.updatedAt,
    required this.images,
  });

  factory MySetData.fromSetData(SetData setData) {
    return MySetData(
      id: setData.id,
      name: setData.name,
      series: setData.series,
      printedTotal: setData.printedTotal,
      total: setData.total,
      legalities: [setData.legalities.unlimited, setData.legalities.expanded],
      ptcgoCode: setData.ptcgoCode,
      releaseDate: setData.releaseDate,
      updatedAt: setData.updatedAt,
      images: [setData.images.logo, setData.images.symbol],
    );
  }

  factory MySetData.fromJson(Map<String, dynamic> json) {
    return MySetData(
      id: json['setID'] as String,
      name: json['name'] as String,
      series: json['series'] as String,
      printedTotal: json['printedTotal'] as int,
      total: json['total'] as int,
      legalities: json['legalities'] as List<dynamic>,
      ptcgoCode: json['ptcgoCode'] as String? ?? '',
      releaseDate: json['releaseDate'] as String,
      updatedAt: json['updatedAt'] as String,
      images: json['images'] as List<dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'setID': id,
      'name': name,
      'series': series,
      'printedTotal': printedTotal,
      'total': total,
      'releaseDate': releaseDate,
      'updatedAt': updatedAt,
      'ptcgoCode': ptcgoCode,
      'legalities': legalities,
      'images': images,
    };
  }

  String id;
  String name;
  String series;
  int printedTotal;
  int total;
  List<dynamic> legalities;
  String ptcgoCode;
  String releaseDate;
  String updatedAt;
  List<dynamic> images;
  String? lastPriceUpdateDate;
}
