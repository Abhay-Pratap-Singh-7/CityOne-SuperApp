import 'package:cityoneapp/screens/grocery/dairy_water_plan_screen.dart';
import 'package:cityoneapp/screens/grocery/grocery_search.dart';
import 'package:cityoneapp/screens/grocery/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart'; // Adjust path if needed

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  // Simple state to track the active category in the left rail
  int _activeCategoryIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {"title": "Fresh\nFruits", "icon": Icons.eco},
    {"title": "Dairy &\nBread", "icon": Icons.egg_alt},
    {"title": "Munchies", "icon": Icons.cookie},
    {"title": "Cold\nDrinks", "icon": Icons.water_drop},
    {"title": "Snacks", "icon": Icons.fastfood},
    {"title": "Meat &\nFish", "icon": Icons.set_meal},
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,

      // ==========================================
      // TOP APP BAR
      // ==========================================
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurfaceVariant),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Grocery & Daily Needs",
          style: textTheme.displaySmall?.copyWith(
            color: colorScheme.primary, // Matches text-primary font-bold
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: colorScheme.surface, height: 1.0),
        ),
      ),

      // ==========================================
      // MAIN CONTENT
      // ==========================================
      body: SafeArea(
        child: Column(
          children: [
            // --- TOP BANNER (Delivery info & Dairy quick-link) ---
            Padding(
              padding: const EdgeInsets.fromLTRB(
                CityOneTheme.spacingGutter,
                CityOneTheme.spacingSectionMargin,
                CityOneTheme.spacingGutter,
                0,
              ),
              child: Row(
                children: [
                  // Fast Delivery Banner
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 100,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(
                          CityOneTheme.radiusMd,
                        ),
                        border: Border.all(color: colorScheme.onSurfaceVariant),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: colorScheme.surface,
                            child: Icon(
                              Icons.pedal_bike,
                              color: colorScheme.primary,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Delivery in 10 Minutes",
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: colorScheme.onPrimaryContainer,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Fastest in the city",
                                  style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onPrimaryContainer
                                        .withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Dairy & Water Quick Button
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DairyWaterScreen(),
                        ),
                      ),
                      borderRadius: BorderRadius.circular(
                        CityOneTheme.radiusMd,
                      ),
                      child: Container(
                        height: 100,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(
                            CityOneTheme.radiusMd,
                          ),
                          border: Border.all(color: colorScheme.primary),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_drink,
                              color: colorScheme.primary,
                              size: 24,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Dairy & Water",
                              textAlign: TextAlign.center,
                              style: textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onPrimaryContainer,
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: CityOneTheme.spacingSectionMargin),

            // --- DUAL COLUMN LAYOUT ---
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Left Categories Rail
                  Container(
                    width:
                        MediaQuery.of(context).size.width *
                        0.28, // Matches w-[28%]
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListView.separated(
                      itemCount: _categories.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final isActive = index == _activeCategoryIndex;
                        return _CategoryItem(
                          title: _categories[index]['title'],
                          icon: _categories[index]['icon'],
                          isActive: isActive,
                          onTap: () =>
                              setState(() => _activeCategoryIndex = index),
                        );
                      },
                    ),
                  ),
                  // 2. Right Product Grid
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                        right: CityOneTheme.spacingGutter,
                        left: 4,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                              left: 4.0,
                            ),
                            child: Text(
                              _categories[_activeCategoryIndex]['title']
                                  .replaceAll('\n', ' '),
                              style: textTheme.displaySmall?.copyWith(
                                color: colorScheme.onBackground,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              padding: const EdgeInsets.only(bottom: 64),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio:
                                        0.50, // Taller items to fit image + text + button
                                  ),
                              itemCount: 3, // Mock count based on HTML
                              itemBuilder: (context, index) {
                                // Mock data parsing
                                final mockData = [
                                  {
                                    "img": "https://img.icons8.com/?size=100&id=dBmKhyC3hEFd&format=png&color=000000",
                                    "title": "Shimla Apples",
                                    "qty": "4 pcs - 500g",
                                    "price": "140",
                                  },
                                  {
                                    "img": "https://img.icons8.com/?size=100&id=p7YHa8almDEQ&format=png&color=000000",
                                    "title": "Robusta Bananas",
                                    "qty": "6 pcs",
                                    "price": "60",
                                  },
                                  {
                                    "img": "https://img.icons8.com/?size=100&id=If0zoGgGYkN5&format=png&color=000000",
                                    "title": "Nagpur Oranges",
                                    "qty": "1 kg",
                                    "price": "120",
                                  },
                                ];
                                return InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailScreen(),
                                    ),
                                  ),
                                  child: _ProductCard(
                                    imageUrl: mockData[index]["img"]!,
                                    title: mockData[index]["title"]!,
                                    quantity: mockData[index]["qty"]!,
                                    price: mockData[index]["price"]!,
                                  ),
                                );
                              },
                            ),
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
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: CATEGORY RAIL ITEM
// -----------------------------------------------------------------------------
class _CategoryItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.title,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(CityOneTheme.radiusMd),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? colorScheme.primaryContainer : colorScheme.surface,
          borderRadius: BorderRadius.circular(CityOneTheme.radiusMd),
          border: Border.all(
            color: isActive ? colorScheme.primary : colorScheme.outline,
            width: isActive ? 2.0 : 1.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 28,
              color: isActive ? colorScheme.primary : colorScheme.tertiary,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.labelSmall?.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isActive
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurface,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: PRODUCT CARD
// -----------------------------------------------------------------------------
class _ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String quantity;
  final String price;

  const _ProductCard({
    required this.imageUrl,
    required this.title,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme.surface, // bg-surface-container-lowest
        borderRadius: BorderRadius.circular(
          CityOneTheme.radiusMd,
        ), // rounded-xl
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image Container
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(CityOneTheme.radiusSm),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      Icon(Icons.image, color: colorScheme.onSurfaceVariant),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Title & Qty
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodySmall?.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                quantity,
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.tertiary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Price & Add Button
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "₹$price",
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),

              // Custom ADD Button
              SizedBox(
                width: double.infinity,
                height: 32,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: colorScheme.primaryContainer,
                    foregroundColor: colorScheme.onPrimaryContainer,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        CityOneTheme.radiusSm,
                      ),
                      side: BorderSide(color: colorScheme.primary),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        "ADD",
                        style: textTheme.labelLarge?.copyWith(
                          fontSize: 11,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
