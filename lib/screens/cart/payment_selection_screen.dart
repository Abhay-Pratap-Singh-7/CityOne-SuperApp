import 'package:cityoneapp/screens/cart/order_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart';

class PaymentSelectionScreen extends StatefulWidget {
  const PaymentSelectionScreen({super.key});

  @override
  State<PaymentSelectionScreen> createState() => _PaymentSelectionScreenState();
}

class _PaymentSelectionScreenState extends State<PaymentSelectionScreen> {
  String _selectedMethod = "gpay";

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Payment Options",
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
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderConfirmationScreen())),
          child: const Text("Pay ₹140"),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(CityOneTheme.spacingContainerPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Amount Banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(CityOneTheme.radiusMd),
                border: Border.all(color: colorScheme.primary),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Amount to Pay", style: textTheme.bodyLarge),
                  Text("₹140", style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            const SizedBox(height: CityOneTheme.spacingSectionMargin),

            // UPI Section
            Text("UPI", style: textTheme.labelLarge?.copyWith(color: colorScheme.secondary, letterSpacing: 1.0)),
            const SizedBox(height: CityOneTheme.spacingStackGap),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(CityOneTheme.radiusMd),
                border: Border.all(color: colorScheme.outline),
              ),
              child: Column(
                children: [
                  _buildPaymentRadio(
                    value: "gpay",
                    title: "Google Pay",
                    imgUrl: "https://img.icons8.com/?size=100&id=am4ltuIYDpQ5&format=png&color=000000",
                  ),
                  Divider(height: 1, color: colorScheme.outline),
                  _buildPaymentRadio(
                    value: "phonepe",
                    title: "PhonePe",
                    imgUrl: "https://img.icons8.com/?size=100&id=OYtBxIlJwMGA&format=png&color=000000",
                  ),
                ],
              ),
            ),
            const SizedBox(height: CityOneTheme.spacingSectionMargin),

            // Cards Section
            Text("CREDIT / DEBIT CARDS", style: textTheme.labelLarge?.copyWith(color: colorScheme.secondary, letterSpacing: 1.0)),
            const SizedBox(height: CityOneTheme.spacingStackGap),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("Add New Card"),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(64),
                side: BorderSide(color: colorScheme.outline, width: 2),
                backgroundColor: colorScheme.surface,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: CityOneTheme.spacingSectionMargin),

            // Cash Section
            Text("OTHER OPTIONS", style: textTheme.labelLarge?.copyWith(color: colorScheme.secondary, letterSpacing: 1.0)),
            const SizedBox(height: CityOneTheme.spacingStackGap),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(CityOneTheme.radiusMd),
                border: Border.all(color: colorScheme.outline),
              ),
              child: _buildPaymentRadio(
                value: "cod",
                title: "Cash on Delivery",
                subtitle: "Pay at the drop location",
                icon: Icons.payment,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentRadio({
    required String value,
    required String title,
    String? subtitle,
    String? imgUrl,
    IconData? icon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return RadioListTile(
      value: value,
      groupValue: _selectedMethod,
      onChanged: (val) => setState(() => _selectedMethod = val.toString()),
      activeColor: colorScheme.primaryContainer,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Text(title, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
      subtitle: subtitle != null ? Text(subtitle, style: textTheme.labelSmall) : null,
      secondary: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(CityOneTheme.radiusDefault),
          border: Border.all(color: colorScheme.outline),
        ),
        child: imgUrl != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(imgUrl, errorBuilder: (_, __, ___) => const Icon(Icons.payment)),
              )
            : Icon(icon, color: colorScheme.outline),
      ),
    );
  }
}