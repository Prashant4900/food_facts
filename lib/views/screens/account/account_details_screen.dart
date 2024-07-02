import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_facts/common/constants.dart';
import 'package:food_facts/l10n/l10n.dart';
import 'package:food_facts/routes/router.dart';
import 'package:food_facts/views/components/body_widget.dart';
import 'package:food_facts/views/components/navbar.dart';
import 'package:food_facts/views/components/tile_widget.dart';
import 'package:food_facts/views/screens/auth/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

class MyAccountDetailScreen extends StatelessWidget {
  const MyAccountDetailScreen({super.key});

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
            context.pushReplacement(MyRoutes.logInScreen);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: headerNav(
              context,
              title: context.lang.accountDetails,
            ),
            body: BodyWidget(
              child: Column(
                children: [
                  verticalMargin20,
                  SettingListTile(
                    label: 'Sign Out',
                    icon: Icons.logout,
                    onTap: () => context.read<AuthBloc>().add(SignOutEvent()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
