import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart'; // Adjust path if needed

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // State for the quantity selector
  int _selectedVariantIndex = 0;

  // Mock data for variants
  final List<Map<String, dynamic>> _variants = [
    {"weight": "500g", "price": "45"},
    {"weight": "1kg", "price": "85"},
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      
      // ==========================================
      // FIXED BOTTOM ACTION BAR
      // ==========================================
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
          CityOneTheme.spacingContainerPadding,
          CityOneTheme.spacingContainerPadding,
          CityOneTheme.spacingContainerPadding,
          MediaQuery.of(context).padding.bottom + CityOneTheme.spacingContainerPadding, // pb-safe equivalent
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface, // bg-surface-container-lowest
          border: Border(top: BorderSide(color: colorScheme.surfaceVariant)),
        ),
        child: ElevatedButton(
          onPressed: () {
            // Handle Add to Cart
          },
          child: Text("Add to Cart - ₹${_variants[_selectedVariantIndex]['price']}"),
        ),
      ),

      // ==========================================
      // MAIN CONTENT (Image + Scrollable Details)
      // ==========================================
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // --- HERO IMAGE ---
                Container(
                  height: 353, // Specific height from HTML
                  width: double.infinity,
                  color: colorScheme.surfaceContainer,
                  padding: const EdgeInsets.all(32.0),
                  child: SafeArea(
                    bottom: false,
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuDikB8PazlmkUGYjpbect3bSddeSfKUlDsmDGmYs_2fkLNAyQLeRnnI61RlKBLCT-PIGG1Fl9OQUKXecmK0bLrsCFkDpkBOYOvv1v40Q5nwMaa6TCBIho-mDpNgO0JXTqPfD6PVXfMhTkSTgDj7R0svjtJYpoYEZQZfROuULhv_pr0-s8CIfPz1XzDwj_3HSjKGe_u_ZJCq3Qa8f6buAIbZ7rindwfIJOTptYwz0TtKF-u-VyU88JWRH7ig2mReFV4jW_7CZm__uK4',
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Icon(Icons.image, size: 100, color: colorScheme.surfaceVariant),
                    ),
                  ),
                ),

                // --- CONTENT CANVAS (Overlaps the image slightly) ---
                Container(
                  // Translates the container up by 16px to create the overlap (-mt-4)
                  transform: Matrix4.translationValues(0.0, -16.0, 0.0),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(CityOneTheme.radiusLg),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: CityOneTheme.spacingContainerPadding,
                    vertical: CityOneTheme.spacingSectionMargin,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      // 1. Delivery Tag
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.bolt, size: 16, color: colorScheme.onSurface),
                            const SizedBox(width: 4),
                            Text(
                              "Arriving in 10 mins",
                              style: textTheme.labelLarge?.copyWith(color: colorScheme.onSurface),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: CityOneTheme.spacingStackGap),

                      // 2. Title & Description
                      Text(
                        "Robusta Bananas",
                        style: textTheme.displayMedium?.copyWith(
                          color: colorScheme.onSurface,
                          letterSpacing: -0.5, // tracking-tight
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Sourced fresh daily",
                        style: textTheme.bodyLarge?.copyWith(color: colorScheme.secondary),
                      ),

                      const SizedBox(height: 24), // Spacer

                      // 3. Quantity Selector
                      Text(
                        "Select Quantity",
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: CityOneTheme.spacingBase),
                      
                      Row(
                        children: [
                          Expanded(child: _buildVariantCard(0)),
                          const SizedBox(width: CityOneTheme.spacingGutter),
                          Expanded(child: _buildVariantCard(1)),
                        ],
                      ),

                      const SizedBox(height: CityOneTheme.spacingSectionMargin),

                      // 4. Product Details / Extra Info
                      Container(
                        padding: const EdgeInsets.only(top: 24),
                        decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: colorScheme.surfaceVariant)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Product Information",
                              style: textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: CityOneTheme.spacingBase),
                            Text(
                              "Naturally sweet and rich in potassium, these Robusta bananas are carefully handpicked to ensure the highest quality. Perfect for a quick energy boost, smoothies, or baking.",
                              style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary, height: 1.4),
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

          // ==========================================
          // TOP ACTION BAR (Floating over the image)
          // ==========================================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CityOneTheme.spacingContainerPadding,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFloatingButton(Icons.arrow_back, () => Navigator.pop(context)),
                  _buildFloatingButton(Icons.share, () { /* Handle share */ }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget: Floating Action Buttons for the Header
  Widget _buildFloatingButton(IconData icon, VoidCallback onTap) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Material(
      color: colorScheme.surface, // bg-surface-container-lowest
      shape: const CircleBorder(),
      elevation: 2, // shadow-sm
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 48,
          height: 48,
          child: Icon(icon, color: colorScheme.onSurface),
        ),
      ),
    );
  }

  // Helper Widget: Variant / Quantity Selection Card
  Widget _buildVariantCard(int index) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isSelected = _selectedVariantIndex == index;
    final variant = _variants[index];

    return GestureDetector(
      onTap: () => setState(() => _selectedVariantIndex = index),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // Main Card
          AnimatedContainer(
            width: double.infinity,
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: isSelected ? colorScheme.surface : colorScheme.surface,
              borderRadius: BorderRadius.circular(CityOneTheme.radiusMd), // rounded-xl
              border: Border.all(
                color: isSelected ? colorScheme.onSurface : colorScheme.outline,
                width: isSelected ? 2.0 : 1.0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  variant["weight"],
                  style: textTheme.displaySmall?.copyWith(color: colorScheme.onSurface),
                ),
                const SizedBox(height: 4),
                Text(
                  "₹${variant['price']}",
                  style: textTheme.bodyLarge?.copyWith(color: colorScheme.secondary),
                ),
              ],
            ),
          ),
          
          // Floating "Selected" Badge
          if (isSelected)
            Positioned(
              top: -10, // -top-2.5
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: colorScheme.onSurface,
                  borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
                ),
                child: Text(
                  "SELECTED",
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.surface, // Text matches background
                    fontSize: 9,
                    letterSpacing: 1.0, // tracking-wider
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}