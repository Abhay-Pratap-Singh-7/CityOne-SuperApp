import 'dart:ui';
import 'package:cityoneapp/screens/hotels/room_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart';

class HotelDetailScreen extends StatelessWidget {
  const HotelDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      
      // Fixed Bottom Bar with Glassmorphism
      bottomNavigationBar: Container(
        decoration: BoxDecoration(border: Border(top: BorderSide(color: colorScheme.outline))),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: colorScheme.surface.withOpacity(0.9),
              padding: EdgeInsets.fromLTRB(
                CityOneTheme.spacingGutter,
                CityOneTheme.spacingGutter,
                CityOneTheme.spacingGutter,
                MediaQuery.of(context).padding.bottom + CityOneTheme.spacingGutter,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Price per night", style: textTheme.labelMedium?.copyWith(color: colorScheme.secondary)),
                      Text("\$285", style: textTheme.displayMedium?.copyWith(color: colorScheme.onSurface)),
                    ],
                  ),
                  IntrinsicWidth(
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RoomSelectionScreen())),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
                      child: const Text("Select Room"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      
      body: Stack(
        children: [
          // Background Hero Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuCvJXP8TJPUUzw7XpchgP3M58Kqaf9Il_wJ3lsXZjaXxk_bEHUAqrQmkXHR9db-gLZx6VP2BVU1zhvm_8A_FfSKV0fyQQCqLK3__zgxlYas5bCDxBBUfPxHzktsKMkJjTjxDHCGfKYbygHmvRB3ZlxmQhy4PnbPUTF491sRv63ypp374KqnTzxo7ugBxrLh-q50yYSnYExe-8DJXYrWcoh9snCBglnGZcd4K0FOENLzmDIJtWsnwRLY14GM_giVEg2P_s6VuGvanzw',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: colorScheme.surfaceContainerHigh),
            ),
          ),
          
          // Custom Top App Bar (Transparent)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildGlassIcon(context, Icons.arrow_back, () => Navigator.pop(context)),
                    _buildGlassIcon(context, Icons.search, () {}),
                  ],
                ),
              ),
            ),
          ),
          
          // Scrollable Content Sheet
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.35, // Overlap image
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Drag Handle
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 16, bottom: 8),
                        width: 48,
                        height: 6,
                        decoration: BoxDecoration(color: colorScheme.outline, borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(CityOneTheme.spacingGutter),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Text("The Grand Obsidian Hotel & Spa", style: textTheme.displayMedium?.copyWith(color: colorScheme.onSurface)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: colorScheme.secondary),
                              const SizedBox(width: 4),
                              Text("Downtown Metro District", style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary)),
                            ],
                          ),
                          const SizedBox(height: CityOneTheme.spacingSectionMargin),
                          
                          // Bento Row
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 100,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: colorScheme.primaryContainer,
                                    borderRadius: BorderRadius.circular(CityOneTheme.radiusMd),
                                    border: Border.all(color: colorScheme.surfaceContainerHighest),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text("4.9", style: textTheme.displaySmall?.copyWith(color: colorScheme.onSurface)),
                                          const SizedBox(width: 4),
                                          Icon(Icons.star, size: 16, color: colorScheme.onSurface),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Exceptional", style: textTheme.labelLarge?.copyWith(color: colorScheme.onSurface)),
                                          Text("1,240 reviews", style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurface.withOpacity(0.8))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: colorScheme.surfaceContainer,
                                    borderRadius: BorderRadius.circular(CityOneTheme.radiusMd),
                                    border: Border.all(color: colorScheme.surfaceContainerHighest),
                                    image: const DecorationImage(
                                      image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuAF5WrDNP8mWIABJUBxmmA0wqwYf_JvJwgEaCaNnc6negq0DHmiG64H7SHNQPqGUJMfNuiEohTCdogZVp4j4gIVnKJWLIZUBMrzCm4_GWFoP4LfkVx7pyCAjRzpnlrrbYXswYjbS_8B6p0t0exXccP9vgMGSfu165bBqdAfFF3lNducH6gyQwTKbLRpzsBvIOBX7Q8KZAnTW4Wq-4seR6-fN1HFDurwOXIwE9tEtfTID_1Gu09RBdgB4SgkDQqBa7UvyAFB3J2MTVA'),
                                      fit: BoxFit.cover,
                                      opacity: 0.5,
                                    ),
                                  ),
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(color: colorScheme.surface.withOpacity(0.9), borderRadius: BorderRadius.circular(4)),
                                      child: Text("View Map", style: textTheme.labelLarge?.copyWith(color: colorScheme.onSurface)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: CityOneTheme.spacingSectionMargin),
                          
                          // Amenities
                          Text("Amenities", style: textTheme.displaySmall),
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 2.5,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            children: const [
                              _AmenityCard(icon: Icons.wifi, title: "Free Wi-Fi"),
                              _AmenityCard(icon: Icons.pool, title: "Infinity Pool"),
                              _AmenityCard(icon: Icons.spa, title: "Luxury Spa"),
                              _AmenityCard(icon: Icons.fitness_center, title: "Gym 24/7"),
                            ],
                          ),
                          
                          const SizedBox(height: CityOneTheme.spacingSectionMargin),
                          
                          // About
                          Text("About", style: textTheme.displaySmall),
                          const SizedBox(height: CityOneTheme.spacingStackGap),
                          Text(
                            "Experience unparalleled luxury in the heart of the city. The Grand Obsidian offers a striking blend of modern architecture and exceptional service, designed for those who demand the best in high-velocity urban living.",
                            style: textTheme.bodyMedium?.copyWith(color: colorScheme.secondary, height: 1.5),
                          ),
                          const SizedBox(height: 48), // Padding for bottom bar
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassIcon(BuildContext context, IconData icon, VoidCallback onTap) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(icon, color: Theme.of(context).colorScheme.onSurface),
            onPressed: onTap,
          ),
        ),
      ),
    );
  }
}

class _AmenityCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const _AmenityCard({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(CityOneTheme.radiusMd),
        border: Border.all(color: colorScheme.surfaceContainerHighest),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: colorScheme.surface,
            radius: 16,
            child: Icon(icon, color: colorScheme.primary, size: 16),
          ),
          const SizedBox(width: 8),
          Text(title, style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}