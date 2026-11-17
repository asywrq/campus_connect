import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final IconData? actionIcon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? imagePath;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionIcon,
    this.actionLabel,
    this.onAction,
    this.imagePath, 
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          if (imagePath != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imagePath!,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                semanticLabel: '$title image',
              ),
            ),
          ListTile(
            leading: Icon(icon),
            title: Text(title),
            subtitle: Text(subtitle),
          ),
          if (onAction != null && actionIcon != null && actionLabel != null)
            TextButton.icon(
              onPressed: onAction,
              icon: Icon(actionIcon),
              label: Text(actionLabel!),
            ),
        ],
      ),
    );
  }
}