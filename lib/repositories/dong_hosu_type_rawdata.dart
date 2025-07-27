// repositories/dong_hosu_type_rawdata.dart

/// 동/호수/타입 매핑 데이터 모델
class UnitTypeInfo {
  final String dong;
  final String hosu;
  final String unitType;

  const UnitTypeInfo({
    required this.dong,
    required this.hosu,
    required this.unitType,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnitTypeInfo &&
          runtimeType == other.runtimeType &&
          dong == other.dong &&
          hosu == other.hosu;

  @override
  int get hashCode => dong.hashCode ^ hosu.hashCode;

  @override
  String toString() => 'UnitTypeInfo(동: $dong, 호수: $hosu, 타입: $unitType)';
}

/// 동/호수/타입 원시 데이터 관리 클래스
class DongHosuTypeRawdata {
  // 실제 데이터 (paste-3.txt에서 가져온 데이터)
  static const List<UnitTypeInfo> _rawData = [
    // 101동
    UnitTypeInfo(dong: '101', hosu: '0101', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '0201', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '0301', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '0401', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '0501', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '0601', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '0701', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '0801', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '0901', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1001', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1101', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1201', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1301', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1401', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1501', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1601', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1701', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1801', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1901', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '2001', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '2101', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '2201', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '2301', unitType: '84A'),

    UnitTypeInfo(dong: '101', hosu: '0102', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '0202', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '0302', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '0402', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '0502', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '0602', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '0702', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '0802', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '0902', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1002', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1102', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1202', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1302', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1402', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1502', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1602', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1702', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1802', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1902', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '2002', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '2102', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '2202', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '2302', unitType: '84B'),

    UnitTypeInfo(dong: '101', hosu: '0103', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '0203', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '0303', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '0403', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '0503', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '0603', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '0703', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '0803', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '0903', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1003', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1103', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1203', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1303', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1403', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1503', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1603', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1703', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1803', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '1903', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '2003', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '2103', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '2203', unitType: '84B'),
    UnitTypeInfo(dong: '101', hosu: '2303', unitType: '84B'),

    UnitTypeInfo(dong: '101', hosu: '0304', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '0404', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '0504', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '0604', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '0704', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '0804', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '0904', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1004', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1104', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1204', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1304', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1404', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1504', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1604', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1704', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1804', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '1904', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '2004', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '2104', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '2204', unitType: '84A'),
    UnitTypeInfo(dong: '101', hosu: '2304', unitType: '84A'),

    // 102동
    UnitTypeInfo(dong: '102', hosu: '0101', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '0201', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '0301', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '0401', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '0501', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '0601', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '0701', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '0801', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '0901', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1001', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1101', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1201', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1301', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1401', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1501', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1601', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1701', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1801', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1901', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '2001', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '2101', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '2201', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '2301', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '2401', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '2501', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '2601', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '2701', unitType: '84A'),

    UnitTypeInfo(dong: '102', hosu: '0102', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '0202', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '0302', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '0402', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '0502', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '0602', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '0702', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '0802', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '0902', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1002', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1102', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1202', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1302', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1402', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1502', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1602', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1702', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1802', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1902', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '2002', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '2102', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '2202', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '2302', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '2402', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '2502', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '2602', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '2702', unitType: '84B'),

    UnitTypeInfo(dong: '102', hosu: '0103', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '0203', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '0303', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '0403', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '0503', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '0603', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '0703', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '0803', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '0903', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1003', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1103', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1203', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1303', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1403', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1503', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1603', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1703', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1803', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '1903', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '2003', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '2103', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '2203', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '2303', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '2403', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '2503', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '2603', unitType: '84B'),
    UnitTypeInfo(dong: '102', hosu: '2703', unitType: '84B'),

    UnitTypeInfo(dong: '102', hosu: '0304', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '0404', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '0504', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '0604', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '0704', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '0804', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '0904', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1004', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1104', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1204', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1304', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1404', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1504', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1604', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1704', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1804', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '1904', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '2004', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '2104', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '2204', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '2304', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '2404', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '2504', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '2604', unitType: '84A'),
    UnitTypeInfo(dong: '102', hosu: '2704', unitType: '84A'),

    // 103동
    UnitTypeInfo(dong: '103', hosu: '0101', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '0201', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '0301', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '0401', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '0501', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '0601', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '0701', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '0801', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '0901', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1001', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1101', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1201', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1301', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1401', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1501', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1601', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1701', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1801', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1901', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '2001', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '2101', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '2201', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '2301', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '2401', unitType: '84A'),

    UnitTypeInfo(dong: '103', hosu: '0102', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '0202', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '0302', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '0402', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '0502', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '0602', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '0702', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '0802', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '0902', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1002', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1102', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1202', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1302', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1402', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1502', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1602', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1702', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1802', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1902', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '2002', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '2102', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '2202', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '2302', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '2402', unitType: '84C'),

    UnitTypeInfo(dong: '103', hosu: '0103', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '0203', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '0303', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '0403', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '0503', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '0603', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '0703', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '0803', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '0903', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1003', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1103', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1203', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1303', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1403', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1503', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1603', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1703', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1803', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '1903', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '2003', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '2103', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '2203', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '2303', unitType: '84C'),
    UnitTypeInfo(dong: '103', hosu: '2403', unitType: '84C'),

    UnitTypeInfo(dong: '103', hosu: '0104', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '0204', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '0304', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '0404', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '0504', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '0604', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '0704', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '0804', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '0904', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1004', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1104', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1204', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1304', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1404', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1504', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1604', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1704', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1804', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '1904', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '2004', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '2104', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '2204', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '2304', unitType: '84A'),
    UnitTypeInfo(dong: '103', hosu: '2404', unitType: '84A'),

    // 104동
    UnitTypeInfo(dong: '104', hosu: '0101', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '0201', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '0301', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '0401', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '0501', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '0601', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '0701', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '0801', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '0901', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1001', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1101', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1201', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1301', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1401', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1501', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1601', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1701', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1801', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1901', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '2001', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '2101', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '2201', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '2301', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '2401', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '2501', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '2601', unitType: '63'),

    UnitTypeInfo(dong: '104', hosu: '0102', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '0202', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '0302', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '0402', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '0502', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '0602', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '0702', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '0802', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '0902', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1002', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1102', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1202', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1302', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1402', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1502', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1602', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1702', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1802', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1902', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '2002', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '2102', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '2202', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '2302', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '2402', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '2502', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '2602', unitType: '61'),

    UnitTypeInfo(dong: '104', hosu: '0103', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '0203', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '0303', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '0403', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '0503', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '0603', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '0703', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '0803', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '0903', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1003', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1103', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1203', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1303', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1403', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1503', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1603', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1703', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1803', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '1903', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '2003', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '2103', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '2203', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '2303', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '2403', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '2503', unitType: '61'),
    UnitTypeInfo(dong: '104', hosu: '2603', unitType: '61'),

    UnitTypeInfo(dong: '104', hosu: '0104', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '0204', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '0304', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '0404', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '0504', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '0604', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '0704', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '0804', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '0904', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1004', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1104', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1204', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1304', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1404', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1504', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1604', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1704', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1804', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '1904', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '2004', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '2104', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '2204', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '2304', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '2404', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '2504', unitType: '63'),
    UnitTypeInfo(dong: '104', hosu: '2604', unitType: '63'),

    // 105동
    UnitTypeInfo(dong: '105', hosu: '0101', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '0201', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '0301', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '0401', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '0501', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '0601', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '0701', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '0801', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '0901', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1001', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1101', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1201', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1301', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1401', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1501', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1601', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1701', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1801', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1901', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '2001', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '2101', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '2201', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '2301', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '2401', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '2501', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '2601', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '2701', unitType: '84A'),

    UnitTypeInfo(dong: '105', hosu: '0102', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '0202', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '0302', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '0402', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '0502', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '0602', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '0702', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '0802', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '0902', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1002', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1102', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1202', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1302', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1402', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1502', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1602', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1702', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1802', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1902', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '2002', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '2102', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '2202', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '2302', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '2402', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '2502', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '2602', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '2702', unitType: '84B'),

    UnitTypeInfo(dong: '105', hosu: '0103', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '0203', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '0303', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '0403', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '0503', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '0603', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '0703', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '0803', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '0903', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1003', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1103', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1203', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1303', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1403', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1503', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1603', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1703', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1803', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '1903', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '2003', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '2103', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '2203', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '2303', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '2403', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '2503', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '2603', unitType: '84B'),
    UnitTypeInfo(dong: '105', hosu: '2703', unitType: '84B'),

    UnitTypeInfo(dong: '105', hosu: '0304', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '0404', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '0504', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '0604', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '0704', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '0804', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '0904', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1004', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1104', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1204', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1304', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1404', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1504', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1604', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1704', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1804', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '1904', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '2004', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '2104', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '2204', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '2304', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '2404', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '2504', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '2604', unitType: '84A'),
    UnitTypeInfo(dong: '105', hosu: '2704', unitType: '84A'),
  ];

  // 효율적인 검색을 위한 Map 캐시
  static final Map<String, UnitTypeInfo> _dataMap = {
    for (var item in _rawData) '${item.dong}-${item.hosu}': item,
  };

  /// 동과 호수로 유닛 타입 조회
  ///
  /// [dong] 동 번호 (예: '101', '102')
  /// [hosu] 호수 (예: '0101', '1205')
  ///
  /// 반환값: 유닛 타입 (예: '84A', '84B', '84C', '61', '63') 또는 null
  static String? getUnitType(String dong, String hosu) {
    // 입력값 정리 (공백 제거, 0 패딩)
    final cleanDong = dong.trim();
    final cleanHosu = hosu.trim().padLeft(4, '0'); // 4자리로 패딩

    final key = '$cleanDong-$cleanHosu';
    return _dataMap[key]?.unitType;
  }

  /// 특정 동의 모든 호수 정보 조회
  ///
  /// [dong] 동 번호
  ///
  /// 반환값: 해당 동의 모든 UnitTypeInfo 리스트
  static List<UnitTypeInfo> getUnitsByDong(String dong) {
    final cleanDong = dong.trim();
    return _rawData.where((item) => item.dong == cleanDong).toList();
  }

  /// 특정 유닛 타입의 모든 호수 정보 조회
  ///
  /// [unitType] 유닛 타입 (예: '84A', '84B', '84C', '61', '63')
  ///
  /// 반환값: 해당 타입의 모든 UnitTypeInfo 리스트
  static List<UnitTypeInfo> getUnitsByType(String unitType) {
    return _rawData.where((item) => item.unitType == unitType).toList();
  }

  /// 사용 가능한 모든 동 번호 조회
  ///
  /// 반환값: 중복 제거된 동 번호 리스트
  static List<String> getAvailableDongs() {
    return _rawData.map((item) => item.dong).toSet().toList()..sort();
  }

  /// 사용 가능한 모든 유닛 타입 조회
  ///
  /// 반환값: 중복 제거된 유닛 타입 리스트
  static List<String> getAvailableUnitTypes() {
    return _rawData.map((item) => item.unitType).toSet().toList()..sort();
  }

  /// 특정 동에서 사용 가능한 호수 리스트 조회
  ///
  /// [dong] 동 번호
  ///
  /// 반환값: 해당 동의 호수 리스트 (정렬됨)
  static List<String> getAvailableHosuByDong(String dong) {
    final cleanDong = dong.trim();
    return _rawData
        .where((item) => item.dong == cleanDong)
        .map((item) => item.hosu)
        .toList()
      ..sort();
  }

  /// 전체 데이터 개수
  static int get totalCount => _rawData.length;

  /// 동/호수 조합이 유효한지 확인
  ///
  /// [dong] 동 번호
  /// [hosu] 호수
  ///
  /// 반환값: 유효하면 true, 그렇지 않으면 false
  static bool isValidUnit(String dong, String hosu) {
    return getUnitType(dong, hosu) != null;
  }

  /// 디버깅을 위한 데이터 요약 정보
  static Map<String, dynamic> getDataSummary() {
    final dongCount = getAvailableDongs().length;
    final unitTypeCount = getAvailableUnitTypes().length;
    final totalUnits = totalCount;

    final unitTypeCounts = <String, int>{};
    for (final unitType in getAvailableUnitTypes()) {
      unitTypeCounts[unitType] = getUnitsByType(unitType).length;
    }

    return {
      'totalUnits': totalUnits,
      'dongCount': dongCount,
      'unitTypeCount': unitTypeCount,
      'availableDongs': getAvailableDongs(),
      'availableUnitTypes': getAvailableUnitTypes(),
      'unitTypeCounts': unitTypeCounts,
    };
  }
}
