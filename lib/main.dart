import 'package:cityoneapp/constants/theme.dart';
import 'package:cityoneapp/router/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CityOne());
}

class CityOne extends StatelessWidget {
  const CityOne({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: CityOneTheme.lightTheme,
    );
  }
}
