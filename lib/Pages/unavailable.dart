import 'package:flutter/material.dart';

class AppUnavailablePage extends StatelessWidget {
  const AppUnavailablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Unavailable'),
      ),
      body: const Center(
        child: Text(
          'Internet connection not available. Please check your connection and try again.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
