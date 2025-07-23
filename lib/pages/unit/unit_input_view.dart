import 'package:apt_option_calculator/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'unit_input_viewmodel.dart';

class UnitInputView extends ConsumerStatefulWidget {
  const UnitInputView({super.key});

  @override
  ConsumerState<UnitInputView> createState() => _UnitInputViewState();
}

class _UnitInputViewState extends ConsumerState<UnitInputView> {
  final _dongController = TextEditingController();
  final _hosuController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _dongController.dispose();
    _hosuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(unitInputViewmodelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('동/호수 입력'),
        automaticallyImplyLeading: false,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //안내텍스트
                Text(
                  '거주하실 동과 호수를 입력해주세요',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDark,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  '입력하신 정보를 바탕으로 선택 가능한 옵션을 확인할 수 있습니다.',
                  style: TextStyle(fontSize: 14, color: AppColors.primaryLight),
                ),
                const SizedBox(height: 40),

                //동입력
                Text(
                  '동',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDark,
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _dongController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: '101',
                    suffixText: '동',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isNotEmpty) {
                      return '동을 입력해주세요';
                    }
                    if (int.tryParse(value.trim()) == null) {
                      return '숫자만 입력해주세요';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    //입력이 변경될때마다 상태 업데이트
                    ref
                        .read(unitInputViewmodelProvider.notifier)
                        .updateInput(
                          _dongController.text,
                          _hosuController.text,
                        );
                  },
                ),

                //호수입력
                Text(
                  '호수',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryDark,
                  ),
                ),

                SizedBox(height: 8),

                TextFormField(
                  controller: _hosuController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: '1004',
                    suffixText: '호수',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '호수를 입력해주세요';
                    }
                    if (int.tryParse(value.trim()) == null) {
                      return '숫자만 입력해주세요';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    // 입력이 변경될때마다 상태업데이트
                    ref
                        .read(unitInputViewmodelProvider.notifier)
                        .updateInput(
                          _hosuController.text,
                          _hosuController.text,
                        );
                  },
                ),

                const SizedBox(height: 40),

                //평형 정보 표시 (입력 완료 시)
                if (state.unitType != null) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.warmCream,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.luxuryGold, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.home,
                              color: AppColors.primaryDark,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '평형정보',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),

                        Text(
                          '${state.dong}동 ${state.hosu}호',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          '${state.unitType} 타입',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.luxuryGold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],

                //에러메세지
                if (state.error != null) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.error, width: 1),
                    ),

                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: AppColors.error,
                          size: 20,
                        ),

                        const SizedBox(width: 8),

                        Expanded(
                          child: Text(
                            state.error!,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.error,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],

                const Spacer(),

                // 다음 버튼
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.canProceed && !state.isLoading
                        ? () => _handleNextButton()
                        : null,
                    child: state.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            '옵션 선택하기',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleNextButton() {
    if (_formKey.currentState!.validate()) {
      final dong = _dongController.text.trim();
      final hosu = _hosuController.text.trim();

      ref.read(unitInputViewmodelProvider.notifier).findUnitType(dong, hosu);
    }
  }
}
