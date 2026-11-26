import 'package:flutter/material.dart';
import '../models/campus_event.dart';

class EventTile extends StatelessWidget {
  final CampusEvent event;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const EventTile({
    super.key,
    required this.event,
    required this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.event, color: Theme.of(context).colorScheme.primary),
        title: Text(event.title),
        subtitle: Text('${event.date} • ${event.location}'),
        onTap: onTap,
        trailing: onRemove != null ? IconButton(
          icon: Icon(Icons.delete),
          tooltip: 'Remove ${event.title}',
          onPressed: onRemove,
        ) : null,
      ),
    );
  }
}