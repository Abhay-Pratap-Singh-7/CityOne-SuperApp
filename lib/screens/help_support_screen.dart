import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: colorScheme.onSurface), onPressed: () => Navigator.pop(context)),
        title: Text("CityOne", style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900)),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Input
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "How can we help you?",
                      prefixIcon: Icon(Icons.search, color: colorScheme.outline),
                      fillColor: colorScheme.surfaceContainer,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(CityOneTheme.radiusFull), borderSide: BorderSide.none),
                    ),
                  ),
                ),
                
                // Quick Topics
                Text("Quick Topics", style: textTheme.displaySmall),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    _TopicCard(icon: Icons.local_mall, title: "Order Issue", bgColor: colorScheme.errorContainer, iconColor: colorScheme.error),
                    _TopicCard(icon: Icons.credit_card_off, title: "Payment Failed", bgColor: colorScheme.surfaceContainerHigh, iconColor: colorScheme.onSurface),
                    _TopicCard(icon: Icons.settings, title: "App Settings", bgColor: colorScheme.surfaceContainerHigh, iconColor: colorScheme.onSurface),
                    _TopicCard(icon: Icons.shield, title: "Safety", bgColor: colorScheme.surfaceContainerHigh, iconColor: colorScheme.onSurface),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // FAQs using ExpansionTile
                Text("Frequently Asked Questions", style: textTheme.displaySmall),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: colorScheme.surfaceContainerHighest),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      _FaqTile(
                        question: "How do I cancel my order?",
                        answer: "You can cancel your order from the 'Active Orders' screen within 5 minutes of placing it. Tap the order, scroll down, and select 'Cancel Order'. If the driver has already picked up your items, cancellation may not be possible.",
                      ),
                      Divider(height: 1, color: colorScheme.surfaceContainerHighest),
                      _FaqTile(
                        question: "Where is my refund?",
                        answer: "Refunds typically process within 3-5 business days depending on your bank. If it has been longer than 5 days, please contact our support team with your order ID.",
                      ),
                      Divider(height: 1, color: colorScheme.surfaceContainerHighest),
                      _FaqTile(
                        question: "How to change delivery address?",
                        answer: "You can edit your delivery address before checkout. If you need to change it after placing an order, contact your driver directly through the app immediately. Major changes may require cancelling and re-ordering.",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 120), // Padding for floating chat button
              ],
            ),
          ),
          
          // Floating Chat Button
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 24,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 8))],
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F3131), // inverseSurface
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  elevation: 0,
                ),
                child: Row(
                  children: [
                    CircleAvatar(backgroundColor: colorScheme.surfaceContainer, child: Icon(Icons.chat, color: colorScheme.onSurface)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Chat with Support", style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                          Text("Typical response: Under 2 mins", style: textTheme.bodySmall?.copyWith(color: Colors.white70)),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color bgColor;
  final Color iconColor;

  const _TopicCard({required this.icon, required this.title, required this.bgColor, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).colorScheme.surfaceContainerHighest),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 16, backgroundColor: bgColor, child: Icon(icon, color: iconColor, size: 16,)),
          const SizedBox(height: 4),
          Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqTile({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent), // removes default border
      child: ExpansionTile(
        title: Text(question, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.add), // Native ExpansionTile handles rotation/swap if configured, but default expand_more is cleaner. Keeping add to match HTML.
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          Text(answer, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.secondary)),
        ],
      ),
    );
  }
}