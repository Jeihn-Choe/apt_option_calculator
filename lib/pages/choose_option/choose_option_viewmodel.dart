import 'package:flutter_riverpod/flutter_riverpod.dart';

// 옵션 아이템 모델
class OptionItem {
  final String id;
  final String title;
  final String description;
  final int price;
  final bool isSelected;

  const OptionItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.isSelected = false,
  });

  OptionItem copyWith({
    String? id,
    String? title,
    String? description,
    int? price,
    bool? isSelected,
  }) {
    return OptionItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

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
  final List<OptionItem> options;
  final bool isLoading;
  final String? error;

  // 가격 정보
  final int basePrice; // 기본 분양가
  final int totalOptionsPrice; // 선택된 옵션들의 총 가격
  final int totalPrice; // 기본가 + 옵션가
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
    this.options = const [],
    this.isLoading = false,
    this.error,
    this.basePrice = 100000000, // 1억 (임시)
    this.totalOptionsPrice = 0,
    this.totalPrice = 100000000,
    this.contractPrice = 10000000,
  });

  // 평형별 표시 여부 판단 헬퍼
  bool get is84Type => unitType.contains('84'); // 84A, 84B, 84C평형
  bool get is61or63Type =>
      unitType.contains('61') || unitType.contains('63'); // 61, 63평형

  ChooseOptionState copyWith({
    String? dong,
    String? hosu,
    String? name,
    String? unitType,
    String? bedroomType,
    String? alphaRoomType,
    String? bedroom2Type,
    bool? isTypeConfirmed,
    List<OptionItem>? options,
    bool? isLoading,
    String? error,
    int? basePrice,
    int? totalOptionsPrice,
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
      options: options ?? this.options,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      basePrice: basePrice ?? this.basePrice,
      totalOptionsPrice: totalOptionsPrice ?? this.totalOptionsPrice,
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
    _loadOptions();
  }

  // 초기 옵션 데이터 로드
  void _loadOptions() {
    final mockOptions = [
      OptionItem(
        id: 'system_aircon',
        title: '시스템에어컨',
        description: '거실, 침실1, 침실2, 침실3 [4계소] (LG전자)',
        price: 6830000,
      ),
      OptionItem(
        id: 'bedroom2_vivia',
        title: '침실2분비아',
        description: '침실2 분비아(수납형)',
        price: 1900000,
      ),
      OptionItem(
        id: 'entrance_door',
        title: '현관중문',
        description: '현관 중문 설치',
        price: 2400000,
      ),
      OptionItem(
        id: 'floor_upgrade',
        title: '바닥재 업그레이드',
        description: '프리미엄 바닥재로 업그레이드',
        price: 3200000,
      ),
      OptionItem(
        id: 'kitchen_stone',
        title: '주방상판 인조석',
        description: '주방 상판 인조석 마감',
        price: 1600000,
      ),
      OptionItem(
        id: 'balcony_expansion',
        title: '발코니확장',
        description: '발코니 확장 공사',
        price: 4500000,
      ),
    ];

    state = state.copyWith(options: mockOptions);
    _calculatePrices();
  }

  // 침실 타입 선택 (라디오 버튼) - 확정 전에만 가능 (84평형 전용)
  void selectBedroomType(String type) {
    if (state.isTypeConfirmed) {
      print('⚠️ 평형 타입이 이미 확정되어 변경할 수 없습니다.');
      return;
    }

    state = state.copyWith(bedroomType: type);
    print('침실 타입 선택: $type');
    _calculatePrices(); // 가격 재계산
  }

  // 알파룸 타입 선택 (라디오 버튼) - 확정 전에만 가능 (84평형 전용)
  void selectAlphaRoomType(String type) {
    if (state.isTypeConfirmed) {
      print('⚠️ 평형 타입이 이미 확정되어 변경할 수 없습니다.');
      return;
    }

    state = state.copyWith(alphaRoomType: type);
    print('알파룸 타입 선택: $type');
    _calculatePrices(); // 가격 재계산
  }

  // 침실2 타입 선택 (라디오 버튼) - 확정 전에만 가능 (61,63평형 전용)
  void selectBedroom2Type(String type) {
    if (state.isTypeConfirmed) {
      print('⚠️ 평형 타입이 이미 확정되어 변경할 수 없습니다.');
      return;
    }

    state = state.copyWith(bedroom2Type: type);
    print('침실2 타입 선택: $type');
    _calculatePrices(); // 가격 재계산
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
  }

  // 평형 타입 확정 해제 (필요시)
  void resetTypeSelection() {
    state = state.copyWith(isTypeConfirmed: false);
    print('🔄 평형 타입 확정 해제 - 다시 선택 가능');
  }

  // 옵션 선택/해제
  void toggleOption(String optionId) {
    final updatedOptions = state.options.map((option) {
      if (option.id == optionId) {
        return option.copyWith(isSelected: !option.isSelected);
      }
      return option;
    }).toList();

    state = state.copyWith(options: updatedOptions);
    _calculatePrices();
  }

  // 가격 계산 (평형 타입별 추가 비용 포함)
  void _calculatePrices() {
    // 선택된 옵션들의 가격
    final selectedOptions = state.options.where((option) => option.isSelected);
    final optionsPrice = selectedOptions.fold<int>(
      0,
      (sum, option) => sum + option.price,
    );

    // 평형 타입별 추가 비용 계산
    int typeUpgradePrice = 0;

    if (state.is84Type) {
      // 84평형의 경우
      // 침실분리형 선택 시 추가 비용 (예: 200만원)
      if (state.bedroomType == "침실분리형") {
        typeUpgradePrice += 2000000;
      }

      // 알파룸2분리형 선택 시 추가 비용 (예: 150만원)
      if (state.alphaRoomType == "알파룸2분리형") {
        typeUpgradePrice += 1500000;
      }
    } else if (state.is61or63Type) {
      // 61,63평형의 경우
      // 침실2분리형 선택 시 추가 비용 (예: 100만원)
      if (state.bedroom2Type == "침실2분리형") {
        typeUpgradePrice += 1000000;
      }
    }

    final totalPrice = state.basePrice + optionsPrice + typeUpgradePrice;
    final contractPrice = (totalPrice * 0.1).round(); // 10%

    state = state.copyWith(
      totalOptionsPrice: optionsPrice + typeUpgradePrice, // 옵션 + 타입 업그레이드 비용
      totalPrice: totalPrice,
      contractPrice: contractPrice,
    );

    print('💰 가격 계산:');
    print('- 기본가: ${_formatPrice(state.basePrice)}원');
    print('- 옵션: ${_formatPrice(optionsPrice)}원');
    print('- 타입 업그레이드: ${_formatPrice(typeUpgradePrice)}원');
    print('- 총액: ${_formatPrice(totalPrice)}원');
  }

  // 모든 옵션 선택/해제
  void toggleAllOptions(bool selectAll) {
    final updatedOptions = state.options.map((option) {
      return option.copyWith(isSelected: selectAll);
    }).toList();

    state = state.copyWith(options: updatedOptions);
    _calculatePrices();
  }

  // 다음 단계로 진행
  Future<bool> proceedToNext() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // 선택된 옵션들과 가격 분석
      final selectedOptions = state.options.where(
        (option) => option.isSelected,
      );
      final optionsPrice = selectedOptions.fold<int>(
        0,
        (sum, option) => sum + option.price,
      );

      // 타입별 추가 비용 계산
      int typeUpgradePrice = 0;
      if (state.is84Type) {
        if (state.bedroomType == "침실분리형") typeUpgradePrice += 2000000;
        if (state.alphaRoomType == "알파룸2분리형") typeUpgradePrice += 1500000;
      } else if (state.is61or63Type) {
        if (state.bedroom2Type == "침실2분리형") typeUpgradePrice += 1000000;
      }

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

      print('🛠️ 선택 옵션 (${selectedOptions.length}개):');
      if (selectedOptions.isNotEmpty) {
        for (final option in selectedOptions) {
          print('  - ${option.title}: +${_formatPrice(option.price)}원');
        }
      } else {
        print('  - 선택된 옵션 없음');
      }

      print('💰 가격 정보:');
      print('  - 기본 분양가: ${_formatPrice(state.basePrice)}원');
      if (optionsPrice > 0) {
        print('  - 옵션 비용: +${_formatPrice(optionsPrice)}원');
      }
      if (typeUpgradePrice > 0) {
        print('  - 타입 업그레이드: +${_formatPrice(typeUpgradePrice)}원');
      }
      print('  - 총 분양가: ${_formatPrice(state.totalPrice)}원');
      print('  - 계약금 (10%): ${_formatPrice(state.contractPrice)}원');
      print('========================');

      // 서버 전송 시뮬레이션
      await Future.delayed(const Duration(milliseconds: 500));

      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: '선택 사항 저장 중 오류가 발생했습니다.');
      return false;
    }
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
}

// Provider Factory - 이전 페이지 정보를 받아서 생성
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
