import 'package:cityoneapp/screens/cart/address_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:cityoneapp/constants/theme.dart'; // Adjust path if needed

class ReviewCartScreen extends StatefulWidget {
  const ReviewCartScreen({super.key});

  @override
  State<ReviewCartScreen> createState() => _ReviewCartScreenState();
}

class _ReviewCartScreenState extends State<ReviewCartScreen> {
  // Mock Cart State
  List<Map<String, dynamic>> cartItems = [
    {
      "id": "1",
      "name": "Shimla Apples, 500g",
      "price": 140,
      "qty": 1,
      "img": "19"
    },
    {
      "id": "2",
      "name": "Organic Bananas, 1 Dozen",
      "price": 80,
      "qty": 2,
      "img": "20"
    },
  ];

  final int handlingFee = 5;

  void _increaseQty(int index) {
    setState(() {
      cartItems[index]["qty"]++;
    });
  }

  void _decreaseQty(int index) {
    setState(() {
      if (cartItems[index]["qty"] > 1) {
        cartItems[index]["qty"]--;
      }
    });
  }

  int get _itemTotal {
    int total = 0;
    for (var item in cartItems) {
      total += (item["price"] as int) * (item["qty"] as int);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final int toPay = _itemTotal + handlingFee;

    return Scaffold(
      backgroundColor: Colors.white,
      
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
          "Review Cart",
          style: textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w900,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: colorScheme.outline,
            height: 1.0,
          ),
        ),
      ),

      // ==========================================
      // TRANSACTIONAL BOTTOM BAR
      // ==========================================
      bottomNavigationBar: _TransactionalBottomBar(toPay: toPay),

      // ==========================================
      // MAIN CONTENT SCROLL CANVAS
      // ==========================================
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: CityOneTheme.spacingContainerPadding,
          vertical: CityOneTheme.spacingSectionMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- DELIVERY BANNER ---
            const _DeliveryBanner(),
            const SizedBox(height: CityOneTheme.spacingSectionMargin),

            // --- CART ITEMS ---
            Text("Items", style: textTheme.displaySmall),
            const SizedBox(height: CityOneTheme.spacingBase),
            
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartItems.length,
              separatorBuilder: (_, _) => const SizedBox(height: CityOneTheme.spacingStackGap),
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return _CartItemCard(
                  name: item["name"],
                  price: item["price"],
                  qty: item["qty"],
                  img: item["img"],
                  onIncrease: () => _increaseQty(index),
                  onDecrease: () => _decreaseQty(index),
                );
              },
            ),
            
            const SizedBox(height: 8),
            
            // --- ADD MORE ITEMS ACTION ---
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_circle, size: 20),
              label: const Text("Add More Items"),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                side: BorderSide(color: colorScheme.outline, width: 2),
                foregroundColor: colorScheme.onSurface,
              ),
            ),
            
            const SizedBox(height: CityOneTheme.spacingSectionMargin),

            // --- BILL DETAILS ---
            _BillDetailsCard(
              itemTotal: _itemTotal,
              handlingFee: handlingFee,
              toPay: toPay,
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: DELIVERY BANNER
// -----------------------------------------------------------------------------
class _DeliveryBanner extends StatelessWidget {
  const _DeliveryBanner();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withOpacity(0.3), // Matches light yellow bg
        borderRadius: BorderRadius.circular(CityOneTheme.radiusMd), // rounded-xl
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: colorScheme.surface,
            child: Icon(Icons.location_on, color: colorScheme.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivering to",
                  style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
                Text(
                  "Home - Lucknow",
                  style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: Text(
              "CHANGE",
              style: textTheme.labelLarge?.copyWith(letterSpacing: 1.0, color: colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: CART ITEM CARD
// -----------------------------------------------------------------------------
class _CartItemCard extends StatelessWidget {
  final String name;
  final int price;
  final int qty;
  final String img;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const _CartItemCard({
    required this.name,
    required this.price,
    required this.qty,
    required this.img,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(CityOneTheme.radiusMd), // rounded-xl
        border: Border.all(color: colorScheme.outline),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(CityOneTheme.radiusDefault),
              border: Border.all(color: colorScheme.outline),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              'http://googleusercontent.com/profile/picture/$img',
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Icon(Icons.image, color: colorScheme.secondary),
            ),
          ),
          const SizedBox(width: 16),
          
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text("₹$price", style: textTheme.bodyLarge),
              ],
            ),
          ),
          
          // Stepper Control
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
              border: Border.all(color: colorScheme.outline),
            ),
            child: Row(
              children: [
                _StepperButton(
                  icon: Icons.remove, 
                  onTap: onDecrease, 
                  color: colorScheme.onSurface,
                  bgColor: colorScheme.surfaceContainer,
                ),
                SizedBox(
                  width: 32,
                  child: Text(
                    "$qty",
                    textAlign: TextAlign.center,
                    style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                _StepperButton(
                  icon: Icons.add, 
                  onTap: onIncrease, 
                  color: colorScheme.primary,
                  bgColor: colorScheme.primaryContainer,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  final Color bgColor;

  const _StepperButton({
    required this.icon,
    required this.onTap,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
          child: Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            child: Icon(icon, size: 18, color: color),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: BILL DETAILS CARD
// -----------------------------------------------------------------------------
class _BillDetailsCard extends StatelessWidget {
  final int itemTotal;
  final int handlingFee;
  final int toPay;

  const _BillDetailsCard({
    required this.itemTotal,
    required this.handlingFee,
    required this.toPay,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(CityOneTheme.radiusMd),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bill Details",
            style: textTheme.displaySmall,
          ),
          const Divider(height: 24),
          
          _BillRow(label: "Item Total", value: "₹$itemTotal", textTheme: textTheme),
          const SizedBox(height: 12),
          
          // Delivery Fee with FREE badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.local_shipping, size: 16, color: colorScheme.secondary),
                  const SizedBox(width: 8),
                  Text("Delivery Fee", style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                ],
              ),
              Row(
                children: [
                  Text(
                    "₹40",
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.secondary,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(CityOneTheme.radiusFull),
                    ),
                    child: Text(
                      "FREE",
                      style: textTheme.labelLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          _BillRow(
            label: "Handling Fee", 
            value: "₹$handlingFee", 
            icon: Icons.shopping_bag, 
            textTheme: textTheme, 
            colorScheme: colorScheme
          ),
          
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(height: 1,), // Custom dashed border below
          ),
          
          // Custom Dashed Divider + Total
          Container(
            padding: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: colorScheme.outline, style: BorderStyle.solid)), // Flutter doesn't have dashed natively without custom painters, using solid for now
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "To Pay",
                  style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  "₹$toPay",
                  style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BillRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final TextTheme textTheme;
  final ColorScheme? colorScheme;

  const _BillRow({
    required this.label,
    required this.value,
    this.icon,
    required this.textTheme,
    this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: colorScheme?.secondary),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: icon != null ? colorScheme?.onSurfaceVariant : colorScheme?.onSurfaceVariant,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT: FIXED BOTTOM ACTION BAR
// -----------------------------------------------------------------------------
class _TransactionalBottomBar extends StatelessWidget {
  final int toPay;

  const _TransactionalBottomBar({required this.toPay});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.fromLTRB(
        CityOneTheme.spacingContainerPadding,
        CityOneTheme.spacingContainerPadding,
        CityOneTheme.spacingContainerPadding,
        MediaQuery.of(context).padding.bottom + CityOneTheme.spacingContainerPadding,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(top: BorderSide(color: colorScheme.outline)),
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddressPickerScreen())),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onSurface,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select Address & Pay",
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, size: 20),
          ],
        ),
      ),
    );
  }
}