import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_state.dart';
class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeSystem());

  void toggleTheme(ThemeEnum themeEnum) {
    if (themeEnum == ThemeEnum.system) {
      emit(ThemeSystem());
    } else if (themeEnum == ThemeEnum.dark) {
      emit(ThemeDark());
    } else {
      emit(ThemeLight());
    }
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    if (json['themeMode'] == 'light') {
      return ThemeLight();
    } else if (json['themeMode'] == 'dark') {
      return ThemeDark();
    } else {
      return ThemeSystem();
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    if (state is ThemeSystem) {
      return {"themeMode": 'system'};
    } else if (state is ThemeLight) {
      return {"themeMode": 'light'};
    } else {
      return {"themeMode": 'dark'};
    }
  }
}

enum ThemeEnum {
  light,
  dark,
  system,
}

// Add custom serialization for ThemeEnum
extension ThemeEnumExtension on ThemeEnum {
  String get value {
    switch (this) {
      case ThemeEnum.light:
        return 'light';
      case ThemeEnum.dark:
        return 'dark';
      case ThemeEnum.system:
        return 'system';
    }
  }
}

extension StringThemeEnumExtension on String {
  ThemeEnum get themeEnum {
    switch (this) {
      case 'light':
        return ThemeEnum.light;
      case 'dark':
        return ThemeEnum.dark;
      case 'system':
        return ThemeEnum.system;
      default:
        throw ArgumentError('Invalid theme mode: $this');
    }
  }
}
