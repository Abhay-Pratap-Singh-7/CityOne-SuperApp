import 'package:flutter/material.dart';

class ManageDetailsScreen extends StatelessWidget {
  const ManageDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: colorScheme.onSurface), onPressed: () => Navigator.pop(context)),
        title: Text("Manage Details", style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Addresses
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Saved Addresses", style: textTheme.displaySmall),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _AddressCard(title: "Home", address: "1234 Metropolitan Ave, Apt 4B\nDowntown District, NY 10001", icon: Icons.location_on),
                  const SizedBox(width: 16),
                  _AddressCard(title: "Work", address: "CityOne Headquarters\n88 Innovation Drive, Floor 12", icon: Icons.work, iconBgColor: colorScheme.surfaceContainerHighest),
                  const SizedBox(width: 16),
                  _AddCard(title: "Add Address"),
                ],
              ),
            ),
            
            const Padding(padding: EdgeInsets.symmetric(vertical: 24), child: Divider()),
            
            // Payments
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Payment Methods", style: textTheme.displaySmall),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _CreditCardWidget(),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _AddCard(title: "Add New Method", isHorizontal: true),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final String title;
  final String address;
  final IconData icon;
  final Color? iconBgColor;

  const _AddressCard({required this.title, required this.address, required this.icon, this.iconBgColor});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(backgroundColor: iconBgColor ?? colorScheme.primaryContainer, child: Icon(icon, color: colorScheme.onSurface)),
              Icon(Icons.edit, color: colorScheme.secondary, size: 20),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.displaySmall),
              Text(address, style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary), maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddCard extends StatelessWidget {
  final String title;
  final bool isHorizontal;
  const _AddCard({required this.title, this.isHorizontal = false});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: isHorizontal ? double.infinity : 160,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outline.withOpacity(0.3), width: 2), // Emulating dashed line constraint
      ),
      child: isHorizontal 
        ? Row(
            children: [
              CircleAvatar(backgroundColor: Colors.transparent, child: Icon(Icons.add, color: colorScheme.onSurface)),
              const SizedBox(width: 16),
              Text(title, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(backgroundColor: Colors.transparent, child: Icon(Icons.add, color: colorScheme.onSurface)),
              const SizedBox(height: 12),
              Text(title, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            ],
          ),
    );
  }
}

class _CreditCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1C), // Solid Black bg
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Mock Chip
              Container(
                width: 40,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFAA7C11)]),
                ),
              ),
              const Icon(Icons.edit, color: Colors.white54, size: 20),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Primary Card", style: textTheme.bodySmall?.copyWith(color: Colors.white54)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text("••••  ••••  ••••  ", style: textTheme.displayMedium?.copyWith(color: Colors.white, letterSpacing: 2)),
                  Text("4242", style: textTheme.displayMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.normal)),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("EXPIRES", style: textTheme.labelSmall?.copyWith(color: Colors.white54)),
                  Text("12/26", style: textTheme.bodyLarge?.copyWith(color: Colors.white)),
                ],
              ),
              Text("VISA", style: textTheme.displayMedium?.copyWith(color: Colors.white, fontStyle: FontStyle.italic)),
            ],
          ),
        ],
      ),
    );
  }
}