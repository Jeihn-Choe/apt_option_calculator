import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/app_colors.dart';
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
            child: Column(
              children: [
                _buildTypeSelection(state),
                Expanded(child: _buildOptionsList(state)),
              ],
            ),
          ),
          _buildPriceSummary(state),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: _buildIconButton(Icons.arrow_back_ios),
      title: Column(
        children: [
          Text(
            '${widget.dong}동 ${widget.hosu}호 ${widget.unitType}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.cleanWhite,
            ),
          ),
          if (widget.name != null && widget.name!.isNotEmpty)
            Text(
              '${widget.name} 고객님',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: AppColors.cleanWhite.withValues(alpha: 0.9),
              ),
            ),
        ],
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
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

  Widget _buildIconButton(IconData icon) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppColors.cleanWhite, size: 20),
    );
  }

  Widget _buildTypeSelection(ChooseOptionState state) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: AppColors.cleanWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목과 확정 상태
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.primaryLight, width: 1),
                bottom: BorderSide(color: AppColors.primaryLight, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '가변형 벽체 선택 (${state.unitType})',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
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
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '확정',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.cleanWhite,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 평형별 조건부 렌더링
          if (state.is84Type) ...[
            // 84평형 전용 옵션들
            _build84TypeOptions(state),
          ] else if (state.is61or63Type) ...[
            // 61,63평형 전용 옵션들
            _build61or63TypeOptions(state),
          ],

          const SizedBox(height: 20),

          // 확정/재설정 버튼
          Row(
            children: [
              if (!state.isTypeConfirmed) ...[
                Expanded(
                  child: _buildConfirmButton(
                    '확정',
                    () => ref.read(provider.notifier).confirmTypeSelection(),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: _buildConfirmButton(
                    '재설정',
                    () => ref.read(provider.notifier).resetTypeSelection(),
                    isReset: true,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // 84평형 전용 옵션들 (기존 두 행)
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
            const SizedBox(width: 16),
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
        const SizedBox(height: 16),

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
            const SizedBox(width: 16),
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

  // 61,63평형 전용 옵션들 (새로 추가된 한 행)
  Widget _build61or63TypeOptions(ChooseOptionState state) {
    return Column(
      children: [
        // 침실2 타입 선택
        Row(
          children: [
            Expanded(
              child: _buildRadioButton(
                '침실2분리형',
                state.bedroom2Type == '침실2분리형',
                state.isTypeConfirmed
                    ? null
                    : () => ref
                          .read(provider.notifier)
                          .selectBedroom2Type('침실2분리형'),
                isDisabled: state.isTypeConfirmed,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildRadioButton(
                '거실통합형',
                state.bedroom2Type == '거실통합형',
                state.isTypeConfirmed
                    ? null
                    : () => ref
                          .read(provider.notifier)
                          .selectBedroom2Type('거실통합형'),
                isDisabled: state.isTypeConfirmed,
              ),
            ),
          ],
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
              width: 20,
              height: 20,
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
                        width: 10,
                        height: 10,
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

  Widget _buildConfirmButton(
    String title,
    VoidCallback onTap, {
    bool isReset = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: isReset
              ? null
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.luxuryGold, AppColors.primaryLight],
                ),
          color: isReset ? AppColors.primaryLight.withValues(alpha: 0.8) : null,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: (isReset ? AppColors.primaryLight : AppColors.luxuryGold)
                  .withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isReset ? Icons.refresh : Icons.check,
              color: AppColors.cleanWhite,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.cleanWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsList(ChooseOptionState state) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: state.options.length,
        itemBuilder: (context, index) {
          final option = state.options[index];
          return _buildOptionItem(option);
        },
      ),
    );
  }

  Widget _buildOptionItem(OptionItem option) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cleanWhite,
        borderRadius: BorderRadius.circular(16),
        border: option.isSelected
            ? Border.all(color: AppColors.luxuryGold, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => ref.read(provider.notifier).toggleOption(option.id),
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            // 체크박스
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: option.isSelected
                    ? AppColors.luxuryGold
                    : Colors.transparent,
                border: Border.all(
                  color: option.isSelected
                      ? AppColors.luxuryGold
                      : AppColors.primaryLight,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: option.isSelected
                  ? const Icon(
                      Icons.check,
                      color: AppColors.cleanWhite,
                      size: 16,
                    )
                  : null,
            ),
            const SizedBox(width: 16),

            // 옵션 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          option.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                      Text(
                        '+${_formatPrice(option.price)}원',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    option.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryLight,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSummary(ChooseOptionState state) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryDark, AppColors.primaryMedium],
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // 선택된 옵션 수
            if (state.options.where((o) => o.isSelected).isNotEmpty) ...[
              Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: AppColors.luxuryGold,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${state.options.where((o) => o.isSelected).length}개 옵션 선택',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.luxuryGold,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],

            // 총액
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '총액',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.cleanWhite,
                  ),
                ),
                Text(
                  '${_formatPrice(state.totalPrice)}원',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.cleanWhite,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 계약금
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '계약금 10%',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.luxuryGold,
                  ),
                ),
                Text(
                  '${_formatPrice(state.contractPrice)}원',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.luxuryGold,
                  ),
                ),
              ],
            ),

            // 다음 버튼
            const SizedBox(height: 20),
            _buildNextButton(state),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(ChooseOptionState state) {
    return GestureDetector(
      onTap: state.isLoading ? null : _handleNextPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.luxuryGold,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: AppColors.luxuryGold.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: state.isLoading
            ? Row(
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
                  const SizedBox(width: 12),
                  Text(
                    '저장 중...',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: AppColors.cleanWhite,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '견적서 확인',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: AppColors.cleanWhite,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: AppColors.cleanWhite,
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _handleNextPressed() async {
    final success = await ref.read(provider.notifier).proceedToNext();

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ 선택 완료! 견적서 페이지로 이동합니다.'),
          backgroundColor: AppColors.luxuryGold,
          behavior: SnackBarBehavior.floating,
        ),
      );
      // TODO: Navigate to final summary page
      // GoRouter.of(context).go('/final-summary');
    }
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
