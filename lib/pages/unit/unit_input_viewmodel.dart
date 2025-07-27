// unit_input_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 새로 추가된 import
import '../../repositories/dong_hosu_type_rawdata.dart';

/// 유닛 입력 화면의 상태 모델
class UnitInputState {
  final String dong;
  final String hosu;
  final String name;
  final String? unitType;
  final String? error;
  final bool isLoading;
  final bool isLocked; // 조회 성공 후 잠금 상태

  const UnitInputState({
    this.dong = '',
    this.hosu = '',
    this.name = '',
    this.unitType,
    this.error,
    this.isLoading = false,
    this.isLocked = false,
  });

  /// 조회 가능한지 확인 (동, 호수 입력됨 + 잠금되지 않음)
  bool get canSearch =>
      dong.isNotEmpty && hosu.isNotEmpty && !isLoading && !isLocked;

  /// 다음 단계로 진행 가능한지 확인 (조회 성공 + 잠금됨)
  bool get canProceed => unitType != null && !isLoading && isLocked;

  UnitInputState copyWith({
    String? dong,
    String? hosu,
    String? name,
    String? unitType,
    String? error,
    bool? isLoading,
    bool? isLocked,
  }) {
    return UnitInputState(
      dong: dong ?? this.dong,
      hosu: hosu ?? this.hosu,
      name: name ?? this.name,
      unitType: unitType ?? this.unitType,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isLocked: isLocked ?? this.isLocked,
    );
  }

  @override
  String toString() {
    return 'UnitInputState(dong: $dong, hosu: $hosu, name: $name, unitType: $unitType, error: $error, isLoading: $isLoading)';
  }
}

/// 유닛 입력 ViewModel
class UnitInputViewModel extends StateNotifier<UnitInputState> {
  UnitInputViewModel() : super(const UnitInputState());

  /// 동 번호 업데이트
  void updateDong(String dong) {
    // 잠금 상태에서는 수정 불가
    if (state.isLocked) return;

    state = state.copyWith(
      dong: dong,
      unitType: null, // 동이 변경되면 기존 유닛 타입 초기화
      error: null, // 에러 초기화
    );
  }

  /// 호수 업데이트
  void updateHosu(String hosu) {
    // 잠금 상태에서는 수정 불가
    if (state.isLocked) return;

    state = state.copyWith(
      hosu: hosu,
      unitType: null, // 호수가 변경되면 기존 유닛 타입 초기화
      error: null, // 에러 초기화
    );
  }

  /// 수동으로 유닛 타입 조회
  Future<void> searchUnitType() async {
    // 조회 시작 시 에러 카드 즉시 제거
    state = state.copyWith(error: null);
    clearError();

    final dong = state.dong.trim();
    final hosu = state.hosu.trim();

    if (dong.isEmpty || hosu.isEmpty) {
      state = state.copyWith(error: '동과 호수를 모두 입력해주세요.');
      return;
    }

    // 로딩 상태 시작
    state = state.copyWith(isLoading: true, error: null, unitType: null);

    try {
      // 실제 데이터에서 조회
      final unitType = DongHosuTypeRawdata.getUnitType(dong, hosu);

      if (unitType != null) {
        state = state.copyWith(
          unitType: unitType,
          isLoading: false,
          error: null,
          isLocked: true, // 조회 성공 시 잠금
        );
      } else {
        // 실패: 해당 동/호수 조합이 없음
        state = state.copyWith(
          unitType: null,
          isLoading: false,
          error: '입력하신 동/호수 정보를 찾을 수 없습니다.\n동과 호수를 다시 확인해주세요.',
          isLocked: false,
        );
      }
    } catch (e) {
      // 예외 처리
      state = state.copyWith(
        unitType: null,
        isLoading: false,
        error: '조회 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.',
        isLocked: false,
      );
    }
  }

  /// 잠금 해제 및 재조회 가능하도록 초기화
  void resetForNewSearch() {
    state = state.copyWith(unitType: null, error: null, isLocked: false);
  }

  /// 계약자명 업데이트
  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  /// 에러 메시지 초기화
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// 유닛 타입 조회 (실제 데이터 사용)
  Future<void> _lookupUnitType() async {
    final dong = state.dong.trim();
    final hosu = state.hosu.trim();

    // 입력값이 비어있으면 조회하지 않음
    if (dong.isEmpty || hosu.isEmpty) {
      // 상태만 초기화하고 종료
      state = state.copyWith(unitType: null, isLoading: false, error: null);
      return;
    }

    // 로딩 상태 시작 (기존 unitType과 error 초기화)
    state = state.copyWith(
      isLoading: true,
      error: null,
      unitType: null, // 조회 시작 시 기존 결과 완전 초기화
    );

    try {
      // 약간의 지연을 추가하여 사용자 경험 개선 (선택사항)
      await Future.delayed(Duration(milliseconds: 300));

      // 실제 데이터에서 조회
      final unitType = DongHosuTypeRawdata.getUnitType(dong, hosu);

      // 조회 중에 사용자가 입력을 다시 변경했는지 확인
      if (state.dong.trim() != dong || state.hosu.trim() != hosu) {
        // 입력이 변경되었으면 현재 조회 결과 무시
        return;
      }

      if (unitType != null) {
        // 성공: 유닛 타입을 평형 형태로 변환

        state = state.copyWith(
          unitType: unitType,
          isLoading: false,
          error: null,
        );
      } else {
        // 실패: 해당 동/호수 조합이 없음
        state = state.copyWith(
          unitType: null,
          isLoading: false,
          error: '입력하신 동/호수 정보를 찾을 수 없습니다.\n동과 호수를 다시 확인해주세요.',
        );
      }
    } catch (e) {
      // 예외 처리
      state = state.copyWith(
        unitType: null,
        isLoading: false,
        error: '조회 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.',
      );
    }
  }

  /// 수동으로 유닛 타입 재조회
  Future<void> refreshUnitType() async {
    await _lookupUnitType();
  }

  /// 입력 검증 및 다음 단계로 진행
  Future<bool> validateAndProceed() async {
    // 필수 필드 검증
    if (state.dong.trim().isEmpty) {
      state = state.copyWith(error: '동을 입력해주세요.');
      return false;
    }

    if (state.hosu.trim().isEmpty) {
      state = state.copyWith(error: '호수를 입력해주세요.');
      return false;
    }

    // 유닛 타입이 없으면 다시 조회 시도
    if (state.unitType == null) {
      await _lookupUnitType();

      // 조회 후에도 유닛 타입이 없으면 실패
      if (state.unitType == null) {
        return false;
      }
    }

    return true;
  }

  /// 개발자용: 사용 가능한 동 목록 조회
  List<String> getAvailableDongs() {
    return DongHosuTypeRawdata.getAvailableDongs();
  }

  /// 개발자용: 특정 동의 사용 가능한 호수 목록 조회
  List<String> getAvailableHosuByDong(String dong) {
    return DongHosuTypeRawdata.getAvailableHosuByDong(dong);
  }

  /// 개발자용: 데이터 요약 정보 조회
  Map<String, dynamic> getDataSummary() {
    return DongHosuTypeRawdata.getDataSummary();
  }
}

/// Provider 정의
final unitInputViewModelProvider =
    StateNotifierProvider<UnitInputViewModel, UnitInputState>(
      (ref) => UnitInputViewModel(),
    );
