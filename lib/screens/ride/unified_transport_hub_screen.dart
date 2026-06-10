import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart';

class UnifiedTransportHubScreen extends StatelessWidget {
  const UnifiedTransportHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Book a Ride",
          style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(CityOneTheme.spacingContainerPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _RideTypeToggle(),
            SizedBox(height: CityOneTheme.spacingSectionMargin),
            _LocationInputCard(),
            SizedBox(height: CityOneTheme.spacingStackGap),
            _QuickFilters(),
            SizedBox(height: CityOneTheme.spacingSectionMargin),
            _RecentPlaces(),
          ],
        ),
      ),
    );
  }
}

class _RideTypeToggle extends StatelessWidget {
  const _RideTypeToggle();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primaryContainer,
              foregroundColor: colorScheme.onSurface,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: Column(
              children: [
                const Icon(Icons.directions_car, size: 32),
                const SizedBox(height: 8),
                Text("City Ride", style: textTheme.labelLarge),
                Text("Cab/Bike", style: textTheme.labelSmall?.copyWith(fontSize: 10)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.surfaceContainerLow,
              foregroundColor: colorScheme.secondary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: Column(
              children: [
                const Icon(Icons.directions_bus, size: 32),
                const SizedBox(height: 8),
                Text("Intercity", style: textTheme.labelLarge),
                Text("Bus/Train", style: textTheme.labelSmall?.copyWith(fontSize: 10)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LocationInputCard extends StatelessWidget {
  const _LocationInputCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(CityOneTheme.radiusLg),
        border: Border.all(color: colorScheme.surfaceVariant),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
      ),
      child: Stack(
        children: [
          // Vertical dotted line
          Positioned(
            left: 13,
            top: 36,
            bottom: 36,
            child: Container(
              width: 2,
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: colorScheme.surfaceVariant, style: BorderStyle.solid, width: 2)), // Use solid as flutter lacks native dotted
              ),
            ),
          ),
          Column(
            children: [
              // Pickup
              Row(
                children: [
                  Container(
                    width: 28,
                    alignment: Alignment.center,
                    child: Container(width: 10, height: 10, decoration: BoxDecoration(color: const Color(0xFF10B981), shape: BoxShape.circle, border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2), width: 4))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(color: colorScheme.surface, borderRadius: BorderRadius.circular(8), border: Border.all(color: colorScheme.surfaceVariant)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pickup", style: textTheme.labelSmall?.copyWith(color: colorScheme.secondary)),
                          Text("Current Location", style: textTheme.bodyLarge),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Drop
              Row(
                children: [
                  Container(
                    width: 28,
                    alignment: Alignment.center,
                    child: Container(width: 10, height: 10, decoration: BoxDecoration(color: const Color(0xFFEF4444), borderRadius: BorderRadius.circular(2), border: Border.all(color: const Color(0xFFEF4444).withOpacity(0.2), width: 4))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(color: colorScheme.surface, borderRadius: BorderRadius.circular(8), border: Border.all(color: colorScheme.surfaceVariant)),
                      child: Text("Where to?", style: textTheme.bodyLarge?.copyWith(color: colorScheme.secondary)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Swap Button
          Positioned(
            right: 0,
            top: 40,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: colorScheme.surfaceContainer,
              child: Icon(Icons.swap_vert, size: 18, color: colorScheme.onSurface),
            ),
          )
        ],
      ),
    );
  }
}

class _QuickFilters extends StatelessWidget {
  const _QuickFilters();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.schedule, size: 16),
          label: const Text("Today"),
          style: OutlinedButton.styleFrom(
            foregroundColor: colorScheme.onSurface,
            side: BorderSide(color: colorScheme.onSurface, width: 2),
            shape: const StadiumBorder(),
          ),
        ),
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.person, size: 16),
          label: const Text("1 Passenger"),
          style: OutlinedButton.styleFrom(
            foregroundColor: colorScheme.onSurface,
            side: BorderSide(color: colorScheme.surfaceVariant),
            shape: const StadiumBorder(),
          ),
        ),
      ],
    );
  }
}

class _RecentPlaces extends StatelessWidget {
  const _RecentPlaces();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recent Places", style: textTheme.displaySmall),
        const SizedBox(height: 16),
        _buildPlaceItem(context, Icons.history, "Hazratganj, Lucknow", "City Center, Main Market Area"),
        _buildPlaceItem(context, Icons.history, "Chowdhury Charan Singh Airport", "Amausi, Lucknow, Uttar Pradesh"),
        _buildPlaceItem(context, Icons.star, "Home", "124 Gomti Nagar, Vibhuti Khand", isLast: true),
      ],
    );
  }

  Widget _buildPlaceItem(BuildContext context, IconData icon, String title, String subtitle, {bool isLast = false}) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: colorScheme.surfaceContainer,
            child: Icon(icon, color: colorScheme.secondary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: isLast ? Colors.transparent : colorScheme.surfaceVariant))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                  Text(subtitle, style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}