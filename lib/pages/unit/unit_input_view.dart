
import 'package:apt_option_calculator/pages/unit/unit_input_viewmodel.dart';
import 'package:apt_option_calculator/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnitInputView extends ConsumerStatefulWidget {
  const UnitInputView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UnitInputViewState();
}

class _UnitinputViewState extends ConsumerState<UnitInputState>
with TickerProviderStateMixin{

  final _formkey = GlobalKey<FormState>();
  final _dongController = TextEditingController();
  final _hosuController = TextEditingController();
  final _nameController = TextEditingController();

  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState(){
    super.initState();

    //버튼 터치 애니메이션
    _buttonAnimationController = AnimationController(
      vsync: this,
    duration: const Duration(milliseconds: 150),);

_buttonScaleAnimation = Tween<double>(
  begin: 1.0,
  end: 0.95,
).animate(CurvedAnimation(parent: _buttonAnimationController, curve: Curves.easeInOut,));
  }

  @override
  void dispose(){
    _buttonAnimationController.dispose();
    _dongController.dispose();
    _hosuController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    final unitInputState = ref.watch(unitInputViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.cleanWhite.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.menu,
            color: AppColors.cleanWhite,
            size: 20,
          ),
        ),

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

        actions: [
          Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cleanWhite.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline,
              color: AppColors.cleanWhite,
              size: 20,
            ),
          ),
        ],
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
      ),

      body: _buildMainContent(unitInputState),
        );
  }

  Widget _buildMainContent(UnitInputState unitInputState){
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            _buildInputField(
              label: '동',
              controller: _dongController,
              supportingText :'동을 입력해주세요',
              onChanged : (value){
                ref.read(unitInputViewModelProvider.notifier).updateDong(value);
            },
            ),
            const SizedBox(height: 28,),

            _buildInputField(
              label: '호수',
              controller: _hosuController,
              supprotingText: '호수를 입력해주세요',
              onChanged: (value){
                ref.read(unitInputViewModelProvider.notifier).updateHosu(value);
              },
            ),

            const SizedBox(height: 28,),

            _buildNameField(
              label: '계약자명',
              controller: _nameController,
              supportingText: '계약자명을 입력해주세요',
              onChanged:(value){
                ref.read(unitInputViewModelProvider.notifier).updateName(value);
              },
            ),

            // 평형 정보 표시
            if(unitInputViewModelProvider.unitType != null) ...[
              const SizedBox(height: 20,),
              _buildUnitTypeCard(unitInputState.unitType!),
            ],

            //에러 메시지 표시
            if(unitInputState.error != null) ...[
              const SizedBox(height: 20,),
            ],

            const SizedBox(height: 40,),
            _buildContinueButton(unitInputState),
            const SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String supportingText,
    required Function(String) onChanged,
}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.cleanWhite,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.lightBeige,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.luxuryGold.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0,2),
              ),
            ],
          ),

          child: Stack(
            children: [
              //floating label
              Positioned(
                top: -10,
                left:16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  color: AppColors.cleanWhite,
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize:13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryMedium,
                    ),
                  ),
                ),
              ),

              // InputField
              TextFormField(
                controller: controller,
                onChanged: onChanged,
                keyboardType: label == '계약자명' ? TextInputType.text : TextInputType.number,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryDark,
                ),

                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(18,18,55,18),
                  border: InputBorder.none,
                  hintText: '',
                ),
                validator: (value){
                  if(value == null || value.isNotEmpty)
                    return '$label을(를) 입력해주세요';
                  return null;
                },
              ),

              //clear button
              if (controller.text.isNotEmpty)
                Positioned(
                    right: 12,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap:(){
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

        const SizedBox( height: 6,),

        Padding(
            padding: const EdgeInsets.only(left:18),
        child: Text(
          supportingText,
          style: TextStyle(
            fontSize: 11,
            color:AppColors.primaryLight,
            height: 1.3,
          ),
        ),
        ),
      ],
    );
  }

  Widget _buildunitTypeCard(String unitType){
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
        border: Border.all(color: AppColors.luxuryGold.withValues(alpha: 0.3))
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
              Icons.home_outlined,
              color: AppColors.cleanWhite,
              size: 20,
            ),
          ),
          const SizedBox(width: 12,),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '평형 확인됨',
                    style: TextStyle(
                      color: AppColors.primaryMedium,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 2,),
                  Text(unitType,
                  style: TextStyle(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  ),
                ],

          ),
          ),
          Icon(
            Icons.check_circle,
            color: AppColors.luxuryGold,
            size: 24,
          ),
        ],
      ),
    );
  }



      )





}