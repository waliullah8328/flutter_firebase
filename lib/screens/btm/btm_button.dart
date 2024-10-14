import 'package:flutter/material.dart';

class BTMButtonWidget extends StatelessWidget {
  const BTMButtonWidget({super.key, required this.text, required this.icon, required this.onTap, required this.opacity});

  final String text;
  final double opacity;
  final  IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Opacity(
        opacity: opacity,
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Icon(icon, color: Theme.of(context).primaryColor),
              Text(text, style: TextStyle(
                color: Theme.of(context).primaryColor
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
