import 'package:cityoneapp/screens/activity_history_screen.dart';
import 'package:cityoneapp/screens/help_support_screen.dart';
import 'package:cityoneapp/screens/manage_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart';

class ProfileHubScreen extends StatelessWidget {
  const ProfileHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Stack(
        children: [
          // Curved Yellow Background Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 256,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(48),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Header Actions
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: CityOneTheme.spacingContainerPadding,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: colorScheme.onSurface,
                        ),
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          backgroundColor: colorScheme.surface.withOpacity(0.3),
                        ),
                      ),
                      Text(
                        "CityOne",
                        style: textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(
                        width: 48,
                      ), // Spacer to balance back button
                    ],
                  ),
                ),

                // Profile Avatar & Info
                const SizedBox(height: 16),
                Text("Alex Morgan", style: textTheme.displayMedium),
                const SizedBox(height: 16),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.surface,
                          width: 4,
                        ),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuCWVivCC-18h9ujt8GC2OL6ZufTn0Xj1iSeZUyBbmTIvst-wlP2IviMhVbwPO_WPDMsIU1Z_W5KpR7nAf0YG8vfGxAoG2EEEqNBJwQXj3I68u_q2B_hfHjEkWbvI2fJrvURzb9BZ23-a3oVCnoKRWlkHuck3ESGu6COZNHMeeAFWpmhVlc0_f45YHWfxYeHDkBVCUQvZ2U50S7wmBLjQAuNNteedaeyxSOI3FqhpaiBsO9NbMywnf1UrZmF9Kk3SWiPTPXKI_JpGKY',
                          ),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: colorScheme.onSurface,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.surface,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: colorScheme.surface,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(
                      CityOneTheme.radiusFull,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.phone_iphone,
                        size: 16,
                        color: colorScheme.tertiary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "+1 (555) 019-2834",
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Main Menu List
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: CityOneTheme.spacingContainerPadding,
                    ),
                    child: Column(
                      children: [
                        _buildMenuCard(
                          context: context,
                          items: [
                            _MenuItem(
                              icon: Icons.shopping_bag,
                              title: "My Orders",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ActivityHistoryScreen(),
                                  ),
                                );
                              },
                            ),
                            _MenuItem(
                              icon: Icons.calendar_month,
                              title: "My Bookings",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ActivityHistoryScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: CityOneTheme.spacingStackGap),
                        _buildMenuCard(
                          context: context,
                          items: [
                            _MenuItem(
                              icon: Icons.location_on,
                              title: "Address Book",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ManageDetailsScreen(),
                                  ),
                                );
                              },
                            ),
                            _MenuItem(
                              icon: Icons.credit_card,
                              title: "Payment Methods",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ManageDetailsScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: CityOneTheme.spacingStackGap),
                        _buildMenuCard(
                          context: context,
                          items: [
                            _MenuItem(
                              icon: Icons.help,
                              title: "Help & Support",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HelpSupportScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: CityOneTheme.spacingSectionMargin,
                        ),

                        // Logout
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.logout, color: colorScheme.error),
                          label: Text(
                            "Log Out",
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(64),
                            side: BorderSide(color: colorScheme.errorContainer),
                            backgroundColor: colorScheme.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: CityOneTheme.spacingSectionMargin,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required BuildContext context,
    required List<_MenuItem> items,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outline),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return Column(
            children: [
              InkWell(
                onTap: item.onTap,
                borderRadius: BorderRadius.circular(24),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: colorScheme.surfaceContainer,
                        child: Icon(item.icon, color: colorScheme.onSurface),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          item.title,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(Icons.chevron_right, color: colorScheme.tertiary),
                    ],
                  ),
                ),
              ),
              if (index < items.length - 1)
                Divider(
                  height: 1,
                  color: colorScheme.surfaceContainer,
                  indent: 16,
                  endIndent: 16,
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  _MenuItem({required this.icon, required this.title, required this.onTap});
}
