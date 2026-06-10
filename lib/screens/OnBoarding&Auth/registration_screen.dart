import 'package:cityoneapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';import 'package:flutter/gestures.dart';
import 'package:cityoneapp/constants/theme.dart'; // Adjust path if needed

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _referralController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _referralController.dispose();
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
                    left: CityOneTheme
                        .spacingBase, // Slight offset to match HTML -ml-3 visual
                    top: CityOneTheme.spacingSectionMargin,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
                    onPressed: () => Navigator.pop(context),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: const CircleBorder(),
                    ),
                  ),
                ),

                // Wrap the rest in Expanded + SingleChildScrollView to handle keyboard
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: CityOneTheme.spacingSectionMargin,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),

                        // --- Typography ---
                        Text(
                          "Tell us about yourself",
                          style: textTheme.displayMedium?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "We need a few details to get your account set up and ready to go.",
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // --- Form Fields ---
                        _buildPillTextField(
                          context: context,
                          label: "Full Name",
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                        ),
                        const SizedBox(
                          height: CityOneTheme.spacingSectionMargin,
                        ),

                        _buildPillTextField(
                          context: context,
                          label: "Email Address",
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: CityOneTheme.spacingSectionMargin,
                        ),

                        _buildPillTextField(
                          context: context,
                          label: "Referral Code (Optional)",
                          controller: _referralController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.characters,
                        ),

                        // Extra spacing before bottom items
                        const SizedBox(height: 48),

                        // --- Action Button ---
                        ElevatedButton(
                          onPressed: () {
                            context.go('/home');
                          },
                          child: const Text("Sign Up"),
                        ),

                        const SizedBox(height: 24),

                        // --- Terms & Privacy Policy ---
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                              children: [
                                const TextSpan(
                                  text: "By signing up, you agree to our ",
                                ),
                                TextSpan(
                                  text: "Terms",
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle Terms tap
                                    },
                                ),
                                const TextSpan(text: " and "),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle Privacy Policy tap
                                    },
                                ),
                                const TextSpan(text: "."),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 32), // Bottom padding
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build the custom pill-shaped text fields
  Widget _buildPillTextField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Custom borders to match HTML's .rounded-full
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
      borderSide: BorderSide(
        color: colorScheme.onSurfaceVariant, // #EEEEEE
        width: 1.0,
      ),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
      borderSide: BorderSide(
        color: colorScheme.onSurface, // #000000
        width: 2.0,
      ),
    );

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),

        // Apply custom borders
        border: border,
        enabledBorder: border,
        focusedBorder: focusedBorder,

        // Label styling to match floating label logic
        labelStyle: textTheme.bodyLarge?.copyWith(color: colorScheme.secondary),
        floatingLabelStyle: textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          backgroundColor: colorScheme.surface, // Gives it that cut-out look
        ),
      ),
    );
  }
}
