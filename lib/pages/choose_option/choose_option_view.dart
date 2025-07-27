import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/type_detail_option.dart';
import '../../utils/app_colors.dart';
import '../quotation/quotation_view.dart';
import 'choose_option_viewmodel.dart';

class ChooseOptionView extends ConsumerStatefulWidget {
  final String dong;
  final String hosu;
  final String? name;
  final String unitType;

  const ChooseOptionView({
    super.key,
    required this.dong,
    required this.hosu,
    this.name,
    required this.unitType,
  });

  @override
  ConsumerState<ChooseOptionView> createState() => _ChooseOptionViewState();
}

class _ChooseOptionViewState extends ConsumerState<ChooseOptionView> {
  late final StateNotifierProvider<ChooseOptionViewModel, ChooseOptionState>
  provider;

  @override
  void initState() {
    super.initState();

    // Provider 초기화
    provider = chooseOptionViewModelProvider({
      'dong': widget.dong,
      'hosu': widget.hosu,
      'name': widget.name,
      'unitType': widget.unitType,
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120), // 플로팅 바텀 공간 확보
              child: Column(
                children: [
                  // 타입별 금액 표시 카드
                  _buildExpansionPriceCard(state),

                  // 가변형 벽체 선택 섹션
                  _buildTypeSelection(state),

                  // 세부 옵션 섹션
                  if (state.isTypeConfirmed) _buildDetailOptionsSection(state),

                  // 견적서 확인 버튼
                  _buildNextButtonContainer(state),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomSheet: _buildPriceSummary(state),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.cleanWhite,
            size: 20,
          ),
        ),
      ),
      title: Column(
        children: [
          Text(
            '${widget.dong}동 ${widget.hosu}호 ${widget.unitType}타입',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.cleanWhite,
            ),
          ),
          if (widget.name != null && widget.name!.isNotEmpty)
            Text(
              '${widget.name} 고객님',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: AppColors.cleanWhite.withValues(alpha: 0.9),
              ),
            ),
        ],
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryDark, AppColors.primaryMedium],
          ),
        ),
      ),
      elevation: 0,
    );
  }

  // 발코니 확장 가격 카드
  Widget _buildExpansionPriceCard(ChooseOptionState state) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.luxuryGold, AppColors.primaryLight],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.luxuryGold.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 배경 글로우 효과
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.0),
                    Colors.white.withValues(alpha: 0.1),
                    Colors.white.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.expansionTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.cleanWhite,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 2,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${state.unitType} 타입',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.cleanWhite.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${_formatPrice(state.expansionPrice)}원',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.cleanWhite,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 2,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                state.expansionDescription,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.cleanWhite.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeSelection(ChooseOptionState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cleanWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목과 확정 상태
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.primaryLight),
                bottom: BorderSide(color: AppColors.primaryLight),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '가변형 벽체 선택',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
                if (state.isTypeConfirmed)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.luxuryGold,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '확정',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.cleanWhite,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 평형별 조건부 렌더링
          if (state.is84Type) ...[
            // 84평형 전용 옵션들
            _build84TypeOptions(state),
          ] else if (state.is61or63Type) ...[
            // 61,63평형 전용 옵션들
            _build61or63TypeOptions(state),
          ],

          const SizedBox(height: 16),

          // 확정/재설정 버튼
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: state.isTypeConfirmed
                  ? () => ref.read(provider.notifier).resetTypeSelection()
                  : () => ref.read(provider.notifier).confirmTypeSelection(),
              style: ElevatedButton.styleFrom(
                backgroundColor: state.isTypeConfirmed
                    ? AppColors.primaryLight.withValues(alpha: 0.8)
                    : AppColors.luxuryGold,
                foregroundColor: AppColors.cleanWhite,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    state.isTypeConfirmed ? Icons.refresh : Icons.check,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    state.isTypeConfirmed ? '재설정' : '확정',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 84평형 전용 옵션들
  Widget _build84TypeOptions(ChooseOptionState state) {
    return Column(
      children: [
        // 첫 번째 라디오 그룹: 침실 타입
        Row(
          children: [
            Expanded(
              child: _buildRadioButton(
                '침실분리형',
                state.bedroomType == '침실분리형',
                state.isTypeConfirmed
                    ? null
                    : () => ref
                          .read(provider.notifier)
                          .selectBedroomType('침실분리형'),
                isDisabled: state.isTypeConfirmed,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildRadioButton(
                '거실통합형',
                state.bedroomType == '거실통합형',
                state.isTypeConfirmed
                    ? null
                    : () => ref
                          .read(provider.notifier)
                          .selectBedroomType('거실통합형'),
                isDisabled: state.isTypeConfirmed,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // 두 번째 라디오 그룹: 알파룸 타입
        Row(
          children: [
            Expanded(
              child: _buildRadioButton(
                '알파룸2분리형',
                state.alphaRoomType == '알파룸2분리형',
                state.isTypeConfirmed
                    ? null
                    : () => ref
                          .read(provider.notifier)
                          .selectAlphaRoomType('알파룸2분리형'),
                isDisabled: state.isTypeConfirmed,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildRadioButton(
                '거실통합형',
                state.alphaRoomType == '거실통합형',
                state.isTypeConfirmed
                    ? null
                    : () => ref
                          .read(provider.notifier)
                          .selectAlphaRoomType('거실통합형'),
                isDisabled: state.isTypeConfirmed,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 61,63평형 전용 옵션들
  Widget _build61or63TypeOptions(ChooseOptionState state) {
    return Row(
      children: [
        Expanded(
          child: _buildRadioButton(
            '침실2분리형',
            state.bedroom2Type == '침실2분리형',
            state.isTypeConfirmed
                ? null
                : () =>
                      ref.read(provider.notifier).selectBedroom2Type('침실2분리형'),
            isDisabled: state.isTypeConfirmed,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildRadioButton(
            '거실통합형',
            state.bedroom2Type == '거실통합형',
            state.isTypeConfirmed
                ? null
                : () => ref.read(provider.notifier).selectBedroom2Type('거실통합형'),
            isDisabled: state.isTypeConfirmed,
          ),
        ),
      ],
    );
  }

  Widget _buildRadioButton(
    String title,
    bool isSelected,
    VoidCallback? onTap, {
    bool isDisabled = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: isDisabled
              ? (isSelected
                    ? AppColors.luxuryGold.withValues(alpha: 0.3)
                    : AppColors.lightBeige.withValues(alpha: 0.3))
              : (isSelected
                    ? AppColors.luxuryGold.withValues(alpha: 0.1)
                    : AppColors.cleanWhite),
          border: Border.all(
            color: isDisabled
                ? (isSelected
                      ? AppColors.luxuryGold.withValues(alpha: 0.5)
                      : AppColors.lightBeige)
                : (isSelected ? AppColors.luxuryGold : AppColors.lightBeige),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: (isSelected && !isDisabled)
              ? [
                  BoxShadow(
                    color: AppColors.luxuryGold.withValues(alpha: 0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            // 라디오 버튼
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDisabled
                      ? (isSelected
                            ? AppColors.luxuryGold.withValues(alpha: 0.5)
                            : AppColors.primaryLight.withValues(alpha: 0.5))
                      : (isSelected
                            ? AppColors.luxuryGold
                            : AppColors.primaryLight),
                  width: 2,
                ),
                color: Colors.transparent,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 9,
                        height: 9,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDisabled
                              ? AppColors.luxuryGold.withValues(alpha: 0.5)
                              : AppColors.luxuryGold,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 10),

            // 라벨
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isDisabled
                      ? (isSelected
                            ? AppColors.luxuryGold.withValues(alpha: 0.7)
                            : AppColors.primaryMedium.withValues(alpha: 0.5))
                      : (isSelected
                            ? AppColors.luxuryGold
                            : AppColors.primaryMedium),
                ),
              ),
            ),

            // 확정된 경우 체크 아이콘 표시
            if (isDisabled && isSelected)
              Icon(
                Icons.check_circle,
                size: 16,
                color: AppColors.luxuryGold.withValues(alpha: 0.7),
              ),
          ],
        ),
      ),
    );
  }

  // 세부 옵션 섹션
  Widget _buildDetailOptionsSection(ChooseOptionState state) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cleanWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // 헤더
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.lightBeige,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    '세부 옵션 선택',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
                Text(
                  '원하는 옵션을 선택해주세요 (다중 선택 가능)',
                  style: TextStyle(fontSize: 12, color: AppColors.primaryLight),
                ),
              ],
            ),
          ),

          // 옵션 목록
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: state.availableOptions.map((option) {
                return _buildOptionCard(state, option);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // 개별 옵션 카드
  Widget _buildOptionCard(ChooseOptionState state, OptionModel option) {
    final isSelected = state.isOptionSelected(option.id);
    final isExpanded = state.isOptionExpanded(option.id);
    final displayPrice = state.getOptionDisplayPrice(option.id);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? AppColors.luxuryGold : AppColors.lightBeige,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColors.luxuryGold.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: Column(
        children: [
          // 옵션 헤더
          GestureDetector(
            onTap: () =>
                ref.read(provider.notifier).toggleOptionExpansion(option.id),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // 옵션 내용
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              option.desc ?? '옵션',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryDark,
                              ),
                            ),
                            Text(
                              displayPrice,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? AppColors.luxuryGold
                                    : AppColors.primaryLight,
                              ),
                            ),
                          ],
                        ),
                        // 선택된 옵션 설명 표시
                        if (isSelected) ...[
                          const SizedBox(height: 4),
                          Text(
                            state.getSelectedDetail(option.id)?.desc ?? '',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryLight,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // 드롭다운 버튼
                  Container(
                    width: 24,
                    height: 24,
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Transform.rotate(
                      angle: isExpanded ? 3.14159 : 0, // 180도 회전
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.cleanWhite,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 세부 옵션 드롭다운
          if (isExpanded && option.detailedOption != null) ...[
            Container(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.lightBeige)),
              ),
              child: Column(
                children: [
                  // 세부 옵션 헤더
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    color: AppColors.lightBeige.withValues(alpha: 0.5),
                    child: const Row(
                      children: [
                        Text(
                          '세부 옵션 선택',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryMedium,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 세부 옵션 목록
                  ...option.detailedOption!.asMap().entries.map((entry) {
                    final index = entry.key;
                    final detail = entry.value;
                    final isDetailSelected =
                        state.getSelectedDetailIndex(option.id) == index;

                    return GestureDetector(
                      onTap: () => ref
                          .read(provider.notifier)
                          .selectDetailOption(option.id, index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        color: isDetailSelected
                            ? AppColors.luxuryGold.withValues(alpha: 0.1)
                            : null,
                        child: Row(
                          children: [
                            // 라디오 버튼
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isDetailSelected
                                      ? AppColors.luxuryGold
                                      : AppColors.primaryLight,
                                  width: 2,
                                ),
                              ),
                              child: isDetailSelected
                                  ? Center(
                                      child: Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.luxuryGold,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 12),

                            // 옵션 설명
                            Expanded(
                              child: Text(
                                detail.desc,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDetailSelected
                                      ? AppColors.luxuryGold
                                      : AppColors.primaryMedium,
                                  fontWeight: isDetailSelected
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                                  height: 1.3,
                                ),
                              ),
                            ),

                            // 가격
                            Text(
                              detail.price == 0
                                  ? '무료'
                                  : '+${_formatPrice(detail.price)}원',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: detail.price == 0
                                    ? AppColors.primaryLight
                                    : (isDetailSelected
                                          ? AppColors.luxuryGold
                                          : AppColors.primaryMedium),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // 견적서 확인 버튼
  Widget _buildNextButtonContainer(ChooseOptionState state) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: state.isLoading ? null : _handleNextPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.luxuryGold,
            foregroundColor: AppColors.cleanWhite,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 6,
          ),
          child: state.isLoading
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.cleanWhite,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      '저장 중...',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '견적서 확인',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
        ),
      ),
    );
  }

  // 플로팅 가격 요약
  Widget _buildPriceSummary(ChooseOptionState state) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryDark, AppColors.primaryMedium],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state.selectedOptionsPrice > 0) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '발코니 확장',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.cleanWhite,
                    ),
                  ),
                  Text(
                    '${_formatPrice(state.expansionPrice)}원',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.cleanWhite,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '선택 옵션',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.cleanWhite,
                    ),
                  ),
                  Text(
                    '${_formatPrice(state.selectedOptionsPrice)}원',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.cleanWhite,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '총액',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.cleanWhite,
                  ),
                ),
                Text(
                  '${_formatPrice(state.totalPrice)}원',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.cleanWhite,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '계약금 10%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.luxuryGold,
                  ),
                ),
                Text(
                  '${_formatPrice(state.contractPrice)}원',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.luxuryGold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleNextPressed() async {
    final quotationData = await ref.read(provider.notifier).proceedToNext();

    if (quotationData != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ 선택 완료! 견적서 페이지로 이동합니다.'),
          backgroundColor: AppColors.luxuryGold,
          behavior: SnackBarBehavior.floating,
        ),
      );
      // TODO: Navigate to final summary page

      // 견적서 페이지로 이동
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => QuotationView(quotationData: quotationData),
        ),
      );
    }
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
