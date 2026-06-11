import 'package:cityoneapp/screens/cart/delivery_slot_screen.dart';
import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart';

class AddressPickerScreen extends StatefulWidget {
  const AddressPickerScreen({super.key});

  @override
  State<AddressPickerScreen> createState() => _AddressPickerScreenState();
}

class _AddressPickerScreenState extends State<AddressPickerScreen> {
  int _selectedAddressIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Select Delivery Address",
          style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: colorScheme.outline, height: 1.0),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
          CityOneTheme.spacingContainerPadding,
          16,
          CityOneTheme.spacingContainerPadding,
          MediaQuery.of(context).padding.bottom + 16,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(top: BorderSide(color: colorScheme.outline)),
        ),
        child: ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DeliverySlotScreen())),
          child: const Text("Proceed to Time Slot"),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(CityOneTheme.spacingContainerPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Location Button
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(CityOneTheme.radiusDefault),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.outline),
                  borderRadius: BorderRadius.circular(CityOneTheme.radiusDefault),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: colorScheme.primaryContainer.withOpacity(0.3),
                      child: Icon(Icons.my_location, color: colorScheme.primary),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Use Current Location", style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                          Text("Enable GPS for accurate delivery", style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary)),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: colorScheme.secondary),
                  ],
                ),
              ),
            ),
            
            const Padding(
              padding: EdgeInsets.symmetric(vertical: CityOneTheme.spacingStackGap),
              child: Divider(),
            ),
            
            Text(
              "SAVED ADDRESSES",
              style: textTheme.labelLarge?.copyWith(color: colorScheme.secondary, letterSpacing: 1.0),
            ),
            const SizedBox(height: CityOneTheme.spacingStackGap),
            
            // Address 1
            _buildAddressCard(
              context: context,
              index: 0,
              icon: Icons.home,
              title: "Home",
              address: "Flat 402, Gomti Nagar, Lucknow, Uttar Pradesh 226010",
            ),
            const SizedBox(height: CityOneTheme.spacingStackGap),
            
            // Address 2
            _buildAddressCard(
              context: context,
              index: 1,
              icon: Icons.work,
              title: "Work",
              address: "Tech Park Building B, Cyber Hub, Gomti Nagar, Lucknow",
            ),
            const SizedBox(height: CityOneTheme.spacingStackGap),
            
            // Add New Address
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("Add New Address"),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                side: BorderSide(color: colorScheme.secondary.withOpacity(0.5), width: 2, style: BorderStyle.solid), // No native dashed borders
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard({
    required BuildContext context,
    required int index,
    required IconData icon,
    required String title,
    required String address,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isSelected = _selectedAddressIndex == index;

    return InkWell(
      onTap: () => setState(() => _selectedAddressIndex = index),
      borderRadius: BorderRadius.circular(CityOneTheme.radiusDefault),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primaryContainer : colorScheme.surface,
          borderRadius: BorderRadius.circular(CityOneTheme.radiusDefault),
          border: Border.all(
            color: isSelected ? colorScheme.onSurface : colorScheme.outline,
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: colorScheme.surfaceContainer,
                  child: Icon(icon, color: colorScheme.onSurface),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(address, style: textTheme.bodySmall),
                    ],
                  ),
                ),
                if (!isSelected)
                  IconButton(
                    icon: Icon(Icons.more_vert, color: colorScheme.secondary),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
            if (isSelected)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Icon(Icons.check, color: colorScheme.surface, size: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}