import 'package:calculadora_flutter/view/calculadodra_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controller/calculadora_cubit.dart';
import 'controller/theme_cubit.dart';
import 'config/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CalculadoraCubit>(create: (context) => CalculadoraCubit()),
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Calculadora Flutter',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode:
                themeState == ThemeState.light
                    ? ThemeMode.light
                    : ThemeMode.dark,
            home: CalculadoraPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
