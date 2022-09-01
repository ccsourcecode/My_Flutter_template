import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/theme/theme_bloc.dart';

class SwitchModeButton extends StatelessWidget {
  const SwitchModeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Switch(
          inactiveThumbColor: Theme.of(context).primaryColorLight,
          activeColor: Theme.of(context).primaryColorDark,
          value: state.isDark,
          onChanged: (isDark) {
            BlocProvider.of<ThemeBloc>(context).add(ThemeChange(isDark));
          },
        );
      },
    );
  }
}
