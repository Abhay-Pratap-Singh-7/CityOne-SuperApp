import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart';

class DairyWaterScreen extends StatelessWidget {
  const DairyWaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Dairy & Water',
          style: textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w900,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: colorScheme.surfaceVariant, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: CityOneTheme.spacingContainerPadding,
          vertical: CityOneTheme.spacingSectionMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _HeroSection(),
            SizedBox(height: CityOneTheme.spacingSectionMargin),
            _CategoryGrid(),
            SizedBox(height: CityOneTheme.spacingSectionMargin),
            _SubscriptionList(),
            SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            width: MediaQuery.of(context).size.width * 0.45,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              child: Opacity(
                opacity: 0.9,
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuB0xwsKyOyjJIisI98mq4XivyWJxzH4WT63wywrhPfBRkrHRiCsufHSbgkmZ4kgYVHoR_X5PKkwSUiqn7LqWPUOqV4oFXFdp0JCIkRxfJL9mJt3mCP-Q5aq6kx7xyvYQaDGo-kgnRdcP4ppfyBG0oD18dkKcMB_riwAb-WpfzzgBv-kVt2fvI3iLWvIRF8tgJiSrbymycCrmLsBt1819dDkipF5FEvSxt6I-5sc4d0VMYtkclOAzuMJcGjwirEu6V5Ah6beAS-3VE8',
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomLeft,
                  color: colorScheme.primaryContainer.withOpacity(0.5),
                  colorBlendMode: BlendMode.darken,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(
                        CityOneTheme.radiusFull,
                      ),
                    ),
                    child: Text(
                      'SAVE UP TO 20%',
                      style: textTheme.labelLarge?.copyWith(
                        color: colorScheme.onPrimary,
                        letterSpacing: 1.0,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Get Fresh Dairy & Water Daily',
                    style: textTheme.displaySmall?.copyWith(
                      color: colorScheme.onSurface,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.onSurface,
                      foregroundColor: colorScheme.onPrimary,
                      minimumSize: const Size(0, 32),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                    child: const Text(
                      'Subscribe Now',
                      style: TextStyle(fontSize: CityOneTheme.spacingBase),
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

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('Shop by Category', style: textTheme.displaySmall),
        ),
        const SizedBox(height: CityOneTheme.spacingStackGap),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: CityOneTheme.spacingGutter,
          crossAxisSpacing: CityOneTheme.spacingGutter,
          childAspectRatio: 2,
          children: const [
            _CategoryCard(title: 'Fresh Milk', icon: Icons.water_drop),
            _CategoryCard(title: 'Curd & Yogurt', icon: Icons.local_dining),
            _CategoryCard(title: 'Paneer & Tofu', icon: Icons.category),
            _CategoryCard(title: 'Packaged Water', icon: Icons.water_drop),
          ],
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _CategoryCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(CityOneTheme.radiusMd),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(CityOneTheme.radiusMd),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: colorScheme.onSurface),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubscriptionList extends StatelessWidget {
  const _SubscriptionList();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('Water Subscriptions', style: textTheme.displaySmall),
        ),
        const SizedBox(height: CityOneTheme.spacingStackGap),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return const _SubscriptionCard(
                title: '20L Jar - 30 Days',
                subtitle: 'Daily Delivery',
                price: '₹1200',
                isBestValue: true,
                isPrimaryStyle: true,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SubscriptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final bool isBestValue;
  final bool isPrimaryStyle;

  const _SubscriptionCard({
    required this.title,
    required this.subtitle,
    required this.price,
    this.isBestValue = false,
    this.isPrimaryStyle = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 260,
      height: 180,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(CityOneTheme.radiusXl),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Stack(
          children: [
            if (isBestValue)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(CityOneTheme.radiusMd),
                      topRight: Radius.circular(CityOneTheme.radiusXl),
                    ),
                  ),
                  child: Text(
                    'Best Value',
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: colorScheme.surfaceContainer,
                        child: Icon(
                          Icons.opacity,
                          color: isPrimaryStyle
                              ? colorScheme.primary
                              : colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              subtitle,
                              style: textTheme.displaySmall?.copyWith(
                                color: colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: colorScheme.outline)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          price,
                          style: textTheme.displaySmall?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(
                          height: 36,
                          child: isPrimaryStyle
                              ? ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorScheme.primaryContainer,
                                    foregroundColor: colorScheme.onSurface,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                  ),
                                  child: const Text('Select'),
                                )
                              : OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: colorScheme.onSurface,
                                    side: BorderSide(
                                      color: colorScheme.onSurface,
                                      width: 2,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                  ),
                                  child: const Text('Select'),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
