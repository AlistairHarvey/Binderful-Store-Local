enum TgSetsType {
  bs,
  ar,
  lo,
  st,
}

extension TgSetsTypeString on TgSetsType {
  String get title {
    switch (this) {
      case TgSetsType.bs:
        return 'Brilliant Stars';
      case TgSetsType.ar:
        return 'Astral Radiance';
      case TgSetsType.lo:
        return 'Lost Origin';
      case TgSetsType.st:
        return 'Silver Tempest';
    }
  }
}
