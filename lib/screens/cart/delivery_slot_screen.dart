import 'package:cityoneapp/screens/cart/payment_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart'; // Adjust path if needed

class DeliverySlotScreen extends StatefulWidget {
  const DeliverySlotScreen({super.key});

  @override
  State<DeliverySlotScreen> createState() => _DeliverySlotScreenState();
}

class _DeliverySlotScreenState extends State<DeliverySlotScreen> {
  bool _isScheduled = false;
  int _selectedDateIndex = 0;
  int _selectedTimeIndex = 1;

  final List<String> dates = ["Today", "Tomorrow", "Wed, 14", "Thu, 15"];
  final List<String> times = [
    "12:00 PM - 01:00 PM",
    "01:00 PM - 02:00 PM",
    "02:00 PM - 03:00 PM",
    "03:00 PM - 04:00 PM",
  ];

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
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "When do you want it?",
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
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentSelectionScreen()),
          ),
          child: const Text("Proceed to Payment"),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(CityOneTheme.spacingContainerPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instant Option
            _buildDeliveryOption(
              context: context,
              title: "Instant Delivery",
              subtitle: "Arriving in 10-15 minutes",
              icon: Icons.bolt,
              isSelected: !_isScheduled,
              onTap: () => setState(() => _isScheduled = false),
            ),
            const SizedBox(height: CityOneTheme.spacingStackGap),

            // Scheduled Option
            _buildDeliveryOption(
              context: context,
              title: "Schedule for later",
              subtitle: "Plan ahead for peace of mind",
              icon: Icons.schedule,
              isSelected: _isScheduled,
              onTap: () => setState(() => _isScheduled = true),
            ),

            // Animated Slider Section
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isScheduled
                  ? _buildSchedulerSection(context)
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(CityOneTheme.radiusMd),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.surface : colorScheme.surface,
          borderRadius: BorderRadius.circular(CityOneTheme.radiusMd),
          border: Border.all(
            color: isSelected ? colorScheme.onSurface : colorScheme.outline,
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: isSelected
                  ? colorScheme.primaryContainer
                  : colorScheme.surfaceContainer,
              child: Icon(icon, color: colorScheme.onSurface),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.secondary,
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

  Widget _buildSchedulerSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: CityOneTheme.spacingSectionMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Date",
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: CityOneTheme.spacingStackGap),

          // Date Pills
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final isSelected = _selectedDateIndex == index;
                return ChoiceChip(
                  label: Text(dates[index]),
                  selected: isSelected,
                  onSelected: (val) =>
                      setState(() => _selectedDateIndex = index),
                  selectedColor: colorScheme.onSurface,
                  backgroundColor: colorScheme.surface,
                  labelStyle: textTheme.labelLarge?.copyWith(
                    color: isSelected
                        ? colorScheme.onPrimary
                        : colorScheme.outline,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      CityOneTheme.radiusFull,
                    ),
                    side: BorderSide(
                      color: isSelected
                          ? colorScheme.onSurface
                          : colorScheme.outline,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: CityOneTheme.spacingSectionMargin),
          Text(
            "Select Time",
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: CityOneTheme.spacingStackGap),

          // Time Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: times.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedTimeIndex == index;
              return InkWell(
                onTap: () => setState(() => _selectedTimeIndex = index),
                borderRadius: BorderRadius.circular(CityOneTheme.radiusDefault),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(
                      CityOneTheme.radiusDefault,
                    ),
                    border: Border.all(
                      color: isSelected
                          ? colorScheme.onSurface
                          : colorScheme.outline,
                      width: isSelected ? 2.0 : 1.0,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          times[index],
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Icon(
                            Icons.check_circle,
                            size: 16,
                            color: colorScheme.onSurface,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
