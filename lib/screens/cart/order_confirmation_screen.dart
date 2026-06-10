import 'package:cityoneapp/screens/cart/tracking_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart';
import 'dart:math' as math;

class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({super.key});

  @override
  State<OrderConfirmationScreen> createState() => _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // CSS: scaleIn
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5, curve: Curves.elasticOut)),
    );

    // CSS: fadeIn
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.6, curve: Curves.easeOut)),
    );

    // CSS: slideUp
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          // Basic Confetti implementation mimicking the JS loop
          ...List.generate(20, (index) => _StaticConfetti()),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(CityOneTheme.spacingSectionMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  
                  // Success Graphic
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: CircleAvatar(
                      radius: 64,
                      backgroundColor: colorScheme.onSurface,
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: Icon(Icons.check, size: 80, color: colorScheme.onPrimary),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Text Content
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: Column(
                        children: [
                          Text(
                            "Order Placed Successfully!",
                            textAlign: TextAlign.center,
                            style: textTheme.displayMedium,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Order #CY123456 • Arriving in 15 mins",
                            textAlign: TextAlign.center,
                            style: textTheme.bodyLarge?.copyWith(color: colorScheme.secondary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Action Buttons
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderTrackingScreen())),
                            child: const Text("Track Order"),
                          ),
                          const SizedBox(height: CityOneTheme.spacingStackGap),
                          OutlinedButton(
                            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: colorScheme.onSurface, width: 2),
                            ),
                            child: const Text("Back to Home"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Basic static confetti to mimic the scattered look without heavy logic
class _StaticConfetti extends StatelessWidget {
  final double top = math.Random().nextDouble() * 800;
  final double left = math.Random().nextDouble() * 400;
  final bool isCircle = math.Random().nextBool();
  final double size = math.Random().nextDouble() * 8 + 4;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Transform.rotate(
        angle: math.Random().nextDouble() * 3.14,
        child: Container(
          width: size,
          height: isCircle ? size : size / 2,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          ),
        ),
      ),
    );
  }
}