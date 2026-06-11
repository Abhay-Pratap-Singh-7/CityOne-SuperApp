import 'dart:ui';
import 'package:cityoneapp/screens/hotels/hotel_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart'; // Adjust path

class PropertyListingScreen extends StatefulWidget {
  const PropertyListingScreen({super.key});

  @override
  State<PropertyListingScreen> createState() => _PropertyListingScreenState();
}

class _PropertyListingScreenState extends State<PropertyListingScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = [
    "Top Rated",
    "Luxury",
    "Homestays",
    "Villas",
    "Apartments",
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.surface.withOpacity(0.8),
        surfaceTintColor: Colors.transparent,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Book Stays",
          style: textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w900,
            color: colorScheme.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: colorScheme.primary),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: colorScheme.outline, height: 1.0),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // Filter Ribbon
          SliverToBoxAdapter(
            child: Container(
              height: 64,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: CityOneTheme.spacingGutter,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: CityOneTheme.spacingStackGap),
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilter == index;
                  return ActionChip(
                    label: Text(_filters[index]),
                    onPressed: () => setState(() => _selectedFilter = index),
                    backgroundColor: isSelected
                        ? colorScheme.primaryContainer
                        : Colors.transparent,
                    side: BorderSide(
                      color: isSelected
                          ? Colors.transparent
                          : colorScheme.outline,
                    ),
                    labelStyle: textTheme.labelLarge?.copyWith(
                      color: isSelected
                          ? colorScheme.onSurface
                          : colorScheme.secondary,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    shape: const StadiumBorder(),
                  );
                },
              ),
            ),
          ),

          // Property Grid
          SliverPadding(
            padding: const EdgeInsets.all(CityOneTheme.spacingGutter),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Adapts to mobile
                mainAxisSpacing: 24,
                childAspectRatio: 1.1, // Adjusts height of the card
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                return const _PropertyCard(
                  title: "The Glass House",
                  price: "\$450",
                  location: "Beverly Hills",
                  distance: "2.5 mi",
                  rating: "4.9",
                  imageUrl: "https://plus.unsplash.com/premium_photo-1675745329954-9639d3b74bbf?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                );
              }, childCount: 3),
            ),
          ),
        ],
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  final String title;
  final String price;
  final String location;
  final String distance;
  final String rating;
  final String imageUrl;

  const _PropertyCard({
    required this.title,
    required this.price,
    required this.location,
    required this.distance,
    required this.rating,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HotelDetailScreen())),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24), // Squircle emulation
          border: Border.all(color: colorScheme.outline),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Area
            Expanded(
              flex: 7,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: colorScheme.surfaceContainerHigh),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        CityOneTheme.radiusFull,
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.surface.withOpacity(0.8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: colorScheme.primaryContainer,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                rating,
                                style: textTheme.labelLarge?.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Details Area
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: textTheme.displaySmall?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: price,
                                style: textTheme.displaySmall?.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              TextSpan(
                                text: "/nt",
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: colorScheme.secondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "$location • $distance",
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
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
