import 'package:binderful_store/models/card_class.dart';

// This model is going to be mapped to another SB. This is because US pricing 
// is done differntly from the UK from a different data source.

class USAPricingHistory {
  USAPricingHistory({
    required this.pricingHistoryID,
    required this.setID,
    required this.updateDates,
    this.holofoilValues,
    this.reverseHolofoilValues,
    this.normalValues,
  });

  factory USAPricingHistory.fromJson(Map<String, dynamic> json) {
    return USAPricingHistory(
      pricingHistoryID: json['pricingHistoryID'] as String,
      setID: json['setID'] as String,
      updateDates: List<String>.from(
        (json['updateDates'] as List<String>).map((x) => x),
      ),
      holofoilValues: List<TcgPlayerPrices>.from(
        (json['holofoilValues'] as List<Map<String, dynamic>>)
            .map(TcgPlayerPrices.fromJson),
      ),
      reverseHolofoilValues: List<TcgPlayerPrices>.from(
        (json['reverseHolofoilValues'] as List<Map<String, dynamic>>)
            .map(TcgPlayerPrices.fromJson),
      ),
      normalValues: List<TcgPlayerPrices>.from(
        (json['normalValues'] as List<Map<String, dynamic>>)
            .map(TcgPlayerPrices.fromJson),
      ),
    );
  }
  String pricingHistoryID;
  String setID;
  List<String> updateDates;
  List<TcgPlayerPrices>? holofoilValues;
  List<TcgPlayerPrices>? reverseHolofoilValues;
  List<TcgPlayerPrices>? normalValues;

  Map<String, dynamic> toJson() {
    return {
      'pricingHistoryID': pricingHistoryID,
      'setID': setID,
      'updateDates': List<dynamic>.from(updateDates.map((x) => x,),),
      if (holofoilValues != null)
        'holofoilValues':
            List<dynamic>.from(holofoilValues!.map((x) => x.toJson())),
      if (reverseHolofoilValues != null)
        'reverseHolofoilValues':
            List<dynamic>.from(reverseHolofoilValues!.map((x) => x.toJson())),
      if (normalValues != null)
        'normalValues':
            List<dynamic>.from(normalValues!.map((x) => x.toJson())),
    };
  }
}
