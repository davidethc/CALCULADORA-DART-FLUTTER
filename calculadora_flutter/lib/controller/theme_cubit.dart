import 'package:flutter_bloc/flutter_bloc.dart';

/// Estado para manejar el tema de la aplicación
enum ThemeState { light, dark }

/// Cubit para manejar el cambio de tema
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.light);

  /// Cambia entre tema claro y oscuro
  void toggleTheme() {
    emit(state == ThemeState.light ? ThemeState.dark : ThemeState.light);
  }
}