// quotation_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/app_colors.dart';
import 'quotation_viewmodel.dart';

class QuotationView extends ConsumerStatefulWidget {
  final QuotationData quotationData;

  const QuotationView({super.key, required this.quotationData});

  @override
  ConsumerState<QuotationView> createState() => _QuotationViewState();
}

class _QuotationViewState extends ConsumerState<QuotationView>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startAnimations();

    // ViewModel에 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(quotationViewModelProvider.notifier)
          .loadQuotationData(widget.quotationData);
    });
  }

  void _initAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() async {
    _fadeController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(quotationViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildMainContent(state)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 120,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryDark, AppColors.primaryMedium],
        ),
      ),
      child: Stack(
        children: [
          // 배경 글로우 효과
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.transparent,
                    AppColors.luxuryGold.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.cleanWhite,
                            size: 16,
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      Text(
                        '${widget.quotationData.dong}동 ${widget.quotationData.hosu}호 ${widget.quotationData.unitType}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.cleanWhite,
                          letterSpacing: 0.5,
                        ),
                      ),
                      if (widget.quotationData.name != null &&
                          widget.quotationData.name!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          '${widget.quotationData.name} 고객님',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: AppColors.cleanWhite.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(QuotationState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildResultContainer(state),
          const SizedBox(height: 24),
          _buildActionButton(state),
        ],
      ),
    );
  }

  Widget _buildResultContainer(QuotationState state) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cleanWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.1),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // 상단 골드 라인
          Container(
            height: 3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.luxuryGold,
                  AppColors.primaryLight,
                  AppColors.luxuryGold,
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildSuccessIcon(),
                const SizedBox(height: 8),
                _buildResultTitle(),
                const SizedBox(height: 4),
                _buildResultSubtitle(),
                const SizedBox(height: 16),
                _buildSelectionSummary(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.luxuryGold, AppColors.primaryLight],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.luxuryGold.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.check,
              color: AppColors.cleanWhite,
              size: 16,
            ),
          ),
        );
      },
    );
  }

  Widget _buildResultTitle() {
    return const Text(
      '선택 완료',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryDark,
      ),
    );
  }

  Widget _buildResultSubtitle() {
    return const Text(
      '선택하신 옵션 내역입니다',
      style: TextStyle(fontSize: 12, color: AppColors.primaryMedium),
    );
  }

  Widget _buildSelectionSummary() {
    final quotationData = widget.quotationData;

    return Column(
      children: [
        // 평면 유형
        _buildSummaryItem('평면 유형', quotationData.shortWallType),

        // 선택된 옵션들
        ...quotationData.selectedPaidOptions.map(
          (option) => _buildSummaryItem(
            option.optionTitle,
            '+${_formatPrice(option.selectedDetailPrice)}',
          ),
        ),

        // 발코니 확장
        _buildSummaryItem('발코니확장', '+${quotationData.formattedExpansionPrice}'),

        // 옵션 총액
        _buildTotalRow(
          '옵션 총액',
          '+${quotationData.formattedSelectedOptionsPrice}원',
        ),

        // 총 분양가
        _buildEstimateRow(
          '총 분양가 (기본형+옵션)',
          '${quotationData.formattedTotalPrice}원',
        ),

        // 계약금
        _buildContractRow(
          '계약금 10%',
          '${quotationData.formattedContractPrice}원',
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.lightBeige, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.primaryMedium,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0, top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.lightBeige,
        border: Border(top: BorderSide(color: AppColors.luxuryGold, width: 2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryDark,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEstimateRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.luxuryGold, AppColors.primaryLight],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.cleanWhite,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.cleanWhite,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContractRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.luxuryGold,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.luxuryGold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(QuotationState state) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: state.isSending ? null : _handleSendPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.luxuryGold,
          foregroundColor: AppColors.cleanWhite,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 6,
        ),
        child: state.isSending
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
                    '전송 중...',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '견적서 전송',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.send, size: 16),
                ],
              ),
      ),
    );
  }

  Future<void> _handleSendPressed() async {
    final success = await ref
        .read(quotationViewModelProvider.notifier)
        .sendQuotation();

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ 견적서가 성공적으로 전송되었습니다.'),
          backgroundColor: AppColors.luxuryGold,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ 견적서 전송에 실패했습니다.'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
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
