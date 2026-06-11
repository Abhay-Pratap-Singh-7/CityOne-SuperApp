import 'dart:ui';
import 'package:cityoneapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorScheme.surface.withOpacity(0.8),
        surfaceTintColor: Colors.transparent,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Confirm Booking",
          style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900, color: colorScheme.primary),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: colorScheme.outline, height: 1.0),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(border: Border(top: BorderSide(color: colorScheme.outline))),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: colorScheme.surface.withOpacity(0.9),
              padding: EdgeInsets.fromLTRB(
                CityOneTheme.spacingGutter,
                16,
                CityOneTheme.spacingGutter,
                MediaQuery.of(context).padding.bottom + 16,
              ),
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeDashboardScreen())),
                icon: const Icon(Icons.lock, size: 20),
                label: const Text("Pay \$515.50"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(CityOneTheme.spacingGutter),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stay Summary Bento Card
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(CityOneTheme.radiusLg),
                border: Border.all(color: colorScheme.surfaceContainer),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))],
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  // Hotel Info
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colorScheme.outline,
                            image: const DecorationImage(
                              image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCmAZVU8N-zBtT3ec_ps3Q8oLVAMOB1ph40yyYznYtbFkyJloEdI_rcxw92ummD8g3TWBUcKBm55haiIHAzvFsBKbdD1I3D6b9sIwKJQxrBKuCZFr6Y9w4vaQGeGIxhqT9qPzFgb7qMLVl-jiT_vI7mto4k_25b_eCaDUO-W-LN8r5yOkU_wsvb0_sHF8xBjXTOrthHqRsXMHBUTvujYS1xG0Bn0nY5YWYlaKB12q-SVkFwM6T3kEqcLgzlrGXDefkksOdw-QtGJy4'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("The Grand Horizon", style: textTheme.displaySmall),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.location_on, size: 14, color: colorScheme.secondary),
                                  const SizedBox(width: 4),
                                  Text("Downtown Metropolis", style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: colorScheme.surfaceContainer),
                  // Dates Row
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("CHECK-IN", style: textTheme.labelSmall?.copyWith(color: colorScheme.secondary, letterSpacing: 1.0)),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_month, size: 16, color: colorScheme.primary),
                                    const SizedBox(width: 8),
                                    Text("Oct 12", style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text("3:00 PM", style: textTheme.labelSmall?.copyWith(color: colorScheme.secondary)),
                              ],
                            ),
                          ),
                        ),
                        Container(width: 1, color: colorScheme.surfaceContainer),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("CHECK-OUT", style: textTheme.labelSmall?.copyWith(color: colorScheme.secondary, letterSpacing: 1.0)),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.event_busy, size: 16, color: colorScheme.primary),
                                    const SizedBox(width: 8),
                                    Text("Oct 15", style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text("11:00 AM", style: textTheme.labelSmall?.copyWith(color: colorScheme.secondary)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: colorScheme.surfaceContainer),
                  // Guests
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Guests", style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: colorScheme.surfaceContainerLow, borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            children: [
                              Icon(Icons.person, size: 16, color: colorScheme.onSurface),
                              const SizedBox(width: 6),
                              Text("2 Adults, 1 Child", style: textTheme.labelLarge),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: CityOneTheme.spacingSectionMargin),
            
            // Guest Details Form (Soft Neo-morphic inputs)
            Text("Guest Details", style: textTheme.displaySmall),
            const SizedBox(height: CityOneTheme.spacingStackGap),
            
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Full Name"),
            ),
            const SizedBox(height: CityOneTheme.spacingStackGap),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: "Email Address"),
            ),
            const SizedBox(height: CityOneTheme.spacingStackGap),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),
            
            const SizedBox(height: CityOneTheme.spacingSectionMargin),
            
            // Price Breakdown
            const Divider(),
            const SizedBox(height: 16),
            Text("Price Summary", style: textTheme.displaySmall),
            const SizedBox(height: 16),
            
            _buildPriceRow("3 Nights (Base Price)", "\$450.00", textTheme, colorScheme),
            const SizedBox(height: 8),
            _buildPriceRow("Taxes & Fees", "\$65.50", textTheme, colorScheme),
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(color: colorScheme.surfaceContainerHighest),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total", style: textTheme.displaySmall),
                Text("\$515.50", style: textTheme.displaySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String amount, TextTheme textTheme, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary)),
        Text(amount, style: textTheme.bodyLarge),
      ],
    );
  }
}