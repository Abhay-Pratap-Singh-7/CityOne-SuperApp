import 'package:cityoneapp/screens/ride/city_ride_selector_screen.dart';
import 'package:cityoneapp/screens/ride/intercity_travel_screen.dart';
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
            // FIX 1: Added MainAxisSize.min to prevent infinite height crashes
            child: Column(
              mainAxisSize: MainAxisSize.min, 
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
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => IntercityTravelScreen())),
            style: ElevatedButton.styleFrom(
              // Using outline as a safe fallback for older Flutter SDKs
              backgroundColor: colorScheme.outline.withOpacity(0.5),
              foregroundColor: colorScheme.secondary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            // FIX 1: Added MainAxisSize.min
            child: Column(
              mainAxisSize: MainAxisSize.min,
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

    // FIX 2: Rebuilt using Rows and Columns instead of arbitrary Stack positionings 
    // to guarantee it never throws a negative constraint exception.
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(CityOneTheme.radiusLg),
        border: Border.all(color: colorScheme.outline),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Visual Route Line Indicator
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10, height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3), width: 2)
                )
              ),
              Container(
                width: 2,
                height: 48, // Fixed height connector
                color: colorScheme.outline,
              ),
              Container(
                width: 10, height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: const Color(0xFFEF4444).withOpacity(0.3), width: 2)
                )
              ),
            ],
          ),
          const SizedBox(width: 16),
          
          // Input Fields
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Pickup
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: colorScheme.outline)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pickup", style: textTheme.labelSmall?.copyWith(color: colorScheme.secondary)),
                      Text("Current Location", style: textTheme.bodyLarge),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                
                // Dropoff
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: colorScheme.outline)
                  ),
                  child: Text("Where to?", style: textTheme.bodyLarge?.copyWith(color: colorScheme.secondary)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          
          // Swap Button
          CircleAvatar(
            radius: 16,
            backgroundColor: colorScheme.outline.withOpacity(0.5),
            child: Icon(Icons.swap_vert, size: 18, color: colorScheme.onSurface),
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

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicWidth(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: colorScheme.onSurface,
                side: BorderSide(color: colorScheme.onSurface, width: 2),
                shape: const StadiumBorder(),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // ← ADD THIS
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.schedule, size: 16),
                  SizedBox(width: 8),
                  Text("Today"),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          IntrinsicWidth(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: colorScheme.onSurface,
                side: BorderSide(color: colorScheme.outline),
                shape: const StadiumBorder(),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // ← ADD THIS
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person, size: 16),
                  SizedBox(width: 8),
                  Text("1 Passenger"),
                ],
              ),
            ),
          ),
        ],
      ),
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
            backgroundColor: colorScheme.outline.withOpacity(0.5),
            child: Icon(icon, color: colorScheme.secondary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CityRideSelectorScreen())),
              child: Container(
                padding: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: isLast ? Colors.transparent : colorScheme.outline))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                    Text(
                      subtitle, 
                      style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary), 
                      maxLines: 1, 
                      overflow: TextOverflow.ellipsis
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}