import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart';

class CityRideSelectorScreen extends StatelessWidget {
  const CityRideSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Stack(
        children: [
          // MAP BACKGROUND
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Container(
              color: colorScheme.surfaceContainer,
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuCQnoTnFzD5F51d1kZ8iry1vzvUnWSr2EDt34snCxusLmvLvtQLU5k74zn-E3VKP0YkjS_VtJaubwWwWznH4Xkl5vCXiX5f0oWaPuMqyExFk_dXy2ICpfvRrU2y4QxW74RapoK1p6nIGzY7p-BfmLNHAqbquLBX5LNgHU70zVYWxb9PzPj1W7OWf6FoF85BEU6hBtyNCAmrpalye36HgOWqp5lCznM3meamFogGe8CcsS41OU9IOWG3ttR6Z9PsLcrhPwkyTR529gw',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.map)),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FloatingActionButton.small(
                        onPressed: () => Navigator.pop(context),
                        backgroundColor: colorScheme.surface,
                        child: Icon(Icons.arrow_back, color: colorScheme.onSurface),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // BOTTOM SHEET AREA
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55, // Overlaps map slightly
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 30, offset: const Offset(0, -8))],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(width: 48, height: 6, decoration: BoxDecoration(color: colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(8))),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Select a Ride", style: textTheme.displaySmall),
                        Text("Recommended routes available", style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: const [
                        _VehicleOption(
                          title: "Bike Taxi",
                          subtitle: "2 min away • Drop 10:15 AM",
                          price: "₹45",
                          oldPrice: "₹55",
                          icon: Icons.two_wheeler,
                          isFastest: true,
                          isSelected: true,
                        ),
                        SizedBox(height: 12),
                        _VehicleOption(
                          title: "Auto",
                          subtitle: "4 min away • Drop 10:17 AM",
                          price: "₹85",
                          icon: Icons.local_taxi,
                        ),
                        SizedBox(height: 12),
                        _VehicleOption(
                          title: "Shared Auto",
                          subtitle: "5 min away • Drop 10:20 AM",
                          price: "₹30",
                          icon: Icons.group,
                        ),
                        SizedBox(height: 12),
                        _VehicleOption(
                          title: "Cab Mini",
                          subtitle: "7 min away • Drop 10:22 AM",
                          price: "₹150",
                          icon: Icons.directions_car,
                        ),
                      ],
                    ),
                  ),
                  
                  // BOTTOM ACTION
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(border: Border(top: BorderSide(color: colorScheme.surfaceVariant))),
                    child: SafeArea(
                      top: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(color: colorScheme.surfaceContainer, borderRadius: BorderRadius.circular(8)),
                                    child: Icon(Icons.account_balance_wallet, color: colorScheme.primary, size: 20),
                                  ),
                                  const SizedBox(width: 12),
                                  Text("Cash", style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Icon(Icons.chevron_right, color: colorScheme.secondary),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                            child: const Text("Book Bike | ₹45"),
                          ),
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
    );
  }
}

class _VehicleOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String? oldPrice;
  final IconData icon;
  final bool isFastest;
  final bool isSelected;

  const _VehicleOption({
    required this.title,
    required this.subtitle,
    required this.price,
    this.oldPrice,
    required this.icon,
    this.isFastest = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? colorScheme.primaryContainer : colorScheme.surface,
        borderRadius: BorderRadius.circular(CityOneTheme.radiusMd),
        border: Border.all(color: isSelected ? colorScheme.onSurface : colorScheme.surfaceVariant, width: isSelected ? 2 : 1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: colorScheme.surfaceContainer,
            radius: 24,
            child: Icon(icon, color: isSelected ? colorScheme.onSurface : colorScheme.secondary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                    if (isFastest) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: colorScheme.onSurface, borderRadius: BorderRadius.circular(16)),
                        child: Text("FASTEST", style: textTheme.labelSmall?.copyWith(color: colorScheme.primaryContainer, fontSize: 10)),
                      ),
                    ]
                  ],
                ),
                Text(subtitle, style: textTheme.bodySmall?.copyWith(color: isSelected ? colorScheme.onSurface : colorScheme.secondary)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price, style: textTheme.displaySmall),
              if (oldPrice != null)
                Text(oldPrice!, style: textTheme.labelSmall?.copyWith(decoration: TextDecoration.lineThrough)),
            ],
          ),
        ],
      ),
    );
  }
}