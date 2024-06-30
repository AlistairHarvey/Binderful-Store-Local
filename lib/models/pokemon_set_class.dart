import 'package:binderful_store/models/card_class.dart';

class PokemonSetData {
  PokemonSetData({
    required this.data,
    required this.page,
    required this.pageSize,
    required this.count,
    required this.totalCount,
  });

  factory PokemonSetData.fromJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List<dynamic>;
    final setList = dataList
        .map((item) => SetData.fromJson(item as Map<String, dynamic>))
        .toList();

    return PokemonSetData(
      data: setList,
      page: json['page'] as int,
      pageSize: json['pageSize'] as int,
      count: json['count'] as int,
      totalCount: json['totalCount'] as int,
    );
  }
  List<SetData> data;
  int page;
  int pageSize;
  int count;
  int totalCount;
}
