import 'package:flutter/material.dart';
import 'package:food_facts/l10n/l10n.dart';
import 'package:food_facts/views/components/navbar.dart';

class MyAccountDetailScreen extends StatelessWidget {
  const MyAccountDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerNav(
        context,
        title: context.lang.accountDetails,
      ),
    );
  }
}
