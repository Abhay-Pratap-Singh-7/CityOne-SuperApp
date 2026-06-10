import 'package:cityoneapp/screens/city_selector_sheet.dart';
import 'package:cityoneapp/screens/grocery/grocery_screen.dart';
import 'package:cityoneapp/screens/cart/review_cart_screen.dart';
import 'package:cityoneapp/screens/ride/unified_transport_hub_screen.dart';
import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart'; // Adjust path as needed

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.white,

      // ==========================================
      // TOP APP BAR
      // ==========================================
      appBar: const _HomeAppBar(),

      // ==========================================
      // MAIN SCROLLABLE CONTENT
      // ==========================================
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: CityOneTheme.spacingBase,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _SearchSection(),
              SizedBox(height: CityOneTheme.spacingSectionMargin),

              _BentoGridSection(),
              SizedBox(height: CityOneTheme.spacingSectionMargin),

              _DealOfTheDaySection(),
              SizedBox(height: CityOneTheme.spacingSectionMargin),

              _TrendingSection(),
              SizedBox(height: CityOneTheme.spacingSectionMargin),

              _DailyEssentialsSection(),
              SizedBox(height: CityOneTheme.spacingSectionMargin),

              _CurrentActivitySection(),
              SizedBox(height: CityOneTheme.spacingSectionMargin),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: TOP APP BAR
// -----------------------------------------------------------------------------
class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar();

  static final location = "lucknow";

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 70,
      // User Avatar
      leading: Padding(
        padding: const EdgeInsets.only(left: CityOneTheme.spacingGutter),
        child: Icon(Icons.person, size: 32),
      ),
      // Location Selector
      title: InkWell(
        onTap: () => CitySelectorSheet.show(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              location,
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
      // Notification Bell
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: CityOneTheme.spacingGutter),
          child: Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart_rounded,
                  color: colorScheme.onSurface,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReviewCartScreen()),
                  );
                },
              ),
              Positioned(
                top: 12,
                right: 12,
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
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// -----------------------------------------------------------------------------
// COMPONENT: SEARCH SECTION
// -----------------------------------------------------------------------------
class _SearchSection extends StatelessWidget {
  const _SearchSection();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: CityOneTheme.spacingGutter,
      ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Where to? Search rides, groceries...",
            hintStyle: textTheme.bodyLarge?.copyWith(
              color: colorScheme.secondary,
            ),
            prefixIcon: Icon(Icons.search, color: colorScheme.onSurface),
            filled: true,
            fillColor: colorScheme.surface, // Maps to surface-container-lowest
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
              borderSide: BorderSide(color: colorScheme.onSurfaceVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
              borderSide: BorderSide(color: colorScheme.onSurfaceVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
              borderSide: BorderSide(color: colorScheme.onSurfaceVariant),
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: BENTO GRID CATEGORIES
// -----------------------------------------------------------------------------
class _BentoGridSection extends StatelessWidget {
  const _BentoGridSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: CityOneTheme.spacingGutter,
      ),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.5, // Controls the height of the grid items
        children: const [
          _BentoCard(
            title: "Grocery",
            icon: Icons.shopping_bag,
            isPrimary: true,
            badgeText: "FAST",
            nav: GroceryScreen(),
          ),
          _BentoCard(title: "Ride", icon: Icons.local_taxi, isPrimary: false, nav: UnifiedTransportHubScreen(),),
          _BentoCard(title: "Hotel", icon: Icons.apartment, isPrimary: false, nav: Placeholder(),),
          _BentoCard(
            title: "Local Services",
            icon: Icons.construction,
            isPrimary: false,
            nav: Placeholder(),
          ),
        ],
      ),
    );
  }
}

class _BentoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isPrimary;
  final String? badgeText;
  final Widget nav;

  const _BentoCard({
    required this.title,
    required this.icon,
    required this.isPrimary,
    this.badgeText,
    required this.nav
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isPrimary
                ? colorScheme.primaryContainer
                : colorScheme.surface,
            borderRadius: BorderRadius.circular(CityOneTheme.radiusDefault),
            border: isPrimary ? null : Border.all(color: colorScheme.outline),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nav),
            ),
            borderRadius: BorderRadius.circular(CityOneTheme.radiusDefault),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 40,
                    color: isPrimary
                        ? colorScheme.onSurface
                        : colorScheme.primary,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (badgeText != null)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: colorScheme.onSurface,
                borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
              ),
              child: Text(
                badgeText!,
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onPrimary,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: DEAL OF THE DAY BANNER
// -----------------------------------------------------------------------------
class _DealOfTheDaySection extends StatelessWidget {
  const _DealOfTheDaySection();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      color: colorScheme.primaryContainer,
      padding: const EdgeInsets.symmetric(
        horizontal: CityOneTheme.spacingGutter,
        vertical: 24,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DEAL OF THE DAY",
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurface,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "50% Off\nYour First Ride!",
                style: textTheme.displayMedium?.copyWith(
                  color: colorScheme.onSurface,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.surface.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(CityOneTheme.radiusSm),
                ),
                child: Text(
                  "Use code: CITYONE50",
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: -20,
            bottom: -40,
            child: Opacity(
              opacity: 0.9,
              child: Icon(
                Icons.local_taxi,
                size: 140,
                color: colorScheme.onPrimaryContainer.withOpacity(0.2),
              ),
              // In a real app, use the actual image here:
              // Image.network('http://...', width: 140)
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: TRENDING THINGS (Horizontal Scroll)
// -----------------------------------------------------------------------------
class _TrendingSection extends StatelessWidget {
  const _TrendingSection();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: CityOneTheme.spacingGutter,
          ),
          child: Text("Trending Things", style: textTheme.displaySmall),
        ),
        const SizedBox(height: CityOneTheme.spacingStackGap),
        SizedBox(
          height: 170, // Height for image + text
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: CityOneTheme.spacingGutter,
            ),
            children: const [
              _TrendingItem(title: "Fresh Produce", isHot: true),
              SizedBox(width: 16),
              _TrendingItem(title: "Airport Transfers"),
              SizedBox(width: 16),
              _TrendingItem(title: "Luxury Stays"),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrendingItem extends StatelessWidget {
  final String title;
  final bool isHot;

  const _TrendingItem({required this.title, this.isHot = false});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(CityOneTheme.radiusLg),
                ),
                child: const Center(
                  child: Icon(Icons.image, size: 40, color: Colors.grey),
                ),
              ),
              if (isHot)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(
                        CityOneTheme.radiusSm,
                      ),
                    ),
                    child: Text(
                      "HOT",
                      style: textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: DAILY ESSENTIALS GRID
// -----------------------------------------------------------------------------
class _DailyEssentialsSection extends StatelessWidget {
  const _DailyEssentialsSection();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: CityOneTheme.spacingGutter,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Daily Essentials", style: textTheme.displaySmall),
              Text(
                "View All",
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: CityOneTheme.spacingStackGap),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _EssentialItem(title: "Milk &\nDairy", icon: Icons.water_drop),
              _EssentialItem(
                title: "Bread &\nBakery",
                icon: Icons.bakery_dining,
              ),
              _EssentialItem(title: "Fresh\nVeggies", icon: Icons.grass),
              _EssentialItem(title: "Fresh\nFruits", icon: Icons.apple),
            ],
          ),
        ],
      ),
    );
  }
}

class _EssentialItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const _EssentialItem({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            shape: BoxShape.circle,
            border: Border.all(color: colorScheme.outline),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          textAlign: TextAlign.center,
          style: textTheme.labelMedium?.copyWith(height: 1.1),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: CURRENT ACTIVITY STATUS CARD
// -----------------------------------------------------------------------------
class _CurrentActivitySection extends StatelessWidget {
  const _CurrentActivitySection();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: CityOneTheme.spacingGutter,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Current Activity", style: textTheme.displaySmall),
          const SizedBox(height: CityOneTheme.spacingStackGap),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(CityOneTheme.radiusLg),
              border: Border.all(color: colorScheme.outline),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  // Left Active Stripe
                  Container(width: 8, color: colorScheme.primaryContainer),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: colorScheme.surfaceContainer,
                      child: Icon(
                        Icons.shopping_bag,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Grocery Delivery",
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.onSurface,
                                borderRadius: BorderRadius.circular(
                                  CityOneTheme.radiusFull,
                                ),
                              ),
                              child: Text(
                                "LIVE",
                                style: textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Arriving in 12 mins • Driver approaching",
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.secondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.chevron_right,
                      color: colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
