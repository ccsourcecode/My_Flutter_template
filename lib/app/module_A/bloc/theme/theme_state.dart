part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeData themeData;
  final bool isDark;

  const ThemeState({
    required this.isDark,
    required this.themeData,
  });

  ThemeState copyWith({
    ThemeData? themeData,
    bool? isDark,
  }) {
    return ThemeState(
      isDark: isDark ?? this.isDark, 
      themeData: themeData ?? this.themeData,
      );
  }


  @override
  List<Object> get props => [themeData, isDark];
}