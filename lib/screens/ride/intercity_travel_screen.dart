import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart';

class IntercityTravelScreen extends StatelessWidget {
  const IntercityTravelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: colorScheme.onSurface), onPressed: () => Navigator.pop(context)),
        title: Text("Lucknow to Delhi", style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900)),
        actions: [IconButton(icon: Icon(Icons.edit, color: colorScheme.primary), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            _DateRibbon(),
            _TransportToggle(),
            _FilterChips(),
            _TransportList(),
          ],
        ),
      ),
    );
  }
}

class _DateRibbon extends StatelessWidget {
  const _DateRibbon();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 72,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: colorScheme.outline))),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          _buildDateCard(context, "Mon", "12", false),
          const SizedBox(width: 12),
          _buildDateCard(context, "Tue", "13", true),
          const SizedBox(width: 12),
          _buildDateCard(context, "Wed", "14", false),
          const SizedBox(width: 12),
          _buildDateCard(context, "Thu", "15", false),
        ],
      ),
    );
  }

  Widget _buildDateCard(BuildContext context, String day, String date, bool isSelected) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: 64,
      decoration: BoxDecoration(
        color: isSelected ? colorScheme.primaryContainer : colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isSelected ? colorScheme.onSurface : colorScheme.outline, width: isSelected ? 2 : 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(day, style: textTheme.labelSmall?.copyWith(color: isSelected ? colorScheme.onSurface : colorScheme.secondary)),
          Text(date, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
        ],
      ),
    );
  }
}

class _TransportToggle extends StatelessWidget {
  const _TransportToggle();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: colorScheme.surfaceContainerLow, borderRadius: BorderRadius.circular(CityOneTheme.radiusFull)),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primaryContainer, foregroundColor: colorScheme.onSurface, elevation: 0),
                child: const Text("Buses"),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: colorScheme.secondary),
                child: const Text("Trains"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ActionChip(label: const Text("Filters"), avatar: const Icon(Icons.tune, size: 16), onPressed: () {}, shape: const StadiumBorder()),
          const SizedBox(width: 8),
          ActionChip(label: const Text("AC Only"), backgroundColor: colorScheme.onSurface, labelStyle: TextStyle(color: colorScheme.surface), onPressed: () {}, shape: const StadiumBorder()),
          const SizedBox(width: 8),
          ActionChip(label: const Text("Sleeper"), onPressed: () {}, shape: const StadiumBorder()),
        ],
      ),
    );
  }
}

class _TransportList extends StatelessWidget {
  const _TransportList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _BusCard(
            title: "Volvo AC Semi-Sleeper",
            operator: "CityOne Express Travels",
            price: "₹850",
            departureTime: "21:00",
            arrivalTime: "06:00",
            duration: "9h 00m",
            seatsLeft: "12 Seats Left",
            features: const ["GPS Tracking", "Charging"],
          ),
          const SizedBox(height: 16),
          _BusCard(
            title: "Scania AC Sleeper",
            operator: "Northern Star",
            price: "₹1,200",
            departureTime: "22:30",
            arrivalTime: "07:00",
            duration: "8h 30m",
            seatsLeft: "2 Seats Left",
            features: const ["Water Bottle", "Blanket"],
            isLowSeats: true,
          ),
        ],
      ),
    );
  }
}

class _BusCard extends StatelessWidget {
  final String title;
  final String operator;
  final String price;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final String seatsLeft;
  final List<String> features;
  final bool isLowSeats;

  const _BusCard({
    required this.title,
    required this.operator,
    required this.price,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.seatsLeft,
    required this.features,
    this.isLowSeats = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(CityOneTheme.radiusLg),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: colorScheme.onSurface, borderRadius: BorderRadius.circular(CityOneTheme.radiusFull)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.directions_bus, size: 14, color: colorScheme.primaryContainer),
                const SizedBox(width: 4),
                Text("BUS", style: textTheme.labelSmall?.copyWith(color: colorScheme.primaryContainer)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                    Text(operator, style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary)),
                  ],
                ),
              ),
              Text(price, style: textTheme.displaySmall),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(departureTime, style: textTheme.displaySmall), Text("Charbagh", style: textTheme.labelSmall)],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(duration, style: textTheme.labelSmall),
                      Row(
                        children: [
                          Container(width: 6, height: 6, decoration: BoxDecoration(color: colorScheme.secondary, shape: BoxShape.circle)),
                          Expanded(child: Divider(color: colorScheme.outline, thickness: 2)),
                          Container(width: 6, height: 6, decoration: BoxDecoration(color: colorScheme.secondary, shape: BoxShape.circle)),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [Text(arrivalTime, style: textTheme.displaySmall), Text("Delhi", style: textTheme.labelSmall)],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(isLowSeats ? Icons.local_fire_department : Icons.airline_seat_recline_extra, size: 16, color: isLowSeats ? colorScheme.error : colorScheme.primary),
                      const SizedBox(width: 4),
                      Text(seatsLeft, style: textTheme.labelLarge?.copyWith(color: isLowSeats ? colorScheme.error : colorScheme.primary)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: features.map((f) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: colorScheme.surfaceContainer, borderRadius: BorderRadius.circular(4)),
                      child: Text(f, style: textTheme.labelSmall),
                    )).toList(),
                  ),
                ],
              ),
              IntrinsicWidth(
                child: ElevatedButton(
                  onPressed: () {
                    // Call _SeatSelectorSheet.show(context) here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isLowSeats ? colorScheme.surface : colorScheme.primaryContainer,
                    foregroundColor: colorScheme.onSurface,
                    side: isLowSeats ? BorderSide(color: colorScheme.onSurface, width: 2) : BorderSide.none,
                  ),
                  child: const Text("Select Seat"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}