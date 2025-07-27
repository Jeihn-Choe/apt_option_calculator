import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/app_colors.dart';
import '../choose_option/choose_option_view.dart';
import 'unit_input_viewmodel.dart';

class UnitInputView extends ConsumerStatefulWidget {
  const UnitInputView({super.key});

  @override
  ConsumerState<UnitInputView> createState() => _UnitInputViewState();
}

class _UnitInputViewState extends ConsumerState<UnitInputView> {
  final _formKey = GlobalKey<FormState>();
  final _dongController = TextEditingController();
  final _hosuController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _dongController.dispose();
    _hosuController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(unitInputViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: _buildAppBar(),
      body: _buildBody(state),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: _buildIconButton(Icons.menu),
      title: Text(
        '금강펜테리움',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w300,
          letterSpacing: 1.5,
          color: AppColors.cleanWhite,
        ),
      ),
      centerTitle: true,
      actions: [_buildIconButton(Icons.person_outline)],
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

  Widget _buildBody(UnitInputState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildInputField(
              label: '동',
              controller: _dongController,
              supportingText: '동을 입력해주세요',
              keyboardType: TextInputType.number,
              onChanged: (value) => ref
                  .read(unitInputViewModelProvider.notifier)
                  .updateDong(value),
            ),
            const SizedBox(height: 28),

            _buildInputField(
              label: '호수',
              controller: _hosuController,
              supportingText: '호수를 입력해주세요',
              keyboardType: TextInputType.number,
              onChanged: (value) => ref
                  .read(unitInputViewModelProvider.notifier)
                  .updateHosu(value),
            ),
            const SizedBox(height: 28),

            _buildInputField(
              label: '계약자명',
              controller: _nameController,
              supportingText: '계약자명을 입력해주세요 (선택사항)',
              keyboardType: TextInputType.text,
              onChanged: (value) => ref
                  .read(unitInputViewModelProvider.notifier)
                  .updateName(value),
            ),

            if (state.unitType != null) ...[
              const SizedBox(height: 24),
              _buildSuccessCard(state.unitType!),
            ],

            if (state.error != null) ...[
              const SizedBox(height: 24),
              _buildErrorCard(state.error!),
            ],

            const SizedBox(height: 40),
            _buildContinueButton(state),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String supportingText,
    required TextInputType keyboardType,
    required Function(String) onChanged,
  }) {
    final isLoading = ref.watch(unitInputViewModelProvider).isLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isLoading
                ? AppColors.lightBeige.withValues(alpha: 0.5)
                : AppColors.cleanWhite,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isLoading
                  ? AppColors.lightBeige.withValues(alpha: 0.5)
                  : AppColors.lightBeige,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.luxuryGold.withValues(
                  alpha: isLoading ? 0.05 : 0.1,
                ),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Floating Label
              Positioned(
                top: -10,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  color: isLoading
                      ? AppColors.lightBeige.withValues(alpha: 0.5)
                      : AppColors.cleanWhite,
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isLoading
                          ? AppColors.primaryLight.withValues(alpha: 0.5)
                          : AppColors.primaryMedium,
                    ),
                  ),
                ),
              ),

              // Text Field
              TextFormField(
                controller: controller,
                onChanged: onChanged,
                keyboardType: keyboardType,
                enabled: !isLoading,
                // 🔧 로딩 중 비활성화
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: isLoading
                      ? AppColors.primaryLight.withValues(alpha: 0.5)
                      : AppColors.primaryDark,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(18, 18, 55, 18),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  // 🔧 계약자명은 선택사항으로 변경
                  if (label != '계약자명' && (value?.isEmpty ?? true)) {
                    return '$label을(를) 입력해주세요';
                  }
                  return null;
                },
              ),

              // Clear Button
              if (controller.text.isNotEmpty && !isLoading)
                Positioned(
                  right: 12,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        controller.clear();
                        onChanged('');
                      },
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight.withValues(alpha: 0.6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 12,
                          color: AppColors.cleanWhite,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            supportingText,
            style: TextStyle(
              fontSize: 11,
              color: isLoading
                  ? AppColors.primaryLight.withValues(alpha: 0.5)
                  : AppColors.primaryLight,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessCard(String unitType) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.luxuryGold.withValues(alpha: 0.1),
            AppColors.primaryLight.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.luxuryGold.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.luxuryGold,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: AppColors.cleanWhite,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '조회 성공!',
                  style: TextStyle(
                    color: AppColors.primaryMedium,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  unitType,
                  style: TextStyle(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.check_circle, color: AppColors.luxuryGold, size: 24),
        ],
      ),
    );
  }

  Widget _buildErrorCard(String error) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error_outline, color: AppColors.error, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  error,
                  style: TextStyle(
                    color: AppColors.error,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () =>
                  ref.read(unitInputViewModelProvider.notifier).clearError(),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.error,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
              ),
              child: const Text(
                '확인',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(UnitInputState state) {
    final canContinue = state.canProceed && !state.isLoading;

    return GestureDetector(
      onTap: canContinue ? _handleContinuePressed : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: canContinue
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.luxuryGold, AppColors.primaryLight],
                )
              : null,
          color: canContinue
              ? null
              : AppColors.primaryLight.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(25),
          boxShadow: canContinue
              ? [
                  BoxShadow(
                    color: AppColors.luxuryGold.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
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
                    '조회 중...',
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
                    '계속하기',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: canContinue
                          ? AppColors.cleanWhite
                          : AppColors.primaryLight,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: canContinue
                        ? AppColors.cleanWhite
                        : AppColors.primaryLight,
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _handleContinuePressed() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref
        .read(unitInputViewModelProvider.notifier)
        .validateAndProceed();

    if (success && mounted) {
      // 🔧 현재 상태 가져오기
      final state = ref.read(unitInputViewModelProvider);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ 평형 확인 완료! 옵션 선택 페이지로 이동합니다.'),
          backgroundColor: AppColors.luxuryGold,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // ✅ 다음 페이지로 이동
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChooseOptionView(
            dong: state.dong,
            hosu: state.hosu,
            name: state.name,
            unitType: state.unitType!,
          ),
        ),
      );
      // TODO: Navigate to next page
      // GoRouter.of(context).go('/option-selection');
    }
  }
}
