import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart';

class ActivityHistoryScreen extends StatefulWidget {
  const ActivityHistoryScreen({super.key});

  @override
  State<ActivityHistoryScreen> createState() => _ActivityHistoryScreenState();
}

class _ActivityHistoryScreenState extends State<ActivityHistoryScreen> {
  bool _isOrdersActive = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Glassmorphic App Bar + Segmented Control
          SliverAppBar(
            backgroundColor: colorScheme.surface.withOpacity(0.85),
            pinned: true,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: colorScheme.primary),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              "Activity",
              style: textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: colorScheme.onSurface,
              ),
            ),
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(color: Colors.transparent),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(72),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(
                      CityOneTheme.radiusFull,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () =>
                              setState(() => _isOrdersActive = true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isOrdersActive
                                ? colorScheme.onSurface
                                : Colors.transparent,
                            foregroundColor: _isOrdersActive
                                ? colorScheme.surface
                                : colorScheme.onSurface,
                            elevation: _isOrdersActive ? 2 : 0,
                          ),
                          child: const Text("Orders"),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () =>
                              setState(() => _isOrdersActive = false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: !_isOrdersActive
                                ? colorScheme.onSurface
                                : Colors.transparent,
                            foregroundColor: !_isOrdersActive
                                ? colorScheme.surface
                                : colorScheme.onSurface,
                            elevation: !_isOrdersActive ? 2 : 0,
                          ),
                          child: const Text("Bookings"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Feed Content
          SliverPadding(
            padding: const EdgeInsets.all(CityOneTheme.spacingContainerPadding),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                if (_isOrdersActive) ...[
                  _buildOrderCard(
                    context,
                    title: "Grocery Dash",
                    time: "Today, 2:45 PM",
                    status: "Delivered",
                    price: "\$42.50",
                    icon: Icons.shopping_bag,
                    itemImages: [
                      "https://img.icons8.com/?size=100&id=I7MmedA7Bzff&format=png&color=000000",
                      "https://img.icons8.com/?size=100&id=wwUGl1cL0faI&format=png&color=000000",
                      "https://img.icons8.com/?size=100&id=k9MW3RMZHEkr&format=png&color=000000",
                    ],
                  ),
                  const SizedBox(height: CityOneTheme.spacingStackGap),
                  _buildOrderCard(
                    context,
                    title: "Burger Joint",
                    time: "Yesterday, 7:30 PM",
                    status: "Completed",
                    price: "\$28.00",
                    icon: Icons.restaurant,
                    itemImages: ["https://img.icons8.com/?size=100&id=erEevcUCwAMR&format=png&color=000000"],
                    extraCount: "+1",
                  ),
                ] else ...[
                  _buildBookingCard(context),
                ],
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context, {
    required String title,
    required String time,
    required String status,
    required String price,
    required IconData icon,
    required List<String> itemImages,
    String? extraCount,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outline),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: colorScheme.surfaceContainerHigh,
                    child: Icon(icon, color: colorScheme.onSurface),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        time,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.onSurface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  status,
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceBright,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.outline),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      for (int i = 0; i < itemImages.length; i++)
                        Align(
                          widthFactor: 0.6,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: colorScheme.surface,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(
                                itemImages[i],
                              ),
                            ),
                          ),
                        ),
                      if (extraCount != null)
                        Align(
                          widthFactor: 0.6,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: colorScheme.surfaceContainerHigh,
                              child: Text(
                                extraCount,
                                style: textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    "${itemImages.length + (extraCount != null ? 1 : 0)} Items",
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  price,
                  style: textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              SizedBox(
                width: 120,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.zero, // overrides global infinite width
                    backgroundColor: colorScheme.primaryContainer,
                    foregroundColor: colorScheme.onSurface,
                  ),
                  child: const Text("Reorder"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.local_taxi, color: colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    "CityRide X",
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text("COMPLETED", style: textTheme.labelSmall),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: colorScheme.primary, width: 2),
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 40,
                    color: colorScheme.surfaceContainerHigh,
                  ),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "124 Main St",
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "10:15 AM",
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Terminal 4, Airport",
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "10:55 AM",
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "\$45.20",
                    style: textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Oct 12",
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 120,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(const Size(120, 56)),
                  ),
                  child: const Text("Receipt"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
