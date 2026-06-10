import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart'; 

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      
      // ==========================================
      // TOP APP BAR
      // ==========================================
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Track Your Order",
          style: textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w900,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: colorScheme.outline, height: 1.0),
        ),
      ),

      // ==========================================
      // MAIN SCROLLABLE CONTENT
      // ==========================================
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: CityOneTheme.spacingContainerPadding,
          vertical: CityOneTheme.spacingSectionMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _LiveTrackerMap(),
            SizedBox(height: CityOneTheme.spacingSectionMargin),
            
            _OrderStatusTimeline(),
            SizedBox(height: CityOneTheme.spacingSectionMargin),
            
            _DeliveryAgentCard(),
            SizedBox(height: 64), // Bottom padding clearance
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: LIVE TRACKER MAP & ETA BANNER
// -----------------------------------------------------------------------------
class _LiveTrackerMap extends StatelessWidget {
  const _LiveTrackerMap();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        // Top ETA Banner
        Container(
          padding: const EdgeInsets.all(CityOneTheme.spacingContainerPadding),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(CityOneTheme.radiusXl), // 24px
            border: Border.all(color: colorScheme.outlineVariant),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ARRIVING IN",
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      letterSpacing: 1.0,
                    ),
                  ),
                  Text(
                    "12 min",
                    style: textTheme.displayMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimaryContainer,
                  borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
                ),
                child: Text(
                  "Fastest",
                  style: textTheme.labelLarge?.copyWith(color: colorScheme.primaryContainer),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24,),
        
        // Translating the map slightly up to overlap beneath the banner
        Transform.translate(
          offset: const Offset(0, -16),
          child: Container(
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(CityOneTheme.radiusXl), // 24px
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Stack(
              children: [
                // Minimalist Grid Background pattern
                Positioned.fill(
                  child: CustomPaint(
                    painter: _GridPainter(color: colorScheme.outline),
                  ),
                ),
                
                // Destination Pin (Top Right)
                Positioned(
                  top: 40,
                  right: 40,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 6)],
                    ),
                    child: Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: colorScheme.onBackground,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Delivery Agent Pin (Center/Left with Pulse)
                Positioned(
                  top: 140,
                  left: 80,
                  child: _PulsingMarker(
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: colorScheme.onBackground,
                        shape: BoxShape.circle,
                        border: Border.all(color: colorScheme.surface, width: 2),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8)],
                      ),
                      child: Icon(Icons.two_wheeler, color: colorScheme.onPrimary, size: 24),
                    ),
                  ),
                ),

                // My Location Button
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton.small(
                    onPressed: () {},
                    backgroundColor: colorScheme.surface,
                    foregroundColor: colorScheme.onSurface,
                    elevation: 4,
                    child: const Icon(Icons.my_location),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: ORDER STATUS TIMELINE
// -----------------------------------------------------------------------------
class _OrderStatusTimeline extends StatelessWidget {
  const _OrderStatusTimeline();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(CityOneTheme.spacingContainerPadding),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(CityOneTheme.radiusLg),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order Status", style: textTheme.displaySmall),
          const SizedBox(height: CityOneTheme.spacingSectionMargin),
          
          // Timeline Stack (Line + Items)
          Stack(
            children: [
              // Continuous Vertical Line
              Positioned(
                left: 11, // Centered behind 24px circular markers
                top: 0,
                bottom: 24, // Stop before the last item
                child: Container(
                  width: 2,
                  color: colorScheme.outline,
                ),
              ),
              
              // Timeline Steps
              Column(
                children: const [
                  _TimelineStep(
                    title: "Order Placed",
                    time: "12:15 PM",
                    state: _StepState.completedYellow,
                  ),
                  _TimelineStep(
                    title: "Vendor Confirmed",
                    time: "12:20 PM",
                    state: _StepState.completedBlack,
                  ),
                  _TimelineStep(
                    title: "Agent Picked Up",
                    time: "12:30 PM",
                    state: _StepState.completedYellow,
                  ),
                  _TimelineStep(
                    title: "On the Way",
                    time: "Estimated delivery: 12:45 PM",
                    state: _StepState.active,
                  ),
                  _TimelineStep(
                    title: "Delivered",
                    time: "",
                    state: _StepState.future,
                    isLast: true,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _StepState { completedYellow, completedBlack, active, future }

class _TimelineStep extends StatelessWidget {
  final String title;
  final String time;
  final _StepState state;
  final bool isLast;

  const _TimelineStep({
    required this.title,
    required this.time,
    required this.state,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Marker
          _buildMarker(colorScheme),
          const SizedBox(width: 16),
          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: state == _StepState.active ? FontWeight.w900 : FontWeight.w500,
                    color: state == _StepState.future ? colorScheme.outline : colorScheme.onSurface,
                  ),
                ),
                if (time.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: textTheme.labelMedium?.copyWith(
                      color: state == _StepState.active ? colorScheme.primary : colorScheme.outline,
                      fontWeight: state == _StepState.active ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarker(ColorScheme colorScheme) {
    switch (state) {
      case _StepState.completedYellow:
        return _buildSolidMarker(colorScheme.primaryContainer, colorScheme.onPrimaryContainer, Icons.check, colorScheme.surface);
      case _StepState.completedBlack:
        return _buildSolidMarker(colorScheme.onBackground, colorScheme.onPrimary, Icons.check, colorScheme.surface);
      case _StepState.active:
        return _PulsingMarker(
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.onBackground, width: 4),
            ),
          ),
        );
      case _StepState.future:
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            shape: BoxShape.circle,
            border: Border.all(color: colorScheme.outlineVariant, width: 2),
          ),
        );
    }
  }

  Widget _buildSolidMarker(Color bgColor, Color iconColor, IconData icon, Color borderColor) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Icon(icon, size: 14, color: iconColor),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: DELIVERY AGENT INFO CARD
// -----------------------------------------------------------------------------
class _DeliveryAgentCard extends StatelessWidget {
  const _DeliveryAgentCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(CityOneTheme.spacingContainerPadding),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(CityOneTheme.radiusLg),
        border: Border.all(color: colorScheme.outline),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          // Top Details Row
          Row(
            children: [
              // Avatar with Online Status
              Stack(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHigh,
                      shape: BoxShape.circle,
                      border: Border.all(color: colorScheme.outlineVariant),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuC3HX4eJ42keI1DIEZx9AD90zkW0wtlKqxIbOb16qj0Yrl9rDnZ9pClncdIF6N178a4bGbI2vJFoeKcFuWrB24_FeNQF0g-germ7ma2dtTMTVtPSe5nJIXJnl8XUJTXpZMaMM8Id0tcdaFoKU4UiH7f8moZQIiVA_ZQ00S8aq2ov-V0dlqJgYmn0yKmJftQu_nKywS_w7ACLt2L0nLb9W2P2PT-8IGksr3yaUqTGqorw4UzqZ3KPRj0YoAoTyKqvTKg7H_sfMiOm_g',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(Icons.person, color: colorScheme.secondary),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: const Color(0xFF34A853), // Green status dot
                        shape: BoxShape.circle,
                        border: Border.all(color: colorScheme.surface, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              
              // Text Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Srinivasan", style: textTheme.displaySmall),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text("ID: CY123456", style: textTheme.labelMedium?.copyWith(color: colorScheme.outline)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(width: 4, height: 4, decoration: BoxDecoration(color: colorScheme.outline, shape: BoxShape.circle)),
                        ),
                        Text("4.8", style: textTheme.labelLarge),
                        Icon(Icons.star, size: 14, color: colorScheme.primaryContainer),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text("1500+ deliveries", style: textTheme.labelMedium?.copyWith(color: colorScheme.outline)),
                  ],
                ),
              ),
            ],
          ),
          
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(height: 1),
          ),
          
          // Action Buttons Row
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.call, size: 20),
                  label: const Text("Call"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primaryContainer,
                    foregroundColor: colorScheme.onPrimaryContainer,
                    minimumSize: const Size(0, 48),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chat, size: 20),
                  label: const Text("Message"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.onSurface,
                    side: BorderSide(color: colorScheme.onSurface, width: 2),
                    minimumSize: const Size(0, 48),
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

// -----------------------------------------------------------------------------
// HELPER: ANIMATED PULSING MARKER
// -----------------------------------------------------------------------------
class _PulsingMarker extends StatefulWidget {
  final Widget child;
  const _PulsingMarker({required this.child});

  @override
  State<_PulsingMarker> createState() => _PulsingMarkerState();
}

class _PulsingMarkerState extends State<_PulsingMarker> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _opacityAnimation = Tween<double>(begin: 0.5, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Theme.of(context).colorScheme.onBackground, width: 2),
                  ),
                ),
              ),
            );
          },
        ),
        widget.child,
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// HELPER: MAP GRID BACKGROUND PAINTER
// -----------------------------------------------------------------------------
class _GridPainter extends CustomPainter {
  final Color color;
  _GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    const double spacing = 20.0;
    
    // Draw vertical lines
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    // Draw horizontal lines
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}