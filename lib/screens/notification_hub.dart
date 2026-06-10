import 'package:cityoneapp/screens/city_selector_sheet.dart';
import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart'; 

class NotificationHubScreen extends StatelessWidget {
  const NotificationHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceBright,
      
      // ==========================================
      // TOP APP BAR (Shared standard structure)
      // ==========================================
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: CityOneTheme.spacingGutter),
          child: Icon(
            Icons.person,
            size: 32,
          ),
        ),
        title: InkWell(
          onTap: () => CitySelectorSheet.show(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Lucknow",
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: colorScheme.onSurface,
                ),
              ),
              Icon(Icons.expand_more, color: colorScheme.onSurface),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: CityOneTheme.spacingGutter),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.notifications, color: colorScheme.onSurface, size: 28),
                Positioned(
                  top: 12,
                  right: 4,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: colorScheme.error,
                      shape: BoxShape.circle,
                      border: Border.all(color: colorScheme.surface, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: colorScheme.surfaceVariant, height: 1.0),
        ),
      ),

      // ==========================================
      // MAIN CONTENT SCROLL CANVAS
      // ==========================================
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: CityOneTheme.spacingGutter,
          vertical: CityOneTheme.spacingSectionMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- TODAY SECTION ---
            _buildSectionHeader(context, "TODAY"),
            const SizedBox(height: CityOneTheme.spacingStackGap),
            
            const _HighPriorityNotificationCard(
              title: "Order Out for Delivery",
              subtitle: "Your groceries are arriving in 10 mins.",
              timeAgo: "10m ago",
              icon: Icons.shopping_bag,
            ),
            const SizedBox(height: CityOneTheme.spacingStackGap),
            
            const _StandardNotificationCard(
              title: "Exclusive Ride Offer",
              subtitle: "Get 20% off auto rides today.",
              timeAgo: "2h ago",
              icon: Icons.percent,
              isUnread: true,
            ),
            
            const SizedBox(height: CityOneTheme.spacingSectionMargin + 8),

            // --- YESTERDAY SECTION ---
            _buildSectionHeader(context, "YESTERDAY"),
            const SizedBox(height: CityOneTheme.spacingStackGap),
            
            const _StandardNotificationCard(
              title: "Ride Complete",
              subtitle: "Hope you enjoyed your ride to Hazratganj.",
              timeAgo: "1d ago",
              icon: Icons.directions_car,
              isUnread: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              letterSpacing: 2.0, // tracking-widest
            ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: HIGH PRIORITY NOTIFICATION (Bento Yellow Block)
// -----------------------------------------------------------------------------
class _HighPriorityNotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String timeAgo;
  final IconData icon;

  const _HighPriorityNotificationCard({
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(CityOneTheme.spacingContainerPadding),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer, // Vibrant Yellow background
        borderRadius: BorderRadius.circular(CityOneTheme.radiusMd),
        border: Border.all(color: colorScheme.primaryContainer),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left rounded circular token
          CircleAvatar(
            radius: 28,
            backgroundColor: colorScheme.onSurface, // Black token
            child: Icon(icon, color: colorScheme.primaryContainer, size: 28),
          ),
          const SizedBox(width: CityOneTheme.spacingGutter),
          
          // Typography Core
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      timeAgo,
                      style: textTheme.titleSmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: STANDARD NOTIFICATION (White background)
// -----------------------------------------------------------------------------
class _StandardNotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String timeAgo;
  final IconData icon;
  final bool isUnread;

  const _StandardNotificationCard({
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.icon,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(CityOneTheme.spacingContainerPadding),
      decoration: BoxDecoration(
        color: colorScheme.surface, // Matches surface-container-lowest
        borderRadius: BorderRadius.circular(CityOneTheme.radiusMd),
        border: Border.all(color: colorScheme.surfaceVariant),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4, offset: const Offset(0, 2))
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: colorScheme.surfaceVariant,
                child: Icon(
                  icon, 
                  color: isUnread ? colorScheme.onSurface : colorScheme.onSurfaceVariant, 
                  size: 28
                ),
              ),
              const SizedBox(width: CityOneTheme.spacingGutter),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: isUnread ? 24.0 : 0.0),
                            child: Text(
                              title,
                              style: isUnread 
                                  ? textTheme.titleLarge 
                                  : textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Text(
                          timeAgo,
                          style: textTheme.titleSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Floating Unread Red Orb Indicator
          if (isUnread)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: colorScheme.error, shape: BoxShape.circle),
              ),
            ),
        ],
      ),
    );
  }
}