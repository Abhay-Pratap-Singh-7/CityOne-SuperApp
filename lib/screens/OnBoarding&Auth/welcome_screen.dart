import 'package:cityoneapp/constants/theme.dart';
import 'package:cityoneapp/screens/OnBoarding&Auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // 1. Define all content arrays
  final List<String> images = [
    "assets/welcome_screen/1.png",
    "assets/welcome_screen/2.png",
    "assets/welcome_screen/3.png",
    "assets/welcome_screen/4.png",
  ];

  final List<String> titles = [
    "Instant Groceries",
    "Book Your Ride",
    "Book Hotel Easily",
    "Everything in One App",
  ];

  final List<String> subtitles = [
    "Daily essentials delivered to your doorstep. Fresh quality from local stores.",
    "Quick and safe rides at your fingertips. Travel across the city with ease.",
    "Want a trip? Book Hotels, Apartments, etc from single app.",
    "Groceries, rides, food, and more. CityOne is your ultimate daily companion.",
  ];

  // 2. Remove 'static' so the state resets properly if the widget is rebuilt
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = CityOneTheme.colorScheme;
    final text = CityOneTheme.fontTheme;

    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // ==========================================
            // TOP HEADER: Logo & Skip Button
            // ==========================================
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CityOneTheme.spacingGutter,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "CityOne",
                    style: text.displaySmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.push('/login');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.onSurfaceVariant,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          CityOneTheme.radiusFull,
                        ),
                      ),
                    ),
                    child: Text("Skip", style: text.bodySmall),
                  ),
                ],
              ),
            ),

            // ==========================================
            // CENTER CONTENT: Illustration & Text
            // ==========================================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: CityOneTheme.spacingSectionMargin,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Illustration Area
                    Center(
                      child: Container(
                        width: 280,
                        height: 280,
                        padding: const EdgeInsets.all(16.0),
                        // Dynamically update image
                        child: Image.asset(images[currentIndex]),
                      ),
                    ),

                    const SizedBox(height: 48),

                    // Headline - Dynamically update title
                    Text(titles[currentIndex], style: text.displayLarge),

                    const SizedBox(height: 16),

                    // Subtitle Body - Dynamically update subtitle
                    SizedBox(
                      width: 300,
                      child: Text(
                        subtitles[currentIndex],
                        style: text.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ==========================================
            // BOTTOM CONTROLS: Indicators & Next FAB
            // ==========================================
            Padding(
              padding: const EdgeInsets.only(
                left: CityOneTheme.spacingGutter,
                right: CityOneTheme.spacingGutter,
                bottom: 40.0,
                top: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 3. Dynamic Progress Indicators
                  Row(
                    children: List.generate(
                      images.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(
                          right: CityOneTheme.spacingBase,
                        ),
                        child: _buildIndicator(isActive: index == currentIndex),
                      ),
                    ),
                  ),

                  // Next Action Button
                  Material(
                    color: colorScheme.onSurface,
                    shape: const CircleBorder(),
                    elevation: 8.0,
                    shadowColor: Colors.black26,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          // 4. Safe navigation check to prevent array out-of-bounds error
                          if (currentIndex < images.length - 1) {
                            currentIndex++;
                          } else {
                            context.push('/login');
                          }
                        });
                      },
                      customBorder: const CircleBorder(),
                      child: SizedBox(
                        width: 64,
                        height: 64,
                        child: Icon(
                          // Change icon to a checkmark on the very last screen
                          currentIndex == images.length - 1
                              ? Icons.check
                              : Icons.arrow_forward,
                          color: colorScheme.onPrimary,
                          size: 32,
                        ),
                      ),
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

  Widget _buildIndicator({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 32 : 8,
      decoration: BoxDecoration(
        color: isActive
            ? CityOneTheme.colorScheme.primaryContainer
            : const Color.fromARGB(75, 0, 0, 0),
        borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
      ),
    );
  }
}
