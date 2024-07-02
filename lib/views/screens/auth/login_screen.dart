import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_facts/common/constants.dart';
import 'package:food_facts/gen/assets.gen.dart';
import 'package:food_facts/l10n/l10n.dart';
import 'package:food_facts/routes/router.dart';
import 'package:food_facts/theme/theme_manager.dart';
import 'package:food_facts/views/components/body_widget.dart';
import 'package:food_facts/views/components/buttons.dart';
import 'package:food_facts/views/components/input_field.dart';
import 'package:food_facts/views/components/navbar.dart';
import 'package:food_facts/views/screens/auth/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

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
            appBar: headerNav(context, title: context.lang.welcomeBack),
            body: BodyWidget(
              child: Column(
                children: [
                  TextFieldWithLabel(
                    label: context.lang.email,
                    hintText: context.lang.enterEmail,
                  ),
                  verticalMargin24,
                  TextFieldWithLabel(
                    label: context.lang.password,
                    hintText: context.lang.enterPassword,
                    isSecret: true,
                  ),
                  Spacer(flex: 3),
                  CustomElevatedButton(
                    label: context.lang.login,
                    onPressed: () => context.pushReplacement(MyRoutes.home),
                  ),
                  verticalMargin20,
                  verticalMargin24,
                  Column(
                    children: [
                      Text(
                        context.lang.loginWithSocial,
                        style: context.bodyMedium,
                      ),
                      verticalMargin8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () =>
                                context.pushReplacement(MyRoutes.home),
                            icon: Assets.svg.google.svg(width: 32),
                          ),
                          IconButton(
                            onPressed: () =>
                                context.pushReplacement(MyRoutes.home),
                            icon: Assets.svg.apple.svg(width: 32),
                          ),
                          IconButton(
                            onPressed: () =>
                                context.pushReplacement(MyRoutes.home),
                            icon: Assets.svg.facebook.svg(width: 32),
                          ),
                        ],
                      ),
                    ],
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
