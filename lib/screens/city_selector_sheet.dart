import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart'; // Adjust path if needed

class CitySelectorSheet extends StatefulWidget {
  const CitySelectorSheet({super.key});

  /// Helper method to easily trigger the bottom sheet from anywhere
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the sheet to take up more screen space
      backgroundColor: Colors.transparent, // Let the container handle the radius
      builder: (context) => const CitySelectorSheet(),
    );
  }

  @override
  State<CitySelectorSheet> createState() => _CitySelectorSheetState();
}

class _CitySelectorSheetState extends State<CitySelectorSheet> {
  String _selectedCity = "New York City"; // Default selected city

  final List<String> _popularCities = [
    "New York City",
    "Los Angeles",
    "Chicago",
    "Miami",
  ];

  final List<String> _allCities = [
    "Austin",
    "Boston",
    "Denver",
    "Seattle",
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      // Max height of 85% of screen to act as a bottom sheet
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      // Padding to prevent keyboard from overlapping the content
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(CityOneTheme.radiusXl),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ==========================================
          // 1. DRAG HANDLE & HEADER
          // ==========================================
          const SizedBox(height: 12),
          Container(
            width: 48,
            height: 6,
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(
              CityOneTheme.spacingGutter, 
              16, 
              CityOneTheme.spacingGutter, 
              8
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select City",
                  style: textTheme.displaySmall?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  style: IconButton.styleFrom(
                    backgroundColor: colorScheme.surfaceVariant.withOpacity(0.5),
                  ),
                  icon: Icon(Icons.close, color: colorScheme.onSurface),
                ),
              ],
            ),
          ),

          // ==========================================
          // 2. SEARCH & LOCATION ACTION
          // ==========================================
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: CityOneTheme.spacingGutter,
              vertical: CityOneTheme.spacingStackGap,
            ),
            child: Column(
              children: [
                // Search Input
                TextField(
                  style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
                  decoration: InputDecoration(
                    hintText: "Search your city...",
                    prefixIcon: Icon(Icons.search, color: colorScheme.secondary),
                    filled: true,
                    fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0), // Handled by height constraints
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(CityOneTheme.radiusDefault),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(CityOneTheme.radiusDefault),
                      borderSide: BorderSide(color: colorScheme.onSurface, width: 1.5),
                    ),
                  ),
                ),
                
                const SizedBox(height: CityOneTheme.spacingStackGap),

                // Use Current Location Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle location permission
                    },
                    icon: const Icon(Icons.my_location),
                    label: const Text("Use Current Location"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primaryContainer,
                      foregroundColor: colorScheme.onPrimaryContainer,
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Divider(color: colorScheme.surfaceVariant, height: 1),

          // ==========================================
          // 3. CITIES LIST
          // ==========================================
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(CityOneTheme.spacingGutter),
              children: [
                // --- Popular Cities ---
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Text(
                    "POPULAR CITIES",
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.secondary,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                ..._popularCities.map((city) => _buildCityItem(city)).toList(),

                const SizedBox(height: CityOneTheme.spacingSectionMargin),

                // --- All Cities ---
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Text(
                    "ALL CITIES",
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.secondary,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                ..._allCities.map((city) => _buildCityItem(city)).toList(),
                
                const SizedBox(height: 24), // Bottom padding scroll clearance
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build individual city list items
  Widget _buildCityItem(String cityName) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    final isSelected = _selectedCity == cityName;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedCity = cityName;
          });
          // Optional: Add a slight delay before popping so the user sees the selection
          Future.delayed(const Duration(milliseconds: 200), () {
            if (mounted) Navigator.pop(context, cityName);
          });
        },
        borderRadius: BorderRadius.circular(CityOneTheme.radiusDefault),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: isSelected ? colorScheme.surfaceVariant.withOpacity(0.5) : colorScheme.surface,
            borderRadius: BorderRadius.circular(CityOneTheme.radiusDefault),
            border: Border.all(
              color: isSelected ? colorScheme.onSurface : colorScheme.surfaceVariant,
              width: isSelected ? 2.0 : 1.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cityName,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: colorScheme.primaryContainer,
                )
              else
                Icon(
                  Icons.radio_button_unchecked,
                  color: colorScheme.surfaceVariant,
                ),
            ],
          ),
        ),
      ),
    );
  }
}