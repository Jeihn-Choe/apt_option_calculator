// State 클래스
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnitInputState {
  final String dong;
  final String hosu;
  final String? name;
  final String? unitType;
  final bool isLoading;
  final String? error;
  final bool canProceed;


  const UnitInputState({
    this.dong = '',
    this.hosu = '',
    this.name = '',
    this.unitType,
    this.isLoading = false,
    this.error,
    this.canProceed = false,
  });

  UnitInputState copyWith({
    String? dong,
    String? hosu,
    String? unitType,
    bool? isLoading,
    String? error,
    bool? canProceed,
  }) {
    return UnitInputState(
      dong: dong ?? this.dong,
      hosu: hosu ?? this.hosu,
      unitType: unitType ?? this.unitType,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      canProceed: canProceed ?? this.canProceed,
    );
  }
}

// ViewModel 클래스
class UnitInputViewModel extends StateNotifier<UnitInputState> {
  UnitInputViewModel() : super(const UnitInputState());

  // 입력 업데이트
  void updateInput(String dong, String hosu) {
    state = state.copyWith(
      dong: dong,
      hosu: hosu,
      error: null, // 입력 변경 시 에러 초기화
    );

    // 자동으로 평형 타입 찾기 (둘 다 입력된 경우)
    if (dong.isNotEmpty && hosu.isNotEmpty) {
      _autoFindUnitType(dong, hosu);
    } else {
      state = state.copyWith(unitType: null, canProceed: false);
    }
  }

  // 평형 타입 찾기 (사용자가 버튼 클릭)
  Future<void> findUnitType(String dong, String hosu) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // 여기서 실제로는 Supabase에서 조회할 예정
      // 지금은 임시 로직으로 처리
      await Future.delayed(const Duration(milliseconds: 500));

      final unitType = _getMockUnitType(dong, hosu);

      if (unitType != null) {
        state = state.copyWith(
          isLoading: false,
          unitType: unitType,
          canProceed: true,
        );

        // 여기서 다음 페이지로 이동 로직 추가
        // GoRouter.of(context).go('/option-selection');
        print('다음 페이지로 이동: $dong동 $hosu호 ($unitType 타입)');
      } else {
        state = state.copyWith(
          isLoading: false,
          error: '해당 동/호수 정보를 찾을 수 없습니다.\n입력하신 정보를 다시 확인해주세요.',
          canProceed: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '정보를 조회하는 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.',
        canProceed: false,
      );
    }
  }

  // 자동 평형 타입 찾기 (실시간)
  void _autoFindUnitType(String dong, String hosu) {
    final unitType = _getMockUnitType(dong, hosu);

    if (unitType != null) {
      state = state.copyWith(unitType: unitType, canProceed: true, error: null);
    } else {
      state = state.copyWith(
        unitType: null,
        canProceed: false,
        error: null, // 자동 조회에서는 에러 표시 안함
      );
    }
  }

  // 임시 Mock 데이터 (나중에 Supabase로 대체)
  String? _getMockUnitType(String dong, String hosu) {
    final dongNum = int.tryParse(dong);
    final hosuNum = int.tryParse(hosu);

    if (dongNum == null || hosuNum == null) return null;

    // 임시 매핑 로직 (실제로는 DB에서 조회)
    if (dongNum >= 101 && dongNum <= 103) {
      if (hosuNum >= 501 && hosuNum <= 510) return '61평형';
      if (hosuNum >= 511 && hosuNum <= 520) return '63평형';
    }

    if (dongNum >= 104 && dongNum <= 106) {
      if (hosuNum >= 501 && hosuNum <= 505) return '84A평형';
      if (hosuNum >= 506 && hosuNum <= 510) return '84B평형';
      if (hosuNum >= 511 && hosuNum <= 515) return '84C평형';
    }

    return null; // 해당하는 평형이 없음
  }
}

// Provider
final unitInputViewModelProvider =
    StateNotifierProvider<UnitInputViewModel, UnitInputState>((ref) {
      return UnitInputViewModel();
    });
