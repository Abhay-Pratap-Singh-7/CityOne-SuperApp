import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart'; // Adjust path if needed

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // ==========================================
            // TOP SEARCH HEADER
            // ==========================================
            const _SearchHeader(),

            // ==========================================
            // MAIN SCROLLABLE CONTENT
            // ==========================================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: CityOneTheme.spacingContainerPadding,
                  vertical: CityOneTheme.spacingBase,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _RecentSearchesSection(),
                    SizedBox(height: CityOneTheme.spacingSectionMargin),
                    
                    _TrendingSection(),
                    SizedBox(height: CityOneTheme.spacingSectionMargin),
                    
                    _DealOfTheDaySection(),
                    SizedBox(height: CityOneTheme.spacingSectionMargin),
                    
                    _DailyEssentialsSection(),
                    SizedBox(height: 64), // Bottom padding clearance
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: SEARCH HEADER WITH FILTER BUTTON
// -----------------------------------------------------------------------------
class _SearchHeader extends StatelessWidget {
  const _SearchHeader();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        CityOneTheme.spacingBase, 
        CityOneTheme.spacingBase, 
        CityOneTheme.spacingContainerPadding, 
        CityOneTheme.spacingSectionMargin
      ),
      child: Row(
        children: [
          // Back Button
          IconButton(
            icon: Icon(Icons.arrow_back, color: colorScheme.onSurfaceVariant),
            onPressed: () => Navigator.pop(context),
          ),
          
          // Search Input Bar
          Expanded(
            child: TextField(
              autofocus: true,
              style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
              decoration: InputDecoration(
                hintText: "Search for milk, bread, chips...",
                prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
                suffixIcon: IconButton(
                  icon: Icon(Icons.tune, color: colorScheme.primary),
                  onPressed: () => FilterBottomSheet.show(context),
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainer, // bg-surface-container
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
                  borderSide: BorderSide(color: colorScheme.onBackground, width: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: RECENT SEARCHES
// -----------------------------------------------------------------------------
class _RecentSearchesSection extends StatelessWidget {
  const _RecentSearchesSection();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recent Searches", style: textTheme.displaySmall),
        const SizedBox(height: CityOneTheme.spacingStackGap),
        const _RecentItem(title: "Amul Butter"),
        const _RecentItem(title: "Onions"),
      ],
    );
  }
}

class _RecentItem extends StatelessWidget {
  final String title;

  const _RecentItem({required this.title});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(CityOneTheme.radiusDefault),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Row(
          children: [
            Icon(Icons.history, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
              ),
            ),
            IconButton(
              icon: Icon(Icons.close, color: colorScheme.tertiary, size: 20),
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: TRENDING NOW (Horizontal Scroll)
// -----------------------------------------------------------------------------
class _TrendingSection extends StatelessWidget {
  const _TrendingSection();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Trending Now ", style: textTheme.displaySmall),
            Icon(Icons.trending_up, color: colorScheme.primary),
          ],
        ),
        const SizedBox(height: CityOneTheme.spacingStackGap),
        SizedBox(
          height: 180, // Explicit height for horizontal list
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: const [
              _TrendingCard(title: "Cold Coffee", price: "₹45", url: 'https://img.icons8.com/?size=100&id=12860&format=png&color=000000',),
              SizedBox(width: 16),
              _TrendingCard(title: "Fresh Mangoes", price: "₹120", url: 'https://img.icons8.com/?size=100&id=y06NHH_kl00a&format=png&color=000000',),
              SizedBox(width: 16),
              _TrendingCard(title: "Garlic Bread", price: "₹65", url: 'https://img.icons8.com/?size=100&id=AwKd5JoNnGdo&format=png&color=000000',),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrendingCard extends StatelessWidget {
  final String title;
  final String price;
  final String url;

  const _TrendingCard({
    required this.title,
    required this.price,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 160, // w-40
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(CityOneTheme.radiusLg), // rounded-xl
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100, // Roughly h-32
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(CityOneTheme.radiusLg)),
            ),
            child: Image.network(url),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelLarge?.copyWith(color: colorScheme.onSurface),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
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
// COMPONENT: DEAL OF THE DAY
// -----------------------------------------------------------------------------
class _DealOfTheDaySection extends StatelessWidget {
  const _DealOfTheDaySection();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Deal of the Day ", style: textTheme.displaySmall),
            Icon(Icons.local_fire_department, color: colorScheme.primary),
          ],
        ),
        const SizedBox(height: CityOneTheme.spacingStackGap),
        Container(
          height: 192, // h-48
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(24), // rounded-[24px]
          ),
          child: Stack(
            children: [
              // Image aligned to right
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: MediaQuery.of(context).size.width * 0.45,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.only(
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(24)
                  ),
                  child: Opacity(
                    opacity: .9,
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuAoErFHpqUHYI3ESLJMtirHOp-79DptZqGPMRudldaYC0oeQeEAgH11-z_OQxNtWIX_pg4gCYnNcK-PKIRv3iYZPLMw26KsrRtlgfFTGthRe9XxhOgJ9IKAMNq8NaIrXPJXHqOirQxEofrZbV-UqGoC8x4923yF8Kgh1TIQveiiurGT2ebIu0liIsStSnJsm9efu86DjmqJtaBWyhpC9xyDq5DPEtbVDiDu6ZhQjm6UqQfunWSkec9eE8RrcgtbRV84PJ2xncgrd5s',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox(),
                    ),
                  ),
                ),
              ),
              // Gradient Overlay for text readability
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primaryContainer,
                      colorScheme.primaryContainer.withOpacity(0.8),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimaryContainer,
                        borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
                      ),
                      child: Text(
                        "LIMITED OFFER",
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.primaryContainer,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "50% Off",
                      style: textTheme.displayMedium?.copyWith(color: colorScheme.onPrimaryContainer),
                    ),
                    Text(
                      "Organic Honey",
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.onPrimaryContainer,
                        foregroundColor: colorScheme.primaryContainer,
                        minimumSize: const Size(100, 36),
                      ),
                      child: const Text("Shop Now"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: DAILY ESSENTIALS (3-Grid)
// -----------------------------------------------------------------------------
class _DailyEssentialsSection extends StatelessWidget {
  const _DailyEssentialsSection();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Daily Essentials", style: textTheme.displaySmall),
        const SizedBox(height: CityOneTheme.spacingStackGap),
        Row(
          children: const [
            Expanded(child: _EssentialGridItem(title: "Eggs", imageUrl: "https://img.icons8.com/?size=100&id=I7MmedA7Bzff&format=png&color=000000")),
            SizedBox(width: 12),
            Expanded(child: _EssentialGridItem(title: "Milk", imageUrl: "https://img.icons8.com/?size=100&id=wwUGl1cL0faI&format=png&color=000000")),
            SizedBox(width: 12),
            Expanded(child: _EssentialGridItem(title: "Bread", imageUrl: "https://img.icons8.com/?size=100&id=k9MW3RMZHEkr&format=png&color=000000")),
          ],
        )
      ],
    );
  }
}

class _EssentialGridItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const _EssentialGridItem({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(CityOneTheme.radiusLg), // rounded-xl
        border: Border.all(color: colorScheme.surfaceVariant),
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(CityOneTheme.radiusDefault),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(Icons.image, color: colorScheme.secondary),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: textTheme.labelLarge?.copyWith(color: colorScheme.onSurface),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: FILTER BOTTOM SHEET
// -----------------------------------------------------------------------------
class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String _sortOption = "Relevance";
  bool _fastDelivery = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: MediaQuery.of(context).size.height * 0.65, // Max height constraints
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drag Handle
          const SizedBox(height: 12),
          Container(
            width: 48,
            height: 6,
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(CityOneTheme.spacingContainerPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sort & Filter", style: textTheme.displayMedium),
                IconButton(
                  icon: Icon(Icons.close, color: colorScheme.onSurfaceVariant),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Scrollable Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: CityOneTheme.spacingContainerPadding),
              children: [
                // SORT BY
                Text(
                  "SORT BY",
                  style: textTheme.labelLarge?.copyWith(color: colorScheme.tertiary, letterSpacing: 1.0),
                ),
                const SizedBox(height: CityOneTheme.spacingStackGap),
                _buildRadioOption("Relevance", textTheme, colorScheme),
                _buildRadioOption("Price: Low to High", textTheme, colorScheme),
                
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: CityOneTheme.spacingSectionMargin),
                  child: Divider(),
                ),

                // QUICK FILTERS
                Text(
                  "QUICK FILTERS",
                  style: textTheme.labelLarge?.copyWith(color: colorScheme.tertiary, letterSpacing: 1.0),
                ),
                const SizedBox(height: CityOneTheme.spacingStackGap),
                SwitchListTile(
                  title: Text("Only available in 10 mins", style: textTheme.bodyLarge),
                  value: _fastDelivery,
                  activeColor: colorScheme.primary,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (bool value) {
                    setState(() {
                      _fastDelivery = value;
                    });
                  },
                ),
              ],
            ),
          ),
          
          // Fixed Bottom Action
          Container(
            padding: const EdgeInsets.all(CityOneTheme.spacingContainerPadding),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border(top: BorderSide(color: colorScheme.surfaceVariant)),
            ),
            child: SafeArea(
              top: false,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
                child: const Text("Apply"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String title, TextTheme textTheme, ColorScheme colorScheme) {
    return RadioListTile<String>(
      title: Text(
        title, 
        style: textTheme.bodyLarge?.copyWith(
          color: _sortOption == title ? colorScheme.primary : colorScheme.onSurface,
        )
      ),
      value: title,
      groupValue: _sortOption,
      activeColor: colorScheme.primary,
      contentPadding: EdgeInsets.zero,
      onChanged: (String? value) {
        setState(() {
          _sortOption = value!;
        });
      },
    );
  }
}