import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart';

class ActiveTransitScreen extends StatelessWidget {
  const ActiveTransitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          // MAP BACKGROUND
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Stack(
              children: [
                Container(
                  color: colorScheme.surfaceContainer,
                  child: Image.network(
                    'https://imgs.search.brave.com/ovWPslyjWsQgnRKJ-ajYNQ6SxuTCWSWOXmi-ng5x0YU/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTM4/NDQ1OTMzMy92ZWN0/b3IvbW9udHJlYWwt/cWMtY2l0eS12ZWN0/b3Itcm9hZC1tYXAt/Ymx1ZS10ZXh0Lmpw/Zz9zPTYxMng2MTIm/dz0wJms9MjAmYz1P/S2k1LS1STmxhTGVP/YUM1akJTY3BLbTQ3/emdyc2ZPQ2J6Y3V4/bWdtczQ0PQ',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (_, _, _) => const Center(child: Icon(Icons.map)),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton.small(
                          onPressed: () => Navigator.pop(context),
                          backgroundColor: colorScheme.surface,
                          child: Icon(Icons.arrow_back, color: colorScheme.onSurface),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.shield, color: colorScheme.error),
                          label: const Text("Safety"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.surface,
                            foregroundColor: colorScheme.onSurface,
                            shape: const StadiumBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          shape: BoxShape.circle,
                          border: Border.all(color: colorScheme.surface, width: 2),
                        ),
                        child: Icon(Icons.two_wheeler, color: colorScheme.onSurface),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(color: colorScheme.onSurface, borderRadius: BorderRadius.circular(16)),
                        child: Text("3 min", style: textTheme.labelLarge?.copyWith(color: colorScheme.surface)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // BOTTOM SHEET AREA
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.60,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 30, offset: const Offset(0, -8))],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(width: 48, height: 6, decoration: BoxDecoration(color: colorScheme.outline, borderRadius: BorderRadius.circular(8))),
                  
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        // OTP Box
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: colorScheme.secondary, style: BorderStyle.solid), // No native dashed
                            borderRadius: BorderRadius.circular(12),
                            color: colorScheme.surfaceContainerLowest,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("SHARE OTP TO START RIDE", style: textTheme.labelSmall?.copyWith(color: colorScheme.secondary)),
                                  Text("8492", style: textTheme.displayMedium?.copyWith(letterSpacing: 2.0)),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(color: colorScheme.surfaceContainer, borderRadius: BorderRadius.circular(8)),
                                child: const Icon(Icons.qr_code_2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Driver Info
                        Row(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.bottomCenter,
                              children: [
                                CircleAvatar(
                                  radius: 32,
                                  backgroundImage: const NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuDcrX2vf_5IJe18L4IR8CALEMo_pUFMwPak8Fmfc6k9g0sC0vGCsQmGID67jBVQSJp9-DoUSaam8ms-7B0zAT7Xo-pCTjUMsELs1kRD7Vyqkvpw-XZtlhe5lPbnXqdV3Y-M_tWKJuJlMyO8p0TS908WRV_QvWVtPJY0-Mpz4KW5ZlzOdJ_9s88UE173AbVShy0hHbF6PMrfbFf_YpPkMcgo7_QbdgOptF26IcY6d5E2REx_PRZcgNsaqpFrZgz8S3B_vx0sKZb7i9Q'),
                                ),
                                Positioned(
                                  bottom: -8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(color: colorScheme.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: colorScheme.outline)),
                                    child: Row(
                                      children: [
                                        Text("4.8", style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold)),
                                        Icon(Icons.star, size: 10, color: colorScheme.primaryContainer),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Rajesh Kumar", style: textTheme.displaySmall),
                                  Text("Hero Splendor Plus", style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(color: colorScheme.primaryContainer, borderRadius: BorderRadius.circular(8)),
                              child: Text("UP32 AB 1234", style: textTheme.labelLarge),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        
                        // Timeline Simple Mock
                        _buildTimelineRow(context, "Pickup", "DLF Cyber City, Phase 2", Icons.circle, colorScheme.onSurface),
                        const SizedBox(height: 16),
                        _buildTimelineRow(context, "On the way • 15 mins", "", Icons.navigation, colorScheme.primaryContainer, isHighlight: true),
                        const SizedBox(height: 16),
                        _buildTimelineRow(context, "Drop-off", "Indira Gandhi International Airport", Icons.stop, colorScheme.error),
                      ],
                    ),
                  ),
                  
                  // Action Buttons
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, MediaQuery.of(context).padding.bottom + 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.share),
                            label: const Text("Share Status"),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, 56),
                              foregroundColor: colorScheme.onSurface,
                              side: BorderSide(color: colorScheme.onSurface, width: 2),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.call),
                            label: const Text("Call"),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(0, 56),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineRow(BuildContext context, String title, String subtitle, IconData icon, Color color, {bool isHighlight = false}) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 16),
        Expanded(
          child: isHighlight
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(color: colorScheme.primaryContainer, borderRadius: BorderRadius.circular(16)),
                  child: Text(title, style: textTheme.labelLarge),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: textTheme.labelSmall?.copyWith(color: colorScheme.secondary)),
                    Text(subtitle, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
        ),
      ],
    );
  }
}