import 'dart:ui';
import 'package:cityoneapp/screens/hotels/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart';

class RoomSelectionScreen extends StatefulWidget {
  const RoomSelectionScreen({super.key});

  @override
  State<RoomSelectionScreen> createState() => _RoomSelectionScreenState();
}

class _RoomSelectionScreenState extends State<RoomSelectionScreen> {
  int _selectedRoomIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
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
          "Select Your Room",
          style: textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w900,
            color: colorScheme.primary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: colorScheme.outline, height: 1.0),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
          CityOneTheme.spacingGutter,
          CityOneTheme.spacingGutter,
          CityOneTheme.spacingGutter,
          MediaQuery.of(context).padding.bottom + CityOneTheme.spacingGutter,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(top: BorderSide(color: colorScheme.outline)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("1 Room, 1 Night", style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary)),
                Text("Total: \$249", style: textTheme.displaySmall?.copyWith(color: colorScheme.onSurface)),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen())),
              child: const Text("Proceed to Book"),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(CityOneTheme.spacingGutter),
        child: Column(
          children: [
            _buildRoomCard(
              index: 0,
              title: "Deluxe King Skyline",
              price: "\$249",
              imgUrl: "https://images.unsplash.com/photo-1690935986319-c11e6cae84f7?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              amenities: [
                {"icon": Icons.bed, "text": "1 King Bed"},
                {"icon": Icons.location_city, "text": "City View"},
                {"icon": Icons.wifi, "text": "Free Wi-Fi"},
              ],
            ),
            const SizedBox(height: CityOneTheme.spacingStackGap),
            _buildRoomCard(
              index: 1,
              title: "Standard Double Urban",
              price: "\$189",
              imgUrl: "https://images.unsplash.com/photo-1552858725-693709cc17c7?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              amenities: [
                {"icon": Icons.bed, "text": "2 Double Beds"},
                {"icon": Icons.location_city, "text": "Partial City View"},
              ],
            ),
            const SizedBox(height: CityOneTheme.spacingStackGap),
            _buildRoomCard(
              index: 2,
              title: "Executive Suite",
              price: "\$450",
              imgUrl: "https://images.unsplash.com/photo-1629140727571-9b5c6f6267b4?q=80&w=927&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              isPremium: true,
              amenities: [
                {"icon": Icons.king_bed, "text": "1 King Bed"},
                {"icon": Icons.balcony, "text": "Private Balcony"},
                {"icon": Icons.local_bar, "text": "Mini Bar Access"},
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomCard({
    required int index,
    required String title,
    required String price,
    required String imgUrl,
    required List<Map<String, dynamic>> amenities,
    bool isPremium = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isSelected = _selectedRoomIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedRoomIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 160,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24), // squircle
          border: Border.all(
            color: isSelected ? colorScheme.onSurface : colorScheme.outline,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 30, offset: const Offset(0, 8))] : [],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Row(
              children: [
                // Left Image
                Expanded(
                  flex: 35,
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                // Right Content
                Expanded(
                  flex: 65,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            ...amenities.map((a) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                children: [
                                  Icon(a["icon"], size: 14, color: colorScheme.secondary),
                                  const SizedBox(width: 4),
                                  Text(a["text"], style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary)),
                                ],
                              ),
                            )).toList(),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: price, style: textTheme.displaySmall?.copyWith(color: colorScheme.onSurface)),
                                TextSpan(text: "/night", style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (isSelected)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(color: colorScheme.onSurface, shape: BoxShape.circle),
                  child: Icon(Icons.check, color: colorScheme.surface, size: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}