import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_facts/common/constants.dart';
import 'package:food_facts/gen/assets.gen.dart';
import 'package:food_facts/l10n/l10n.dart';
import 'package:food_facts/routes/router.dart';
import 'package:food_facts/theme/theme_manager.dart';
import 'package:food_facts/views/components/body_widget.dart';
import 'package:food_facts/views/components/buttons.dart';
import 'package:food_facts/views/screens/auth/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_graphics/vector_graphics.dart';

class MyLoginScreen extends StatelessWidget {
  const MyLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }

          if (state is AuthSuccess) {
            context.pushReplacement(MyRoutes.home);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: BodyWidget(
              child: Column(
                children: [
                  verticalMargin32,
                  VectorGraphic(
                    loader: AssetBytesLoader(
                      Assets.svg.icon.path,
                    ),
                    width: 120,
                  ),
                  verticalMargin12,
                  Text(
                    context.lang.appName,
                    style: context.headlineMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Ab Scan Karega India',
                    style: context.bodySmall,
                  ),
                  const Spacer(flex: 3),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: context.bodySmall,
                      children: const [
                        TextSpan(text: 'By continue I agree to the '),
                        TextSpan(
                          text: 'term & conditions',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(text: ' and '),
                        TextSpan(
                          text: 'privacy policy',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalMargin12,
                  CustomElevatedButton(
                    label: context.lang.loginWithGoogle,
                    onPressed: () =>
                        context.read<AuthBloc>().add(GoogleLoginEvent()),
                  ),
                  verticalMargin24,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
