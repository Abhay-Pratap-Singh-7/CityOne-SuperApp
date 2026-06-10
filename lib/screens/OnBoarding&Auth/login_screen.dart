import 'dart:ui';
import 'package:cityoneapp/screens/OnBoarding&Auth/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';import 'package:cityoneapp/constants/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = CityOneTheme.colorScheme;
    final text = CityOneTheme.fontTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ==========================================
          // 2. MAIN CONTENT
          // ==========================================
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Top Header: Back Button ---
                Padding(
                  padding: const EdgeInsets.only(
                    left: CityOneTheme.spacingGutter,
                    top: CityOneTheme.spacingBase,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      CityOneTheme.radiusFull,
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 4.0,
                        sigmaY: 4.0,
                      ), // backdrop-blur-sm
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: colorScheme.surface.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: colorScheme.onSurface,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 48), // Spacing below header
                // --- Typography & Input Field ---
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: CityOneTheme.spacingGutter,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Headline
                        Text(
                          "Enter your mobile number",
                          style: text.displayLarge?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Sub-headline
                        Text(
                          "A 4-digit OTP will be sent on SMS.",
                          style: text.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),

                        const SizedBox(
                          height: CityOneTheme.spacingSectionMargin,
                        ),

                        // Inputs Row
                        Row(
                          children: [
                            // Country Code Component
                            _buildCountryCodeSelector(context),

                            const SizedBox(width: 12), // gap-3
                            // Phone Number Input
                            Expanded(child: _buildPhoneInput(context)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // ==========================================
                // 3. BOTTOM ACTION AREA
                // ==========================================
                Padding(
                  padding: const EdgeInsets.only(
                    left: CityOneTheme.spacingGutter,
                    right: CityOneTheme.spacingGutter,
                    bottom: 40.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/otp');
                    },
                    child: const Text("Continue"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for the Country Code Dropdown
  Widget _buildCountryCodeSelector(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0), // backdrop-blur-md
        child: Container(
          height: 56, // h-14
          padding: const EdgeInsets.symmetric(horizontal: 24), // px-6
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
            border: Border.all(color: colorScheme.onSurfaceVariant, width: 1.0),
          ),
          child: Row(
            children: [
              Text(
                "+91",
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                color: colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for the Phone Number Text Field
  Widget _buildPhoneInput(BuildContext context) {
    final colorScheme = CityOneTheme.colorScheme;
    final text = CityOneTheme.fontTheme;

    // Using explicit pill borders for this screen instead of the global 8px corners
    final pillBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
      borderSide: BorderSide(color: colorScheme.onSurfaceVariant, width: 1.0),
    );

    final focusedPillBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
      borderSide: BorderSide(
        color: colorScheme.onSurface,
        width: 2.0, // Focus state gets the 2px black border
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0), // backdrop-blur-md
        child: TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          style: text.bodyLarge?.copyWith(
            color: colorScheme.onSurface,
            letterSpacing: 2.4,
          ),
          decoration: InputDecoration(
            hintText: "Mobile Number",
            hintStyle: text.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),

            // Borders
            border: pillBorder,
            enabledBorder: pillBorder,
            focusedBorder: focusedPillBorder,
          ),
        ),
      ),
    );
  }
}
