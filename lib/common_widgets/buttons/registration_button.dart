import 'package:dailypulsenews/core/core.dart';
import 'package:flutter/material.dart';

class RegistrationButton extends StatelessWidget {
  final Function() onTap;
  final String title;
  final bool selected;

  const RegistrationButton(
      {super.key,
        required this.onTap,
        required this.title,
        required this.selected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 190,
        decoration: BoxDecoration(
            border: selected
                ? Border(
                bottom: BorderSide(
                  color: context.colorScheme.primary,
                  width: 5,
                ))
                : null),
        child: Center(
            child: Text(
              title,
              style: context.textTheme.headlineMedium,
            )),
      ),
    );
  }
}
