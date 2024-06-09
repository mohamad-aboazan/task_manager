import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoDataFound extends StatelessWidget {
  IconData? icon;
  String content;
  NoDataFound({super.key, this.icon, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [icon != null ? Icon(icon, size: 50) : const SizedBox(), Text(content)],
    );
  }
}
