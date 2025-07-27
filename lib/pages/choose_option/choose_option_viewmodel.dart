import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/type_detail_option.dart';
// rawdata.dart import 추가
import '../../repositories/apartment_option_rawdata.dart';

// State 클래스
class ChooseOptionState {
  // 이전 페이지에서 가져온 정보
  final String dong;
  final String hosu;
  final String? name;
  final String unitType;

  // 현재 페이지 상태 - 라디오 버튼 방식 (평형별 다른 옵션)
  final String bedroomType; // "침실분리형" or "거실통합형" (84평형 전용)
  final String alphaRoomType; // "알파룸2분리형" or "거실통합형" (84평형 전용)
  final String bedroom2Type; // "침실2분리형" or "거실통합형" (61,63평형 전용)
  final bool isTypeConfirmed; // 평형 타입 확정 여부
  final bool isLoading;
  final String? error;

  // 발코니 확장 가격 (rawdata에서 가져옴)
  final int expansionPrice;

  // 세부 옵션 관련
  final List<OptionModel> availableOptions; // 사용 가능한 옵션들
  final Map<int, int> selectedOptions; // 선택된 옵션들 (optionId -> detailIndex)
  final Map<int, bool> expandedOptions; // 확장된 드롭다운들 (optionId -> isExpanded)

  // 가격 정보
  final int basePrice; // 기본 분양가
  final int selectedOptionsPrice; // 선택된 옵션들의 총 가격
  final int totalPrice; // 기본가 + 발코니확장가 + 옵션가격
  final int contractPrice; // 계약금 (총액의 10%)

  const ChooseOptionState({
    required this.dong,
    required this.hosu,
    this.name,
    required this.unitType,
    this.bedroomType = "거실통합형", // 기본값
    this.alphaRoomType = "거실통합형", // 기본값
    this.bedroom2Type = "거실통합형", // 기본값
    this.isTypeConfirmed = false, // 기본값: 미확정
    this.isLoading = false,
    this.error,
    this.expansionPrice = 0,
    this.availableOptions = const [],
    this.selectedOptions = const {},
    this.expandedOptions = const {},
    this.basePrice = 0, // 1억 (임시)
    this.selectedOptionsPrice = 0,
    this.totalPrice = 0,
    this.contractPrice = 0,
  });

  // 평형별 표시 여부 판단 헬퍼
  bool get is84Type => unitType.contains('84'); // 84A, 84B, 84C평형
  bool get is61or63Type =>
      unitType.contains('61') || unitType.contains('63'); // 61, 63평형

  // 발코니 확장 정보 표시용
  String get expansionTitle {
    if (is84Type) {
      return "발코니 확장";
    } else {
      return "발코니 확장";
    }
  }

  String get expansionDescription {
    if (is84Type) {
      return "$unitType 타입 발코니 확장 공사비 (필수)";
    } else {
      return "$unitType 타입 발코니 확장 공사비 (필수)";
    }
  }

  // 옵션 관련 헬퍼 메소드들
  int getSelectedDetailIndex(int optionId) {
    return selectedOptions[optionId] ?? 0; // 기본값: 미선택 (index 0)
  }

  bool isOptionExpanded(int optionId) {
    return expandedOptions[optionId] ?? false;
  }

  DetailedOptionModel? getSelectedDetail(int optionId) {
    final option = availableOptions.firstWhere(
      (opt) => opt.id == optionId,
      orElse: () => OptionModel(id: optionId),
    );

    if (option.detailedOption == null || option.detailedOption!.isEmpty) {
      return null;
    }

    final selectedIndex = getSelectedDetailIndex(optionId);
    if (selectedIndex < option.detailedOption!.length) {
      return option.detailedOption![selectedIndex];
    }
    return null;
  }

  String getOptionDisplayPrice(int optionId) {
    final selectedDetail = getSelectedDetail(optionId);
    if (selectedDetail == null || selectedDetail.price == 0) {
      return "미선택";
    }
    return "+${_formatPrice(selectedDetail.price)}원";
  }

  bool isOptionSelected(int optionId) {
    final selectedDetail = getSelectedDetail(optionId);
    return selectedDetail != null && selectedDetail.price > 0;
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  ChooseOptionState copyWith({
    String? dong,
    String? hosu,
    String? name,
    String? unitType,
    String? bedroomType,
    String? alphaRoomType,
    String? bedroom2Type,
    bool? isTypeConfirmed,
    bool? isLoading,
    String? error,
    int? expansionPrice,
    List<OptionModel>? availableOptions,
    Map<int, int>? selectedOptions,
    Map<int, bool>? expandedOptions,
    int? basePrice,
    int? selectedOptionsPrice,
    int? totalPrice,
    int? contractPrice,
  }) {
    return ChooseOptionState(
      dong: dong ?? this.dong,
      hosu: hosu ?? this.hosu,
      name: name ?? this.name,
      unitType: unitType ?? this.unitType,
      bedroomType: bedroomType ?? this.bedroomType,
      alphaRoomType: alphaRoomType ?? this.alphaRoomType,
      bedroom2Type: bedroom2Type ?? this.bedroom2Type,
      isTypeConfirmed: isTypeConfirmed ?? this.isTypeConfirmed,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      expansionPrice: expansionPrice ?? this.expansionPrice,
      availableOptions: availableOptions ?? this.availableOptions,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      expandedOptions: expandedOptions ?? this.expandedOptions,
      basePrice: basePrice ?? this.basePrice,
      selectedOptionsPrice: selectedOptionsPrice ?? this.selectedOptionsPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      contractPrice: contractPrice ?? this.contractPrice,
    );
  }
}

// ViewModel 클래스
class ChooseOptionViewModel extends StateNotifier<ChooseOptionState> {
  ChooseOptionViewModel({
    required String dong,
    required String hosu,
    String? name,
    required String unitType,
  }) : super(
         ChooseOptionState(
           dong: dong,
           hosu: hosu,
           name: name,
           unitType: unitType,
         ),
       ) {
    _loadExpansionPrice();
  }

  // 발코니 확장 가격 로드
  void _loadExpansionPrice() {
    // rawdata에서 해당 type의 첫 번째 항목의 expansionPrice 가져오기
    final typeData = ApartmentOptionRawData.data
        .where((item) => item['type'] == state.unitType)
        .first;

    final expansionPrice = typeData['expansionPrice'] as int;

    state = state.copyWith(
      expansionPrice: expansionPrice,
      totalPrice: state.basePrice + expansionPrice,
      contractPrice: ((state.basePrice + expansionPrice) * 0.1).round(),
    );

    print(
      '✅ 발코니 확장 가격 로드: ${state.unitType} - ${_formatPrice(expansionPrice)}원',
    );
  }

  // 침실 타입 선택 (라디오 버튼) - 확정 전에만 가능 (84평형 전용)
  void selectBedroomType(String type) {
    if (state.isTypeConfirmed) {
      print('⚠️ 평형 타입이 이미 확정되어 변경할 수 없습니다.');
      return;
    }

    state = state.copyWith(bedroomType: type);
    print('침실 타입 선택: $type');
  }

  // 알파룸 타입 선택 (라디오 버튼) - 확정 전에만 가능 (84평형 전용)
  void selectAlphaRoomType(String type) {
    if (state.isTypeConfirmed) {
      print('⚠️ 평형 타입이 이미 확정되어 변경할 수 없습니다.');
      return;
    }

    state = state.copyWith(alphaRoomType: type);
    print('알파룸 타입 선택: $type');
  }

  // 침실2 타입 선택 (라디오 버튼) - 확정 전에만 가능 (61,63평형 전용)
  void selectBedroom2Type(String type) {
    if (state.isTypeConfirmed) {
      print('⚠️ 평형 타입이 이미 확정되어 변경할 수 없습니다.');
      return;
    }

    state = state.copyWith(bedroom2Type: type);
    print('침실2 타입 선택: $type');
  }

  // 평형 타입 확정
  void confirmTypeSelection() {
    if (state.isTypeConfirmed) {
      print('⚠️ 이미 확정된 상태입니다.');
      return;
    }

    state = state.copyWith(isTypeConfirmed: true);
    print('✅ 평형 타입 확정됨:');

    if (state.is84Type) {
      print('  - 침실: ${state.bedroomType}');
      print('  - 알파룸: ${state.alphaRoomType}');
    } else if (state.is61or63Type) {
      print('  - 침실2: ${state.bedroom2Type}');
    }

    // 확정 후 해당 조건에 맞는 옵션 데이터 로드
    _loadOptionsForSelection();
  }

  // 평형 타입 확정 해제 (필요시)
  void resetTypeSelection() {
    state = state.copyWith(
      isTypeConfirmed: false,
      availableOptions: [],
      selectedOptions: {},
      expandedOptions: {},
      selectedOptionsPrice: 0,
    );
    _recalculatePrice();
    print('🔄 평형 타입 확정 해제 - 다시 선택 가능');
  }

  // 선택된 조건에 맞는 옵션 데이터 로드
  void _loadOptionsForSelection() {
    // bedSep, alphaSep 결정
    bool bedSep;
    bool? alphaSep;

    if (state.is84Type) {
      // 84평형의 경우
      bedSep = state.bedroomType == "침실분리형";
      alphaSep = state.alphaRoomType == "알파룸2분리형";
    } else if (state.is61or63Type) {
      // 61,63평형의 경우
      bedSep = state.bedroom2Type == "침실2분리형";
      alphaSep = null; // 61,63평형은 alphaSep 없음
    } else {
      bedSep = false;
      alphaSep = null;
    }

    // rawdata에서 해당 조건의 데이터 찾기
    final apartmentData = ApartmentOptionRawData.getApartmentData(
      type: state.unitType,
      bedSep: bedSep,
      alphaSep: alphaSep,
    );

    if (apartmentData != null) {
      print('✅ 옵션 데이터 로드 성공:');
      print('  - Type: ${state.unitType}');
      print('  - bedSep: $bedSep');
      print('  - alphaSep: $alphaSep');

      // option 데이터를 OptionModel 리스트로 변환
      final rawOptions = apartmentData['option'] as List;
      final availableOptions = <OptionModel>[];

      for (final rawOption in rawOptions) {
        // desc가 null이 아닌 것만 추가
        if (rawOption['desc'] != null) {
          availableOptions.add(OptionModel.fromJson(rawOption));
        }
      }

      print('  - 유효한 옵션 개수: ${availableOptions.length}');

      state = state.copyWith(
        availableOptions: availableOptions,
        selectedOptions: {}, // 선택 초기화
        expandedOptions: {}, // 확장 상태 초기화
        selectedOptionsPrice: 0,
      );

      _recalculatePrice();
    } else {
      print('❌ 해당 조건의 옵션 데이터를 찾을 수 없습니다.');
      state = state.copyWith(error: '해당 조건의 옵션 데이터를 찾을 수 없습니다.');
    }
  }

  // 드롭다운 토글
  void toggleOptionExpansion(int optionId) {
    final currentExpanded = state.expandedOptions[optionId] ?? false;
    final newExpandedOptions = Map<int, bool>.from(state.expandedOptions);
    newExpandedOptions[optionId] = !currentExpanded;

    state = state.copyWith(expandedOptions: newExpandedOptions);
  }

  // 세부 옵션 선택
  void selectDetailOption(int optionId, int detailIndex) {
    final newSelectedOptions = Map<int, int>.from(state.selectedOptions);
    newSelectedOptions[optionId] = detailIndex;

    state = state.copyWith(selectedOptions: newSelectedOptions);

    // 선택 후 드롭다운 자동 닫기
    final newExpandedOptions = Map<int, bool>.from(state.expandedOptions);
    newExpandedOptions[optionId] = false;
    state = state.copyWith(expandedOptions: newExpandedOptions);

    _recalculatePrice();

    final option = state.availableOptions.firstWhere(
      (opt) => opt.id == optionId,
    );
    final selectedDetail = option.detailedOption![detailIndex];
    print(
      '✅ 옵션 선택: ${option.desc} -> ${selectedDetail.desc} (+${_formatPrice(selectedDetail.price)}원)',
    );
  }

  // 옵션 선택 해제
  void clearOption(int optionId) {
    selectDetailOption(optionId, 0); // 0번 인덱스는 "미선택"
  }

  // 가격 재계산
  void _recalculatePrice() {
    int selectedOptionsPrice = 0;

    for (final entry in state.selectedOptions.entries) {
      final optionId = entry.key;
      final detailIndex = entry.value;

      final option = state.availableOptions.firstWhere(
        (opt) => opt.id == optionId,
        orElse: () => OptionModel(id: optionId),
      );

      if (option.detailedOption != null &&
          detailIndex < option.detailedOption!.length) {
        selectedOptionsPrice += option.detailedOption![detailIndex].price;
      }
    }

    final totalPrice =
        state.basePrice + state.expansionPrice + selectedOptionsPrice;
    final contractPrice = (totalPrice * 0.1).round();

    state = state.copyWith(
      selectedOptionsPrice: selectedOptionsPrice,
      totalPrice: totalPrice,
      contractPrice: contractPrice,
    );
  }

  // 가격 포맷팅 (천 단위 콤마)
  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  // 에러 초기화
  void clearError() {
    state = state.copyWith(error: null);
  }

  // 다음 단계로 진행 (견적서 확인)
  Future<bool> proceedToNext() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      print('=== 최종 선택 정보 ===');
      print('📍 기본 정보:');
      print('  - 동/호수: ${state.dong}동 ${state.hosu}호');
      print('  - 평형: ${state.unitType}');
      if (state.name != null && state.name!.isNotEmpty) {
        print('  - 계약자: ${state.name}');
      }

      print('🏠 가변형 벽체 선택:');
      if (state.is84Type) {
        print('  - 침실 타입: ${state.bedroomType}');
        print('  - 알파룸 타입: ${state.alphaRoomType}');
      } else if (state.is61or63Type) {
        print('  - 침실2 타입: ${state.bedroom2Type}');
      }

      print('🎯 선택된 옵션들:');
      for (final entry in state.selectedOptions.entries) {
        final optionId = entry.key;
        final detailIndex = entry.value;

        if (detailIndex > 0) {
          // 미선택이 아닌 경우만
          final option = state.availableOptions.firstWhere(
            (opt) => opt.id == optionId,
          );
          final selectedDetail = option.detailedOption![detailIndex];
          print(
            '  - ${option.desc}: ${selectedDetail.desc} (+${_formatPrice(selectedDetail.price)}원)',
          );
        }
      }

      print('💰 가격 정보:');
      print('  - 기본 분양가: ${_formatPrice(state.basePrice)}원');
      print('  - 발코니 확장: +${_formatPrice(state.expansionPrice)}원');
      print('  - 선택 옵션: +${_formatPrice(state.selectedOptionsPrice)}원');
      print('  - 총 분양가: ${_formatPrice(state.totalPrice)}원');
      print('  - 계약금 (10%): ${_formatPrice(state.contractPrice)}원');
      print('========================');

      // 서버 전송 시뮬레이션
      await Future.delayed(const Duration(milliseconds: 500));

      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: '저장 중 오류가 발생했습니다.');
      return false;
    }
  }
}

// Provider Factory - Family provider로 변경하여 매개변수 받기
final chooseOptionViewModelProvider =
    StateNotifierProvider.family<
      ChooseOptionViewModel,
      ChooseOptionState,
      Map<String, dynamic>
    >((ref, params) {
      return ChooseOptionViewModel(
        dong: params['dong'] as String,
        hosu: params['hosu'] as String,
        name: params['name'] as String?,
        unitType: params['unitType'] as String,
      );
    });
