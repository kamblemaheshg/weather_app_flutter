import 'package:flutter/material.dart';

class AppBarData extends StatelessWidget implements PreferredSizeWidget {

  final String text;
  final List<Widget>? actions;

  AppBarData({
    required this.text,
    this.actions
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text),
      elevation: 0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
