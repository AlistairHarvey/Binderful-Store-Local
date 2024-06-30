// Pricing History from the RavenDB.

class PricingHistoryModel {
  PricingHistoryModel({
    required this.pricingHistoryID,
    required this.setID,
    required this.holoValues,
    required this.reverseHoloValues,
    required this.nonHoloValues,
    required this.firstEditionValues,
    required this.firstEditionShadowlessValues,
    required this.shadowlessValues,
    required this.print1999to2000Values,
    required this.updateDates,
  });

  factory PricingHistoryModel.fromJson(Map<String, dynamic> json) {
    return PricingHistoryModel(
      pricingHistoryID: json['pricingHistoryID'] as String? ?? '',
      setID: json['setID'] as String? ?? 'Missing',
      holoValues: (json['holoValues'] as List?)
              ?.map<double>((value) => double.tryParse(value.toString()) ?? 0.0)
              .toList() ??
          [],
      reverseHoloValues: (json['reverseHoloValues'] as List?)
              ?.map<double>((value) => double.tryParse(value.toString()) ?? 0.0)
              .toList() ??
          [],
      nonHoloValues: (json['nonHoloValues'] as List?)
              ?.map<double>((value) => double.tryParse(value.toString()) ?? 0.0)
              .toList() ??
          [],
      firstEditionValues: (json['firstEditionValues'] as List?)
              ?.map<double>((value) => double.tryParse(value.toString()) ?? 0.0)
              .toList() ??
          [],
      firstEditionShadowlessValues: (json['firstEditionShadowlessValues']
                  as List?)
              ?.map<double>((value) => double.tryParse(value.toString()) ?? 0.0)
              .toList() ??
          [],
      shadowlessValues: (json['shadowlessValues'] as List?)
              ?.map<double>((value) => double.tryParse(value.toString()) ?? 0.0)
              .toList() ??
          [],
      print1999to2000Values: (json['print1999to2000Values'] as List?)
              ?.map<double>((value) => double.tryParse(value.toString()) ?? 0.0)
              .toList() ??
          [],
      updateDates: (json['updateDates'] as List?)
              ?.map<String>((value) => value as String? ?? '')
              .toList() ??
          [],
    );
  }
  String pricingHistoryID;
  String setID;
  List<double> holoValues;
  List<double> reverseHoloValues;
  List<double> nonHoloValues;
  List<double> firstEditionValues;
  List<double> firstEditionShadowlessValues;
  List<double> shadowlessValues;
  List<double> print1999to2000Values;
  List<String> updateDates;

  Map<String, dynamic> toJson() {
    return {
      'pricingHistoryID': pricingHistoryID,
      'setID': setID,
      'holoValues': holoValues,
      'reverseHoloValues': reverseHoloValues,
      'nonHoloValues': nonHoloValues,
      'firstEditionValues': firstEditionValues,
      'firstEditionShadowlessValues': firstEditionShadowlessValues,
      'shadowlessValues': shadowlessValues,
      'print1999to2000Values': print1999to2000Values,
      'updateDates': updateDates,
    };
  }
}

class PricingHistoryUpdateDates {
  PricingHistoryUpdateDates({
    required this.setID,
    required this.lastUpdateDate,
    required this.pricingHistoryID,
  });

  factory PricingHistoryUpdateDates.fromJson(Map<String, dynamic> json) {
    return PricingHistoryUpdateDates(
      setID: json['setID'] as String?,
      lastUpdateDate: DateTime.parse(json['firstUpdateDate'] as String),
      pricingHistoryID: json['pricingHistoryID'] as String,
    );
  }
  final String? setID;
  final DateTime lastUpdateDate;
  final String pricingHistoryID;

  Map<String, dynamic> toJson() {
    return {
      'setID': setID,
      'firstUpdateDate': lastUpdateDate.toIso8601String(),
      'pricingHistoryID': pricingHistoryID,
    };
  }
}
