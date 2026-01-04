import 'package:expenses_tracker/providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeCard extends ConsumerWidget {
  const ThemeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.teal[300],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wb_sunny_outlined),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          CupertinoSwitch(
            value: ref.watch(themeProvider).isDark,
            onChanged: (value) {
              ref.watch(themeProvider.notifier).toggleTheme(value);
            },
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          Icon(Icons.dark_mode_outlined),
        ],
      ),
    );
  }
}
