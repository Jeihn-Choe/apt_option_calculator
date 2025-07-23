import 'package:apt_option_calculator/pages/splash/splash_view.dart';
import 'package:apt_option_calculator/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Supabase 초기화
  await Supabase.initialize(url: 'IP', anonKey: 'anonkey');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '아파트 옵션 관리',
      debugShowCheckedModeBanner: false, // DEBUG 배너 제거
      // 테마 설정
      theme: ThemeData(
        useMaterial3: true,

        // 기본 컬러 스킴
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryDark,
          brightness: Brightness.light,
        ),

        // AppBar 테마
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),

        // 버튼 테마
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryDark,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        // 카드 테마
        cardTheme: CardThemeData(
          color: AppColors.cleanWhite,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // 입력 필드 테마
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.cleanWhite,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primaryLight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primaryLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primaryDark, width: 2),
          ),
        ),

        // 전체 배경색
        scaffoldBackgroundColor: AppColors.offWhite,
      ),

      // 시작 화면을 SplashView로 설정
      home: const SplashView(),
    );
  }
}
