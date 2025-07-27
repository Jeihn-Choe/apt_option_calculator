// quotation_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 선택된 옵션 정보 모델
class SelectedOptionInfo {
  final int optionId;
  final String optionTitle;
  final String selectedDetailDesc;
  final int selectedDetailPrice;
  final int selectedDetailIndex;

  const SelectedOptionInfo({
    required this.optionId,
    required this.optionTitle,
    required this.selectedDetailDesc,
    required this.selectedDetailPrice,
    required this.selectedDetailIndex,
  });

  @override
  String toString() {
    return 'SelectedOptionInfo(id: $optionId, title: $optionTitle, desc: $selectedDetailDesc, price: $selectedDetailPrice)';
  }
}

// 견적서 데이터 모델
class QuotationData {
  final String dong;
  final String hosu;
  final String? name;
  final String unitType;
  final String bedroomType;
  final String alphaRoomType;
  final String bedroom2Type;
  final int basePrice;
  final int expansionPrice;
  final int selectedOptionsPrice;
  final int totalPrice;
  final int contractPrice;
  final List<SelectedOptionInfo> selectedOptions;

  const QuotationData({
    required this.dong,
    required this.hosu,
    this.name,
    required this.unitType,
    required this.bedroomType,
    required this.alphaRoomType,
    required this.bedroom2Type,
    required this.basePrice,
    required this.expansionPrice,
    required this.selectedOptionsPrice,
    required this.totalPrice,
    required this.contractPrice,
    required this.selectedOptions,
  });

  // 평형별 표시 여부 판단 헬퍼
  bool get is84Type => unitType.contains('84');

  bool get is61or63Type => unitType.contains('61') || unitType.contains('63');

  // 선택된 가변형 벽체 타입 정보
  String get wallTypeInfo {
    if (is84Type) {
      return '$bedroomType + $alphaRoomType';
    } else if (is61or63Type) {
      return bedroom2Type;
    }
    return '기본형';
  }

  // 단축된 가변형 벽체 표시
  String get shortWallType {
    if (is84Type) {
      final bedroom = bedroomType == "침실분리형" ? "침실분리" : "거실통합";
      final alpha = alphaRoomType == "알파룸2분리형" ? "알파룸분리" : "거실통합";
      return '$bedroom + $alpha';
    } else if (is61or63Type) {
      return bedroom2Type == "침실2분리형" ? "침실2분리형" : "거실통합형";
    }
    return '기본형';
  }

  // 가격 포맷팅
  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  String get formattedBasePrice => _formatPrice(basePrice);

  String get formattedExpansionPrice => _formatPrice(expansionPrice);

  String get formattedSelectedOptionsPrice =>
      _formatPrice(selectedOptionsPrice);

  String get formattedTotalPrice => _formatPrice(totalPrice);

  String get formattedContractPrice => _formatPrice(contractPrice);

  // 디버깅용 요약 출력
  void printSummary() {
    print('=== 견적서 데이터 요약 ===');
    print('📍 기본 정보:');
    print('  - 동/호수: ${dong}동 ${hosu}호');
    print('  - 평형: $unitType');
    if (name != null && name!.isNotEmpty) {
      print('  - 계약자: $name');
    }

    print('🏠 가변형 벽체: $wallTypeInfo');

    print('💰 가격 정보:');
    print('  - 기본 분양가: ${formattedBasePrice}원');
    print('  - 발코니 확장: +${formattedExpansionPrice}원');
    print('  - 선택 옵션: +${formattedSelectedOptionsPrice}원');
    print('  - 총 분양가: ${formattedTotalPrice}원');
    print('  - 계약금 (10%): ${formattedContractPrice}원');

    print('🛠️ 선택된 옵션 (${selectedOptions.length}개):');
    for (final option in selectedOptions) {
      if (option.selectedDetailPrice > 0) {
        print(
          '  - ${option.optionTitle}: ${option.selectedDetailDesc} (+${_formatPrice(option.selectedDetailPrice)}원)',
        );
      }
    }
    print('========================');
  }

  // 선택된 옵션만 필터링
  List<SelectedOptionInfo> get selectedPaidOptions {
    return selectedOptions
        .where((option) => option.selectedDetailPrice > 0)
        .toList();
  }

  // 총 선택된 옵션 개수
  int get totalSelectedOptionsCount => selectedPaidOptions.length;
}

// 견적서 상태 모델
class QuotationState {
  final QuotationData? quotationData;
  final bool isLoading;
  final bool isSending;
  final bool isPrinting;
  final bool isSaving;
  final String? error;
  final String? successMessage;

  const QuotationState({
    this.quotationData,
    this.isLoading = false,
    this.isSending = false,
    this.isPrinting = false,
    this.isSaving = false,
    this.error,
    this.successMessage,
  });

  QuotationState copyWith({
    QuotationData? quotationData,
    bool? isLoading,
    bool? isSending,
    bool? isPrinting,
    bool? isSaving,
    String? error,
    String? successMessage,
  }) {
    return QuotationState(
      quotationData: quotationData ?? this.quotationData,
      isLoading: isLoading ?? this.isLoading,
      isSending: isSending ?? this.isSending,
      isPrinting: isPrinting ?? this.isPrinting,
      isSaving: isSaving ?? this.isSaving,
      error: error ?? this.error,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  // 견적서가 로드되었는지 확인
  bool get hasQuotation => quotationData != null;

  // 어떤 작업이라도 진행 중인지 확인
  bool get isAnyActionInProgress =>
      isLoading || isSending || isPrinting || isSaving;
}

// 견적서 ViewModel
class QuotationViewModel extends StateNotifier<QuotationState> {
  QuotationViewModel() : super(const QuotationState());

  // 견적서 데이터 로드
  void loadQuotationData(QuotationData quotationData) {
    state = state.copyWith(
      quotationData: quotationData,
      error: null,
      successMessage: null,
    );

    print('✅ 견적서 데이터 로드 완료');
    quotationData.printSummary();
  }

  // 견적서 전송
  Future<bool> sendQuotation() async {
    if (state.quotationData == null) {
      state = state.copyWith(error: '견적서 데이터가 없습니다.');
      return false;
    }

    state = state.copyWith(isSending: true, error: null, successMessage: null);

    try {
      print('📤 견적서 전송 시작...');

      // 서버 전송 시뮬레이션
      await Future.delayed(const Duration(seconds: 2));

      // TODO: 실제 서버 전송 로직 구현
      // - 이메일 전송
      // - SMS 전송
      // - 서버 저장

      state = state.copyWith(
        isSending: false,
        successMessage: '견적서가 성공적으로 전송되었습니다.',
      );

      print('✅ 견적서 전송 완료');
      return true;
    } catch (e) {
      print('❌ 견적서 전송 실패: $e');
      state = state.copyWith(isSending: false, error: '견적서 전송 중 오류가 발생했습니다.');
      return false;
    }
  }

  // 견적서 인쇄/PDF 생성
  Future<bool> printQuotation() async {
    if (state.quotationData == null) {
      state = state.copyWith(error: '견적서 데이터가 없습니다.');
      return false;
    }

    state = state.copyWith(isPrinting: true, error: null, successMessage: null);

    try {
      print('🖨️ 견적서 인쇄/PDF 생성 시작...');

      // PDF 생성 시뮬레이션
      await Future.delayed(const Duration(milliseconds: 1500));

      // TODO: 실제 PDF 생성 로직 구현
      // - pdf 패키지 사용
      // - 견적서 템플릿 적용
      // - 파일 저장/공유

      state = state.copyWith(
        isPrinting: false,
        successMessage: '견적서 PDF가 생성되었습니다.',
      );

      print('✅ 견적서 PDF 생성 완료');
      return true;
    } catch (e) {
      print('❌ 견적서 PDF 생성 실패: $e');
      state = state.copyWith(isPrinting: false, error: 'PDF 생성 중 오류가 발생했습니다.');
      return false;
    }
  }

  // 견적서 저장 (로컬 저장)
  Future<bool> saveQuotation() async {
    if (state.quotationData == null) {
      state = state.copyWith(error: '견적서 데이터가 없습니다.');
      return false;
    }

    state = state.copyWith(isSaving: true, error: null, successMessage: null);

    try {
      print('💾 견적서 로컬 저장 시작...');

      // 로컬 저장 시뮬레이션
      await Future.delayed(const Duration(milliseconds: 800));

      // TODO: 실제 로컬 저장 로직 구현
      // - SharedPreferences 또는 SQLite 사용
      // - 견적서 히스토리 관리

      state = state.copyWith(isSaving: false, successMessage: '견적서가 저장되었습니다.');

      print('✅ 견적서 로컬 저장 완료');
      return true;
    } catch (e) {
      print('❌ 견적서 저장 실패: $e');
      state = state.copyWith(isSaving: false, error: '견적서 저장 중 오류가 발생했습니다.');
      return false;
    }
  }

  // 새 견적서 작성 (초기화)
  void createNewQuotation() {
    state = const QuotationState();
    print('🔄 새 견적서 작성을 위해 초기화');
  }

  // 견적서 데이터 업데이트 (수정 시 사용)
  void updateQuotationData(QuotationData updatedData) {
    state = state.copyWith(
      quotationData: updatedData,
      error: null,
      successMessage: '견적서가 업데이트되었습니다.',
    );

    print('🔄 견적서 데이터 업데이트 완료');
  }

  // 에러 메시지 초기화
  void clearError() {
    state = state.copyWith(error: null);
  }

  // 성공 메시지 초기화
  void clearSuccessMessage() {
    state = state.copyWith(successMessage: null);
  }

  // 모든 메시지 초기화
  void clearAllMessages() {
    state = state.copyWith(error: null, successMessage: null);
  }

  // 견적서 요약 정보 가져오기
  Map<String, dynamic> getQuotationSummary() {
    if (state.quotationData == null) {
      return {};
    }

    final data = state.quotationData!;
    return {
      'unitInfo': '${data.dong}동 ${data.hosu}호 ${data.unitType}',
      'customerName': data.name ?? '고객님',
      'wallType': data.shortWallType,
      'totalPrice': data.formattedTotalPrice,
      'contractPrice': data.formattedContractPrice,
      'selectedOptionsCount': data.totalSelectedOptionsCount,
      'expansionPrice': data.formattedExpansionPrice,
      'optionsPrice': data.formattedSelectedOptionsPrice,
    };
  }
}

// Provider 정의
final quotationViewModelProvider =
    StateNotifierProvider<QuotationViewModel, QuotationState>(
      (ref) => QuotationViewModel(),
    );
