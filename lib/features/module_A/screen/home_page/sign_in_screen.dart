import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_template/core/flutter_gen/assets.gen.dart';
import 'package:my_template/core/l10n/generated/my_localizations.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("at page 4 sign in");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            child: Text(MyLocalizations.of(context)!.verificationCodeLogin,
                style: TextStyle(fontFamily: Assets.fonts.robotoThin)),
            // Image(image: AssetImage(Assets.images.home.iconShop.path),),
            onPressed: () => debugPrint("ddd"),
          ),
        ),
      ),
    );
  }
}
