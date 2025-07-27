import 'package:flutter_riverpod/flutter_riverpod.dart';

// State 클래스
class UnitInputState {
  final String dong;
  final String hosu;
  final String? name;
  final String? unitType; // 조회 성공 시에만 설정
  final bool isLoading;
  final String? error;
  final bool canProceed; // 입력만 완료되면 true

  const UnitInputState({
    this.dong = '',
    this.hosu = '',
    this.name,
    this.unitType,
    this.isLoading = false,
    this.error,
    this.canProceed = false,
  });

  UnitInputState copyWith({
    String? dong,
    String? hosu,
    String? name,
    String? unitType,
    bool? isLoading,
    String? error,
    bool? canProceed,
  }) {
    return UnitInputState(
      dong: dong ?? this.dong,
      hosu: hosu ?? this.hosu,
      name: name ?? this.name,
      unitType: unitType ?? this.unitType,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      canProceed: canProceed ?? this.canProceed,
    );
  }
}

// ViewModel 클래스
class UnitInputViewmodel extends StateNotifier<UnitInputState> {
  UnitInputViewmodel() : super(const UnitInputState());

  // 개별 업데이트 메서드들
  void updateDong(String dong) {
    state = state.copyWith(
      dong: dong,
      error: null, // 입력 시 에러 초기화
      unitType: null, // 입력 변경 시 이전 조회 결과 초기화
    );
    _updateCanProceed();
  }

  void updateHosu(String hosu) {
    state = state.copyWith(hosu: hosu, error: null, unitType: null);
    _updateCanProceed();
  }

  void updateName(String name) {
    state = state.copyWith(name: name, error: null);
  }

  // 진행 가능 여부 업데이트 (입력만 체크)
  void _updateCanProceed() {
    final canProceed = state.dong.isNotEmpty && state.hosu.isNotEmpty;
    // unitType 체크 제거!

    state = state.copyWith(canProceed: canProceed);
  }

  // 🔥 새로운 메서드: 계속하기 버튼 클릭 시 호출
  Future<bool> validateAndProceed() async {
    if (!state.canProceed) return false;

    state = state.copyWith(isLoading: true, error: null);

    try {
      // DB 조회 시뮬레이션
      await Future.delayed(const Duration(milliseconds: 800));

      final unitType = _getMockUnitType(state.dong, state.hosu);

      if (unitType != null) {
        // ✅ 성공: 평형 정보 설정
        state = state.copyWith(
          isLoading: false,
          unitType: unitType,
          error: null,
        );

        print('✅ 조회 성공: ${state.dong}동 ${state.hosu}호 ($unitType 타입)');
        return true; // 다음 페이지로 이동 가능
      } else {
        // ❌ 실패: 에러 메시지 설정
        state = state.copyWith(
          isLoading: false,
          error: '해당 동/호수 정보를 찾을 수 없습니다.\n입력하신 정보를 다시 확인해주세요.',
          unitType: null,
        );

        print('❌ 조회 실패: ${state.dong}동 ${state.hosu}호');
        return false; // 현재 페이지에 머물기
      }
    } catch (e) {
      // 🔥 네트워크/서버 에러
      state = state.copyWith(
        isLoading: false,
        error: '서버 연결에 실패했습니다.\n잠시 후 다시 시도해주세요.',
        unitType: null,
      );

      print('🔥 서버 에러: $e');
      return false;
    }
  }

  // 에러 메시지 초기화
  void clearError() {
    state = state.copyWith(error: null);
  }

  // 입력 초기화 (필요시)
  void reset() {
    state = const UnitInputState();
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
    StateNotifierProvider<UnitInputViewmodel, UnitInputState>((ref) {
      return UnitInputViewmodel();
    });
