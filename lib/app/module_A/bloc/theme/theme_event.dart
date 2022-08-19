part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  final bool isDark;
  const ThemeEvent(this.isDark);

  @override
  List<Object> get props => [];
}

// if you want to add another event just create another class and implement the abstract class
class ThemeChange extends ThemeEvent {
  ThemeChange(bool isDark) : super(isDark);
}

