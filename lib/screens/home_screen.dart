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

  bool _showBanner = true;

  void _toggleBanner() {
    setState(() => _showBanner = !_showBanner);
  }

  bool _checkingUpdates = false;

  Future<void> _checkUpdates() async {
    if (_checkingUpdates) return; //guard clause
    setState(() => _checkingUpdates = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _checkingUpdates = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CampusConnect'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        actions: [
          IconButton(
            onPressed: _toggleBanner,
            tooltip: _showBanner ? 'Hide campus image' : 'Show campus image',
            icon: Icon(
              _showBanner
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
          ),
        ],
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
                if (_showBanner) ...[
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/campus_banner.png',
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.fitWidth,
                      semanticLabel: 'CampusConnect campus information banner',
                    ),
                  ),
                ],
                const Text(
                  'Explore',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                FilledButton.icon(
                  onPressed: _checkingUpdates ? null : _checkUpdates,
                  icon: _checkingUpdates
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.sync),
                  label: Text(
                    _checkingUpdates
                        ? 'Checking updates...'
                        : 'Check for updates',
                  ),
                ),
                const SizedBox(height: 12),

                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 600;
                    final cards = <Widget>[
                      FeatureCard(
                        icon: Icons.campaign_outlined,
                        title: 'Announcements',
                        subtitle: 'Important campus updates',
                        actionIcon: _isImportant
                            ? Icons.star
                            : Icons.star_border,
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
                      ),
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
