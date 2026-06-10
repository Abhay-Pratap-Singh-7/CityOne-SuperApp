import 'dart:async';
import 'package:cityoneapp/screens/OnBoarding&Auth/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';import 'package:flutter/services.dart';
import 'package:cityoneapp/constants/theme.dart'; // Adjust path if needed

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  // Logic: Timer state
  int _timeLeft = 30;
  Timer? _timer;
  bool _canResend = false;

  // Logic: OTP Input state
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _timeLeft = 30;
      _canResend = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _verifyOtp() {
    String otp = _controllers.map((c) => c.text).join();
    if (otp.length == 4) {
      context.pushReplacement('/register');
    } else {
      print("Incomplete OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // ==========================================
            // TOP HEADER: Back Button
            // ==========================================
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CityOneTheme.spacingBase,
                vertical: CityOneTheme.spacingBase,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
                  onPressed: () => Navigator.pop(context),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: const CircleBorder(),
                  ),
                ),
              ),
            ),

            // ==========================================
            // MAIN CONTENT
            // ==========================================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: CityOneTheme.spacingSectionMargin,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: CityOneTheme.spacingSectionMargin),

                    // --- Typography ---
                    Text(
                      "Enter OTP",
                      style: textTheme.displayLarge?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: CityOneTheme.spacingBase),
                    Text(
                      "We have sent an OTP to your mobile number.",
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.secondary,
                      ),
                    ),

                    const SizedBox(height: 48),

                    // --- OTP Inputs ---
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          4,
                          (index) => _buildOtpBox(index, context),
                        ),
                      ),
                    ),

                    const Spacer(), // Pushes the bottom content down
                    // --- Resend Timer/Link ---
                    Center(
                      child: TextButton(
                        onPressed: _canResend ? _startTimer : null,
                        style: TextButton.styleFrom(
                          foregroundColor: _canResend
                              ? colorScheme.primaryContainer
                              : colorScheme.onSurface,
                        ),
                        child: Text(
                          _canResend
                              ? "Resend OTP"
                              : "Resend OTP in 00:${_timeLeft.toString().padLeft(2, '0')}",
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: _canResend
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _canResend
                                ? colorScheme.primaryContainer
                                : colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: CityOneTheme.spacingSectionMargin),

                    // --- Verify Button ---
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: ElevatedButton(
                        onPressed: _verifyOtp,
                        child: const Text("Verify"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build individual OTP input boxes
  Widget _buildOtpBox(int index, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Defines the 1.5rem (24px) border radius from the HTML
    final borderRadius = BorderRadius.circular(CityOneTheme.radiusXl);

    return SizedBox(
      width: 72,
      height: 72,
      child: KeyboardListener(
        focusNode: FocusNode(), // Dummy node for capturing raw keyboard events
        onKeyEvent: (event) {
          // Handle backspace when the box is already empty to jump back
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace &&
              _controllers[index].text.isEmpty &&
              index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: textTheme.displayMedium?.copyWith(
            color: colorScheme.onSurface,
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            if (value.length == 1 && index < 3) {
              _focusNodes[index + 1].requestFocus();
            } else if (value.isEmpty && index > 0) {
              _focusNodes[index - 1].requestFocus();
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: colorScheme.surface,
            contentPadding: EdgeInsets.zero,

            // Unfocused Border
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(
                color: colorScheme
                    .onSurfaceVariant, // Matches surface-container-highest
                width: 1.0,
              ),
            ),

            // Focused Border
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: colorScheme.onSurface, width: 2.0),
            ),
          ),
        ),
      ),
    );
  }
}
