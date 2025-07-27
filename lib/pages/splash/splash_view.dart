import 'package:apt_option_calculator/pages/unit/unit_input_view.dart';
import 'package:apt_option_calculator/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startAnimations();

    // 1초 후 다음 페이지로 이동
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        //다음페이지로 라우팅
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const UnitInputView()),
        );
      }
    });
  }

  void _initAnimations() {
    // Fade 애니메이션 (배경용)
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Scale 애니메이션 (아이콘용)
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
  }

  void _startAnimations() async {
    //0.3초 후 배경 페이드인
    await Future.delayed(const Duration(milliseconds: 300));
    _fadeController.forward();

    //0.5초후 아이콘 탄성 애니메이션
    await Future.delayed(const Duration(milliseconds: 300));
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.offWhite, AppColors.lightBeige],
            ),
          ),

          child: Center(
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //아파트아이콘(탄성애니메이션)
                  SvgPicture.asset(
                    'assets/icons/apartment_icon_svg.svg',
                    width: 120,
                    height: 120,
                  ),

                  const SizedBox(height: 32),

                  //타이틀
                  Text(
                    '군포 포레스트 옵션 선택 도우미',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
