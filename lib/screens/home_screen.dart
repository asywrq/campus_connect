import 'package:flutter/material.dart';

import '../widgets/feature_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _isImportant = false;

  void _toggleImportant() {
    setState(() {
      _isImportant = !_isImportant;
    });
  }

  bool _isEventFavourite = false;

  void _toggleEventFavourite() {
    setState(() {
      _isEventFavourite = !_isEventFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CampusConnect'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to CampusConnect',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Your campus information in one place.'),
              const SizedBox(height: 20),
              const Text(
                'Explore',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 600;
                  final cards = <Widget>[
                    FeatureCard(
                      icon: Icons.campaign_outlined,
                      title: 'Announcements',
                      subtitle: 'Important campus updates',
                      actionIcon: _isImportant ? Icons.star : Icons.star_border,
                      actionLabel: _isImportant
                          ? 'Marked as Important'
                          : 'Mark as Important',
                      onAction: _toggleImportant,
                    ),
                    FeatureCard(
                      icon: Icons.event_outlined,
                      title: 'Campus Events',
                      subtitle: 'Activities and programmes',
                      actionIcon: _isEventFavourite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      actionLabel: _isEventFavourite
                          ? 'Added to Favourites'
                          : 'Add to Favourites',
                      onAction: _toggleEventFavourite,
                    ),                   
                     FeatureCard(
                        icon: Icons.person_outline,
                        title: 'My Profile',
                        subtitle: 'Student information',
                    )
                  ];
                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: cards[0]),
                        Expanded(child: cards[1]),
                        Expanded(child: cards[2]),
                      ],
                    );
                  }
                  return Column(children: cards);
                },
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
